//
//  OnboardingView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var childName = ""
    @State private var selectedGender = ""

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.1, blue: 0.25)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 40) {
                    // Star icon
                    Image(systemName: "star.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.yellow)
                        .padding(.top, 60)

                    // Name input section
                    VStack(spacing: 16) {
                        Text("What's your child's name?")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        TextField("Enter name", text: $childName)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .padding()
                            .frame(height: 56)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal, 40)

                    // Gender selection section
                    VStack(spacing: 20) {
                        Text("Gender")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 40)

                        HStack(spacing: 20) {
                            // Boy option
                            GenderOutlineButton(
                                icon: "figure.child",
                                label: "Boy",
                                isSelected: selectedGender == "Boy",
                                color: .blue
                            ) {
                                selectedGender = "Boy"
                            }

                            // Girl option
                            GenderOutlineButton(
                                icon: "figure.child",
                                label: "Girl",
                                isSelected: selectedGender == "Girl",
                                color: .pink
                            ) {
                                selectedGender = "Girl"
                            }
                        }
                        .padding(.horizontal, 40)
                    }

                    Spacer()
                        .frame(height: 40)

                    // Continue button
                    Button(action: {
                        if !childName.isEmpty && !selectedGender.isEmpty {
                            appState.childName = childName
                            appState.childGender = selectedGender
                            appState.navigateTo(.paywall)
                        }
                    }) {
                        Text("Continue")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                (!childName.isEmpty && !selectedGender.isEmpty)
                                    ? LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                    : LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
                    }
                    .disabled(childName.isEmpty || selectedGender.isEmpty)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct GenderOutlineButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                // Figure outline
                ZStack {
                    Circle()
                        .stroke(isSelected ? color : Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: 100, height: 100)
                        .background(
                            Circle()
                                .fill(isSelected ? color.opacity(0.2) : Color.clear)
                        )

                    Image(systemName: icon)
                        .font(.system(size: 50))
                        .foregroundColor(isSelected ? color : .white.opacity(0.5))
                }

                Text(label)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? color : .white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(isSelected ? 0.1 : 0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? color : Color.clear, lineWidth: 2)
            )
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
