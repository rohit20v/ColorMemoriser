//
//  Background.swift
//  ColorMemoriser
//
//  Created by d13 on 05/12/24.
//

import SwiftUI

struct Background: View {
    
    var blurRadius: CGFloat = 1
    
    let screenWidth = UIScreen.main.bounds.size.width;
    let screenHeight = UIScreen.main.bounds.size.height;
    
    var body: some View {
        Canvas {
            context, size in
            let shape = CGRect(
                origin: .init(x: screenWidth / 2, y: screenHeight / -2), size: CGSize(width: 700, height: 700)
                 )
            
            let newShape = CGRect(
                origin: .init(x: -screenWidth / 2, y: screenHeight / 2),
                size: size)
            
            let path = Circle().path(in: shape)
            context.fill(path, with: .color(.red))
            
            let newPath = Circle().path(in: newShape)
            context.fill(newPath, with: .color(.blue))
        }.ignoresSafeArea().blur(radius: blurRadius)
    }
}

#Preview {
    Background()
}
