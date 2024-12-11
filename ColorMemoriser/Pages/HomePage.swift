//
//  HomePage.swift
//  ColorMemoriser
//
//  Created by d13 on 05/12/24.
//

import SwiftUI


struct HomePage: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    
    @Binding var isBackToStart: Bool
    @State var color: Color = .red
    @State var pageOpacity: Double = 0

    
    @State var generatedColors: [Color] = []
    @State var clickedColors: [Color] = []

    @State var isMatched: Bool = false

    func colorGenerator() async {
        for co in colors.shuffled() {
            color = co
            generatedColors.append(color)
            try? await Task.sleep(for: .seconds(1.5))
        }
    }
    
    func restartGame() async {
        generatedColors.removeAll()
        clickedColors.removeAll()
        isMatched = false
        await colorGenerator()
    }

    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await restartGame()
                }
            }) {
                Text(Image(systemName: "arrow.clockwise"))
                    .font(.system(size: 32))
                    .tint(.pink)

            }.padding([.top, .trailing], 32).frame(
                width: UIScreen.main.bounds.width, alignment: .trailing)
            Spacer()
            Rectangle()
                .fill(color)
                .cornerRadius(8)
                .frame(
                    maxWidth: UIScreen.main.bounds.width / 2,
                    maxHeight: UIScreen.main.bounds.height / 4)

            Spacer()

            GridButtons(
                colors: colors, generatedColors: $generatedColors,
                clickedColors: $clickedColors, isMatched: $isMatched)
            Spacer()
            Button(action: {
                isBackToStart = false
            }) {
                Text("Back").padding()
            }.background(.pink).cornerRadius(16).foregroundStyle(.white)
                .fontWeight(.bold)
        }.opacity(pageOpacity)
            .onAppear {
                Task {
                    await colorGenerator()
                }
                withAnimation(.easeInOut) {
                    pageOpacity = 1
                }

            }

    }

}
