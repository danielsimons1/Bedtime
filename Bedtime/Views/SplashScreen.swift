//
//  SplashScreen.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var shootingStarPosition: CGPoint = CGPoint(x: -200, y: 100)
    @State private var shootingStarOpacity: Double = 0
    @State private var trailOpacity: Double = 1
    @State private var starRotation: Double = -30

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
            ShootingStarView(trailOpacity: trailOpacity)
                .rotationEffect(.degrees(starRotation))
                .position(shootingStarPosition)
                .opacity(shootingStarOpacity)
        }
        .onAppear {
            animateShootingStar()
        }
    }

    private func animateShootingStar() {
        let screenWidth = UIScreen.main.bounds.width
        let finalX = screenWidth / 2
        let finalY: CGFloat = 200

        // Fade in
        withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
            shootingStarOpacity = 1
        }

        // Move across and down to center position
        withAnimation(.easeInOut(duration: 1.8).delay(0.3)) {
            shootingStarPosition = CGPoint(x: finalX, y: finalY)
        }

        // Rotate to upright position and fade out trail
        withAnimation(.easeOut(duration: 0.6).delay(1.7)) {
            starRotation = 0
            trailOpacity = 0
        }

        // Navigate to landing page after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            appState.navigateTo(.landing)
        }
    }
}

struct ShootingStarView: View {
    var trailOpacity: Double

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
            .opacity(trailOpacity)
            .offset(x: -50)

            // Star head (5-pointed star shape)
            Image(systemName: "star.fill")
                .font(.system(size: 40))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.8), radius: 8)
        }
    }
}

#Preview {
    SplashScreen()
        .environmentObject(AppState())
}
