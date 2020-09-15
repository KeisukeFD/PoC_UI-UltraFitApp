//
//  SocialIcon.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-28.
//

import SwiftUI

struct SocialIcon: View {
    @Environment(\.openURL) var openURL
    
    var iconName: String
    var link: String

    var body: some View {
        Image("\(iconName)")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: 28)
            .padding(.all, gap)
            .overlay(Circle().stroke())
            .onTapGesture {
                openURL(URL(string: link)!)
            }
    }
}

struct SocialIcon_Previews: PreviewProvider {
    static var previews: some View {
        SocialIcon(iconName: "linkedin", link: "https://www.linkedin.com")
    }
}
