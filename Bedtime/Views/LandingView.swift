//
//  LandingView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var appState: AppState
    @State private var titleOpacity: Double = 0
    @State private var buttonOpacity: Double = 0
    @State private var starScale: CGFloat = 1.2
    @State private var starRotation: Double = 0

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.1, blue: 0.25)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Single star (continues from shooting star)
                Image(systemName: "star.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.yellow)
                    .shadow(color: .yellow.opacity(0.8), radius: 15)
                    .scaleEffect(starScale)
                    .rotationEffect(.degrees(starRotation))

                // Title
                VStack(spacing: 12) {
                    Text("Bedtime")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("Stories for your child")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                }
                .opacity(titleOpacity)

                Spacer()

                // Get Started button
                Button(action: {
                    appState.navigateTo(.onboarding)
                }) {
                    Text("Get Started")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                        .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
                }
                .padding(.horizontal, 40)
                .opacity(buttonOpacity)

                Spacer()
                    .frame(height: 60)
            }
        }
        .onAppear {
            // Subtle settling animation from the shooting star
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                starScale = 1.0
            }

            // Gentle rotation for a magical effect
            withAnimation(.easeOut(duration: 1.0)) {
                starRotation = 360
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                titleOpacity = 1.0
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
                buttonOpacity = 1.0
            }
        }
    }
}

#Preview {
    LandingView()
        .environmentObject(AppState())
}
