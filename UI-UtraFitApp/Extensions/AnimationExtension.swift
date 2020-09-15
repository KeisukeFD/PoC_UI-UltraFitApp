//
//  AnimationExtension.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-03.
//

import SwiftUI


extension Animation {
    static func delayed(by number: Int) -> Animation {
        Animation.easeIn(duration: 0.3)
            .delay(0.1 * Double(number))
    }
}
