//
//  Utils.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI

typealias ActionCompletion = () -> Void


let gap: CGFloat = 8



// Colors
let backColor: Color = Color("backColor")

let firstAccentColor: Color = Color.accentColor
let secondAccentColor: Color = Color("secondAccentColor")

let veryLightGrayColor: Color = Color.gray.opacity(0.2)
let lightGrayColor: Color = Color.gray.opacity(0.4)
let grayColor: Color = Color.gray
let darkGrayColor: Color = Color("darkGray").opacity(0.6)

let tealColor: Color = Color("tealColor")

let whiteColor: Color = Color.white

// Fonts

struct TitleView: View {
    var value: String
    var body: some View {
        Text(value)
            .font(Font.title2.bold())
    }
}
