//
//  RoundButtonModifier.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI


struct RoundButtonModifier: ViewModifier {
    var backgroundColor: Color
    var foregroundColor: Color
    var cornerRadius: CGFloat
    
    init(background: Color = secondAccentColor, foreground: Color = whiteColor, cornerRadius: CGFloat = 20) {
        self.backgroundColor = background
        self.foregroundColor = foreground
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        return content
            .padding([.top, .bottom])
            .padding([.leading, .trailing], gap * 2)
            .background(self.backgroundColor)
            .foregroundColor(self.foregroundColor)
            .cornerRadius(self.cornerRadius)
    }
}

