//
//  Main.swift
//  Pomodoro
//
//  Created by Акбота on 17.04.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var settings: PomodoroSettings

    @State private var timeRemaining = 25 * 60
    @State private var isRunning = false
    @State private var timer: Timer? = nil
    @State private var showCategoryScreen = false
    @State private var selectedCategory = "Focus category"
    @State private var sessionCompleted = false

    var totalTime: Int {
        settings.focusMinutes * 60
    }

    var progress: Double {
        guard totalTime > 0 else { return 0 }
        return Double(totalTime - timeRemaining) / Double(totalTime)
    }

    var statusText: String {
        if sessionCompleted {
            return "Session completed"
        } else if isRunning {
            return "Stay focused"
        } else {
            return "Ready to focus?"
        }
    }

    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Button(action: {
                    showCategoryScreen = true
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))

                        Text(selectedCategory)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 190, height: 36)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(24)
                }
                .padding(.top, 136)
                .sheet(isPresented: $showCategoryScreen) {
                    Grid(selectedCategory: $selectedCategory)
                }

                Spacer().frame(height: 52)

                ZStack {
                    Circle()
                        .stroke(lineWidth: 6)
                        .fill(Color.white)
                        .frame(width: 248, height: 264)
                        .opacity(0.2)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 248, height: 264)
                        .rotationEffect(.degrees(-90))

                    VStack(spacing: 4) {
                        Text(timeString(from: timeRemaining))
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(.white)

                        Text(statusText)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding()
                }

                Spacer().frame(height: 60)

                HStack(spacing: 40) {
                    Button(action: {
                        isRunning ? pauseTimer() : startTimer()
                    }) {
                        Circle()
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Image(systemName: isRunning ? "pause.fill" : "play.fill")
                                    .foregroundColor(.white)
                            )
                    }

                    Button(action: {
                        resetTimer()
                    }) {
                        Circle()
                            .fill(Color.white.opacity(0.4))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(.white)
                            )
                    }
                }

                Spacer()
            }
            .padding(.bottom, 40)
        }
        .onAppear {
            if !isRunning && !sessionCompleted {
                timeRemaining = totalTime
            }
        }
        .onChange(of: settings.focusMinutes) { _ in
            if !isRunning {
                timeRemaining = totalTime
            }
        }
        .onDisappear {
            pauseTimer()
        }
    }

    func startTimer() {
        guard !isRunning, timeRemaining > 0 else { return }

        sessionCompleted = false
        isRunning = true

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                sessionCompleted = true
                saveSessionToHistory()
                pauseTimer()
            }
        }
    }

    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        pauseTimer()
        sessionCompleted = false
        timeRemaining = totalTime
    }

    func saveSessionToHistory() {
        let newSession = PomodoroSession(
            date: Date(),
            category: selectedCategory,
            focusTime: "\(settings.focusMinutes):00",
            breakTime: "\(settings.breakMinutes):00"
        )
        settings.history.insert(newSession, at: 0)
    }

    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    MainView()
        .environmentObject(PomodoroSettings())
}
