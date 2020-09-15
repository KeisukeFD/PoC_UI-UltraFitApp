//
//  CardView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI

struct CardView<Content: View>: View {
    var backgroundColor: Color
    var cornerRadius: CGFloat
    var content: Content
    
    var isLoading: Bool
    
    init(backgroundColor: Color = backColor, cornerRadius: CGFloat = 20, isLoading: Bool = false, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isLoading = isLoading
        self.content = content()
    }
    var body: some View {
        ZStack {
            HStack {
                self.content
            }.blur(radius: self.isLoading ? 3 : 0)
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.all, gap)
        .background(self.backgroundColor)
        .cornerRadius(self.cornerRadius)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Hello")
        }
    }
}
