//
//  SplashScreen.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var shootingStarOffset: CGFloat = -200
    @State private var shootingStarOpacity: Double = 0

    var body: some View {
        ZStack {
            // Dark night sky background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.05, green: 0.05, blue: 0.2), Color(red: 0.1, green: 0.05, blue: 0.15)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Stars in background
            ForEach(0..<30, id: \.self) { _ in
                Circle()
                    .fill(Color.white.opacity(Double.random(in: 0.3...0.8)))
                    .frame(width: CGFloat.random(in: 1...3), height: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
            }

            // Shooting star
            ShootingStarView()
                .offset(x: shootingStarOffset, y: shootingStarOffset / 2)
                .opacity(shootingStarOpacity)
        }
        .onAppear {
            animateShootingStar()
        }
    }

    private func animateShootingStar() {
        withAnimation(.easeIn(duration: 0.5).delay(0.3)) {
            shootingStarOpacity = 1
        }

        withAnimation(.easeOut(duration: 1.5).delay(0.3)) {
            shootingStarOffset = UIScreen.main.bounds.width + 200
        }

        // Navigate to landing page after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            appState.navigateTo(.landing)
        }
    }
}

struct ShootingStarView: View {
    var body: some View {
        ZStack {
            // Star trail
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0), Color.white.opacity(0.8), Color.yellow.opacity(0.6)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 100, height: 2)
            .blur(radius: 2)

            // Star head
            Circle()
                .fill(Color.white)
                .frame(width: 8, height: 8)
                .overlay(
                    Circle()
                        .fill(Color.yellow.opacity(0.6))
                        .blur(radius: 4)
                        .frame(width: 16, height: 16)
                )
                .offset(x: 50)
        }
        .rotationEffect(.degrees(-30))
    }
}

#Preview {
    SplashScreen()
        .environmentObject(AppState())
}
