//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Акбота on 20.04.2025.
//


import SwiftUI

@main
struct PomodoroApp: App {
    @StateObject private var settings = PomodoroSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
