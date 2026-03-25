//
//  Grid.swift
//  Pomodoro
//
//  Created by Акбота on 18.04.2025.
//

import SwiftUI

struct Grid: View {
    @Binding var selectedCategory: String
    @Environment(\.dismiss) private var dismiss

    let categories = [
        ["Work", "Study"],
        ["Workout", "Reading"],
        ["Meditation", "Others"]
    ]

    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 5)
                .overlay(Color.black.opacity(0.1))

            VStack {
                Text("Focus category")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)

                Spacer().frame(height: 32)

                VStack(spacing: 20) {
                    ForEach(categories, id: \.self) { row in
                        HStack(spacing: 14) {
                            ForEach(row, id: \.self) { title in
                                Button(action: {
                                    selectedCategory = title
                                    dismiss()
                                }) {
                                    Text(title)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(
                                            selectedCategory == title
                                            ? Color.black
                                            : Color.white
                                        )
                                        .foregroundColor(
                                            selectedCategory == title
                                            ? .white
                                            : .black
                                        )
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    Grid(selectedCategory: .constant("Work"))
}
