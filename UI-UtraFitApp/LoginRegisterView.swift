//
//  SwiftUIView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI

typealias LoginCompletionHandler = (_ email: String, _ password: String) -> Void
typealias RegisterCompletionHandler = (_ name: String, _ email: String, _ password: String) -> Void


struct LoginRegisterView: View {
    private enum Page: String, CaseIterable {
        case Login = "Sign In"
        case Register = "Register"
    }
    
    @State private var selection: Page = Page.Login
    
    var loginAction: LoginCompletionHandler
    var registerAction: RegisterCompletionHandler
    
    var body: some View {
        MultipleHorizontalTabView(tabs: [
            TabItemView(title: Page.Login.rawValue) { AnyView(SignInView(action: loginAction)) },
            TabItemView(title: Page.Register.rawValue) { AnyView(RegisterView(action: registerAction)) }            
        ])
        .padding([.leading, .trailing], gap * 2)
        .animation(.delayed(by: 0))
    }
}


fileprivate struct SignInView: View {
    @State var emailAddress = ""
    @State var password = ""
    
    let action: LoginCompletionHandler
    
    var body: some View {
        VStack(spacing: gap * 2) {
            TextField("Email Address", text: $emailAddress)
                .modifier(RoundInputModifier())

            SecureField("Password", text: $password)
                .modifier(RoundInputModifier())

            Spacer().frame(height: gap)
            HStack {
                Text("Forgot Password ?")
                    .font(Font.system(size: 14))
                    .foregroundColor(grayColor)
                    .underline()
                
                Spacer()
                Text("Sign In".uppercased())
                    .modifier(RoundButtonModifier())
                    .onTapGesture(perform: {
                        self.action(emailAddress, password)
                    })
            }
            Spacer()
        }
    }
}


fileprivate struct RegisterView: View {
    @State var fullname = ""
    @State var emailAddress = ""
    @State var password = ""
    @State var repeatPassword = ""

    let action: RegisterCompletionHandler
    
    var body: some View {
        VStack(spacing: gap * 2) {
            TextField("Fullname", text: $fullname)
                .modifier(RoundInputModifier())

            TextField("Email Address", text: $emailAddress)
                .modifier(RoundInputModifier())

            SecureField("Password", text: $password)
                .modifier(RoundInputModifier())

            SecureField("Repeat Passowrd", text: $password)
                .modifier(RoundInputModifier())

            Spacer().frame(height: gap)
            HStack {
                HStack(spacing: gap * 2) {
                    SocialIcon(iconName: "twitter", link: "https://www.twitter.com")
                    SocialIcon(iconName: "facebook", link: "https://www.facebook.com")
                    SocialIcon(iconName: "linkedin", link: "https://www/linkedin.com")
                }.foregroundColor(grayColor)

                Spacer()
                Text("Sign Up".uppercased())
                    .modifier(RoundButtonModifier())
                    .onTapGesture(perform: {
                        self.action(fullname, emailAddress, password)
                    })

            }
            Spacer()
        }
    }
}

#if DEBUG
class LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterView(loginAction: { (email, passwd) in }, registerAction: { (name, email, passwd) in })
    }
}
#endif
