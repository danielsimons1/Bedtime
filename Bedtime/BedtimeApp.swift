//
//  BedtimeApp.swift
//  Bedtime
//
//  Created on 2026-04-06.
//

import SwiftUI

@main
struct BedtimeApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
