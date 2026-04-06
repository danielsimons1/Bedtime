//
//  ContentView.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            switch appState.currentScreen {
            case .splash:
                SplashScreen()
            case .landing:
                LandingView()
            case .onboarding:
                OnboardingView()
            case .paywall:
                PaywallView()
            case .main:
                MainView()
            }
        }
        .animation(.easeInOut, value: appState.currentScreen)
    }
}
