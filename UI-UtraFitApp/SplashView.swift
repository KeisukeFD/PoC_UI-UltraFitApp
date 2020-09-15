//
//  SplashView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

struct SplashView: View {
    @State private var showContent: Bool = false

    var body: some View {
        VStack(spacing: gap) {
            Spacer()
            if showContent {
                Image("Logo-tr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
                    .transition(.move(edge: .top))
            
                HStack(spacing: 0) {
                    Spacer()
                    Text("ULTRA")
                        .font(Font.title.italic().bold())
                        .transition(.move(edge: .trailing))
                        .animation(.delayed(by: 2))

                    Text("FIT")
                        .font(Font.title.italic().bold())
                        .foregroundColor(Color.orange)
                        .transition(.move(edge: .trailing))
                        .animation(.delayed(by: 3))
                    Spacer()
                }
                .transition(.move(edge: .trailing))
                .animation(.delayed(by: 1))
            }
            Spacer()
        }.onAppear {
            withAnimation {
                self.showContent.toggle()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

