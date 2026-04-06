//
//  MainView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.2, green: 0.1, blue: 0.25)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Welcome, \(appState.childName)!")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Text("Let's start your bedtime story adventure")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                // Placeholder for story content
                VStack(spacing: 24) {
                    Image(systemName: "book.pages.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.yellow)

                    Text("Stories coming soon!")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)

                    Text("This is where your magical bedtime stories will appear.")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 60)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AppState())
}
