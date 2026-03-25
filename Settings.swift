//  Pomodoro
//
//  Created by Акбота on 18.04.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var settings: PomodoroSettings

    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Settings")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 24)

                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Focus time")
                                .font(.system(size: 17))
                                .foregroundColor(.white)

                            Spacer()

                            Text("\(settings.focusMinutes) min")
                                .foregroundColor(.gray)
                        }

                        Stepper("", value: $settings.focusMinutes, in: 1...60)
                            .labelsHidden()
                            .tint(.white)
                    }

                    Divider()
                        .background(Color.white.opacity(0.3))

                    VStack(spacing: 12) {
                        HStack {
                            Text("Break time")
                                .font(.system(size: 17))
                                .foregroundColor(.white)

                            Spacer()

                            Text("\(settings.breakMinutes) min")
                                .foregroundColor(.gray)
                        }

                        Stepper("", value: $settings.breakMinutes, in: 1...30)
                            .labelsHidden()
                            .tint(.white)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
    }
}

#Preview {
    Settings()
        .environmentObject(PomodoroSettings())
}
