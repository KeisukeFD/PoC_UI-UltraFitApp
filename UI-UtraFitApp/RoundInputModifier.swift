//
//  RoundInputModifier.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI

struct RoundInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(.all)
            .background(whiteColor)
            .cornerRadius(30)
    }
}
