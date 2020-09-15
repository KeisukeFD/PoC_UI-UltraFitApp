//
//  ContentView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fullScreen: FullScreenController

    var body: some View {
        ZStack {
            backColor
            OnBoardingView(views: [
                AnyView(SplashView()),
                AnyView(FoodPreferencesView()),
                AnyView(PersonalInformationView()),
            ])
//            LoginView()
//            ExerciseView()
//            MenuListView()
        }.ignoresSafeArea()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}
#endif

