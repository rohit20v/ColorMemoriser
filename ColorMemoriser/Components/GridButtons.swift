//
//  GridButtons.swift
//  ColorMemoriser
//
//  Created by d13 on 11/12/24.
//

import SwiftUI

struct GridButtons: View {
    var colors: [Color]
    @Binding var generatedColors: [Color]
    @Binding var clickedColors: [Color]
    @Binding var isMatched: Bool
    @State var showResult: Bool = false

    var body: some View {
        Grid {
            GridRow {
                ForEach(colors, id: \.self) { x in
                    Button(action: {
                        clickedColors.append(x)
                        if clickedColors.count == colors.count {
                            showResult.toggle()
                        }

                        let result = zip(clickedColors, generatedColors)
                            .allSatisfy { $0 == $1 }
                        isMatched = result

                    }) {
                        Text(" ").tint(.white)
                            .padding()
                    }
                    .background(x)
                    .cornerRadius(8)
                    .alert(
                        isMatched ? "Correct :)" : "Wrong :(",
                        isPresented: $showResult,
                        actions: {
                            Button("OK") {
                                generatedColors = []
                            }
                        })
                }
            }.overlay(
                RoundedRectangle(
                    cornerSize: CGSize(width: 8, height: 8)
                )
                .fill(.black)
                .opacity(generatedColors.count < colors.count ? 0.8 : 0)
            )
        }
    }
}
