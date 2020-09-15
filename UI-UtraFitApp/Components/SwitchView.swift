//
//  SwitchView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-31.
//

import SwiftUI

struct SwitchView: View {
    @State var isOn: Bool = false
    
    var leftLabel: String
    var rightLabel: String

    var backgroundColor: Color = veryLightGrayColor
    var buttonColor: Color = firstAccentColor
    var width: CGFloat = 60
    var height: CGFloat = 20
    
    var leftAction: () -> Void
    var rightAction: () -> Void

    @State private var offset: CGFloat = 0.0
    @State private var circleSize: CGFloat = 30
    
    var body: some View {
        HStack {
            Text("\(leftLabel)")
            ZStack {
                Rectangle()
                    .fill(veryLightGrayColor)
                    .cornerRadius(self.height * 2)
                    .frame(height: self.height)
                
                Circle()
                    .fill(firstAccentColor)
                    .frame(height: self.circleSize)
                    .offset(x: self.offset)
            }.frame(width: self.width)
            Text("\(rightLabel)")
        }
        .onAppear {
            self.circleSize = (self.height + 0.5 * self.height)
            self.offset = -(self.width / 2)+(circleSize / 2)
        }
        .onChange(of: self.isOn, perform: { value in
            if self.isOn {
                withAnimation {
                    self.offset = (self.width / 2)-(circleSize / 2)
                }
            } else {
                withAnimation {
                    self.offset = -(self.width / 2)+(circleSize / 2)
                }
            }
        })
        .onTapGesture(count: 1, perform: {
            self.isOn.toggle()
            self.isOn ? self.rightAction() : self.leftAction()
        })
    }
}

struct SwitchView_Previews: PreviewProvider {
//    @State static var switchOn: Bool = false
    static var previews: some View {
        SwitchView(leftLabel: "Off", rightLabel: "On", leftAction: {}, rightAction: {})
    }
}
