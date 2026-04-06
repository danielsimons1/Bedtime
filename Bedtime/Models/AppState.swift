//
//  AppState.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

enum Screen {
    case splash
    case landing
    case onboarding
    case paywall
    case main
}

class AppState: ObservableObject {
    @Published var currentScreen: Screen = .splash
    @Published var childName: String = ""
    @Published var childGender: String = ""
    @Published var hasSubscription: Bool = false

    func navigateTo(_ screen: Screen) {
        currentScreen = screen
    }
}
