//
//  OnboardingView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentStep = 0
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

            VStack(spacing: 30) {
                // Progress indicator
                HStack(spacing: 8) {
                    ForEach(0..<2) { index in
                        Capsule()
                            .fill(index <= currentStep ? Color.white : Color.white.opacity(0.3))
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal, 60)
                .padding(.top, 60)

                Spacer()

                // Content based on current step
                if currentStep == 0 {
                    NameInputView(childName: $childName)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                } else {
                    GenderSelectionView(selectedGender: $selectedGender)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }

                Spacer()

                // Continue button
                Button(action: {
                    if currentStep == 0 {
                        if !childName.isEmpty {
                            withAnimation {
                                currentStep = 1
                            }
                        }
                    } else {
                        if !selectedGender.isEmpty {
                            appState.childName = childName
                            appState.childGender = selectedGender
                            appState.navigateTo(.paywall)
                        }
                    }
                }) {
                    Text("Continue")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            (currentStep == 0 ? !childName.isEmpty : !selectedGender.isEmpty)
                                ? LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(16)
                        .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
                }
                .disabled(currentStep == 0 ? childName.isEmpty : selectedGender.isEmpty)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

struct NameInputView: View {
    @Binding var childName: String

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundColor(.yellow)

            Text("What's your child's name?")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            TextField("Enter name", text: $childName)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .padding()
                .frame(height: 56)
                .background(Color.white.opacity(0.15))
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
        }
    }
}

struct GenderSelectionView: View {
    @Binding var selectedGender: String

    let genders = [
        ("Boy", "👦", Color.blue),
        ("Girl", "👧", Color.pink),
        ("Other", "⭐", Color.purple)
    ]

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 60))
                .foregroundColor(.yellow)

            Text("Tell us about your child")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            VStack(spacing: 16) {
                ForEach(genders, id: \.0) { gender in
                    Button(action: {
                        selectedGender = gender.0
                    }) {
                        HStack {
                            Text(gender.1)
                                .font(.system(size: 32))

                            Text(gender.0)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)

                            Spacer()

                            if selectedGender == gender.0 {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(
                            selectedGender == gender.0
                                ? gender.2.opacity(0.6)
                                : Color.white.opacity(0.15)
                        )
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedGender == gender.0 ? Color.white : Color.clear, lineWidth: 2)
                        )
                    }
                }
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
