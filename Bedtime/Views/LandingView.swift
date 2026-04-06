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
    @State private var moonScale: CGFloat = 0.5

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

                // Moon illustration
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.9))
                        .frame(width: 120, height: 120)
                        .shadow(color: .yellow.opacity(0.6), radius: 20)

                    // Craters on moon
                    Circle()
                        .fill(Color.yellow.opacity(0.6))
                        .frame(width: 20, height: 20)
                        .offset(x: -15, y: -10)

                    Circle()
                        .fill(Color.yellow.opacity(0.6))
                        .frame(width: 15, height: 15)
                        .offset(x: 20, y: 15)
                }
                .scaleEffect(moonScale)

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
            withAnimation(.easeOut(duration: 0.8)) {
                moonScale = 1.0
                titleOpacity = 1.0
            }

            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                buttonOpacity = 1.0
            }
        }
    }
}

#Preview {
    LandingView()
        .environmentObject(AppState())
}
