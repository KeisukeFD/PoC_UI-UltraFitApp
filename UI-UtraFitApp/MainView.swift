//
//  MainView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-28.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                ProfileView()
                    .tabItem {
                        Image(systemName: "home")
                    }
                
            }.background(whiteColor)
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
