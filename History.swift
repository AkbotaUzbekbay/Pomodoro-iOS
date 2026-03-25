//
//  History.swift
//  Pomodoro
//
//  Created by Акбота on 18.04.2025.
//

import SwiftUI

struct History: View {
    @EnvironmentObject var settings: PomodoroSettings

    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            if settings.history.isEmpty {
                VStack {
                    Text("History")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 24)

                    Spacer()

                    Text("No completed sessions yet")
                        .foregroundColor(.gray)

                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("History")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 24)

                        ForEach(settings.history) { session in
                            historyBlock(session: session)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }

    func historyBlock(session: PomodoroSession) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(formattedDate(session.date))
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)

            HStack {
                Text("Category")
                    .foregroundColor(.white)
                Spacer()
                Text(session.category)
                    .foregroundColor(.gray)
            }

            Divider()
                .background(Color.white.opacity(0.3))

            HStack {
                Text("Focus time")
                    .foregroundColor(.white)
                Spacer()
                Text(session.focusTime)
                    .foregroundColor(.gray)
            }

            Divider()
                .background(Color.white.opacity(0.3))

            HStack {
                Text("Break time")
                    .foregroundColor(.white)
                Spacer()
                Text(session.breakTime)
                    .foregroundColor(.gray)
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    let settings = PomodoroSettings()
    settings.history = [
        PomodoroSession(date: Date(), category: "Work", focusTime: "25:00", breakTime: "5:00")
    ]

    return History()
        .environmentObject(settings)
}
