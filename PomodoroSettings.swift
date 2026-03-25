//
//  PomodoroSettings.swift
//  Pomodoro
//
//  Created by Акбота on 25.03.2026.
//

import SwiftUI

final class PomodoroSettings: ObservableObject {
    @Published var focusMinutes: Int = 25
    @Published var breakMinutes: Int = 5
    @Published var history: [PomodoroSession] = []
}

struct PomodoroSession: Identifiable {
    let id = UUID()
    let date: Date
    let category: String
    let focusTime: String
    let breakTime: String
}
