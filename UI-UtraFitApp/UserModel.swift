//
//  UserModel.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI
import Combine


class UserModel: ObservableObject {
    var id = UUID()
    @Published var fullName: String = ""
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    @Published var isConnected: Bool = false

}
