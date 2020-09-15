//
//  CapsuleIcon.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct CapsuleIcon: View {
    var imageName: String
    var imageRotation: Angle = .degrees(0)
    var backgroundColor: Color = firstAccentColor
    var foregroundColor: Color = whiteColor
    
    var width: CGFloat = 60
    var height: CGFloat = 120
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(backgroundColor)
                .brightness(0.14)
            
            Image("\(imageName)")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .rotationEffect(imageRotation)
                .foregroundColor(foregroundColor.opacity(0.9))
                .frame(height: self.height * 0.8)
        }.frame(width: self.width, height: self.height)
    }
}

struct CapsuleIcon_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleIcon(imageName: "human")
    }
}
