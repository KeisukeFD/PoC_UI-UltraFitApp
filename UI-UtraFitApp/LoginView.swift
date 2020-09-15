//
//  LoginView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-28.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var userModel = UserModel()
    
    @State private var showContent: Bool = false

    var body: some View {
        VStack {
            Spacer().frame(height: gap * 14)
            
            if showContent {
                Image("Logo-tr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .transition(.move(edge: .bottom))
                    
                HStack(spacing: 0) {
                    Spacer()
                    Text("ULTRA")
                        .font(Font.title.italic().bold())
      
                    Text("FIT")
                        .font(Font.title.italic().bold())
                        .foregroundColor(Color.orange)
                    Spacer()
                }
                .transition(.move(edge: .bottom))
                .animation(.delayed(by: 1))
                
                LoginRegisterView(loginAction: { (email, passwd) in
                    print("login")
                    
                }, registerAction: { (name, email, passwd) in
                    print("register")
                })
                .transition(.move(edge: .bottom))
                .animation(.delayed(by: 3))
            }
            Spacer()
        }.onAppear {
            withAnimation {
                self.showContent.toggle()
            }
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
