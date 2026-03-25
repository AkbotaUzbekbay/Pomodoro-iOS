//
//  ContentView.swift
//  Pomodoro
//
//  Created by Акбота on 25.03.2026.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "house")
                }

            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }

            History()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PomodoroSettings())
}
