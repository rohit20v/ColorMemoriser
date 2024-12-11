//
//  HomePage.swift
//  ColorMemoriser
//
//  Created by d13 on 05/12/24.
//

import SwiftUI

struct StartPage: View {
    @State var bgScale: CGFloat = 1.2
    @State var isnavigationLinkActive: Bool = false
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {

            Background(blurRadius: 120)
                .scaleEffect(bgScale)

            Button(action: {
                withAnimation {
                    bgScale = 1.8
                    opacity = 0
                }
                isnavigationLinkActive = true
            }){
                Text("Start").padding()
            }
            .background(.pink).cornerRadius(16).foregroundStyle(.white).fontWeight(.bold)
            .opacity(opacity)
            

            if isnavigationLinkActive {

                HomePage(isBackToStart: $isnavigationLinkActive).onDisappear {
                    withAnimation(.easeInOut) {
                        bgScale = 1.2
                        opacity = 1.0
                    }
                }

            }

        }.ignoresSafeArea(edges: .top)

    }

}

#Preview {
    StartPage()
}
