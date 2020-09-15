//
//  OnBoardingView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct OnBoardingView: View {
    @State var views: [AnyView] = []
    
    @State var currentIndex: Int = 0
    @GestureState private var translation: CGFloat = 0
    
    @State private var width: CGFloat = UIScreen.main.bounds.width
    @State private var height: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack(alignment: .leading) {
            backColor
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    ForEach(0..<self.views.count) { index in
                        if let view = self.views[index] {
                            view
                                .frame(width: self.width, height: self.height)
                        }
                    }
                }.offset(x: -CGFloat(self.currentIndex) * geo.size.width)
                .offset(x: self.translation)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        let offset = value.translation.width / geo.size.width
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        self.currentIndex = min(max(Int(newIndex), 0), self.views.count - 1)
                    }
                )

                HStack(spacing: gap) {
                    ForEach(0..<self.views.count, id: \.self) {
                        if self.currentIndex == $0 {
                            Circle()
                                .fill(grayColor)
                                .frame(width: 12, height: 12)
                                .brightness(-0.1)
                        } else {
                            Circle()
                                .fill(lightGrayColor)
                                .frame(width: 12, height: 12)
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if self.currentIndex == self.views.count-1 {
                            
                        }
                        else {
                            self.currentIndex += 1
                        }
                    }, label: {
                        if self.currentIndex == self.views.count-1 {
                            Text("Finish")
                                .padding([.leading, .trailing], 16)
                                .modifier(RoundButtonModifier(cornerRadius: 32))

                        } else {
                            Text("Next")
                                .padding([.leading, .trailing], 16)
                                .modifier(RoundButtonModifier(cornerRadius: 32))
                        }
                    })
                    
                }.offset(y: geo.size.height - 100)
                .padding()
            }
            
        }.ignoresSafeArea()
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(views: [
            AnyView(SplashView()),
            AnyView(PersonalInformationView()),
            AnyView(FoodPreferencesView())
        ])
        .previewDevice("iPhone 11")
    }
}
