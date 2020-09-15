//
//  SelectBulletList.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct SelectBulletList: View {

    @Binding var selected: Int
    @State var options: [String] = []
    
    var backgroundColor: Color = veryLightGrayColor
    var selectedColor: Color = firstAccentColor
    var foregroundColor: Color = grayColor
    var foregroundSelectedColor: Color = whiteColor

    var height: CGFloat = gap * 5
    
    
    var body: some View {
        VStack(spacing: gap * 2) {
            ForEach(self.options.enumerated().map { $0 }, id: \.element) { (index, option) in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.selected == index ? selectedColor : backgroundColor)
                        .cornerRadius(self.height / 2)
                        .frame(height: self.height)
                

                    HStack(spacing: gap * 2) {
                        ZStack {
                            Circle()
                                .fill(self.selected == index ? selectedColor : whiteColor)
                                .brightness(self.selected == index ? 0.12 : 0.0)

                                

                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: self.height * 0.45)
                                .foregroundColor(self.selected == index ? foregroundSelectedColor : foregroundColor)
                        }.frame(width: (self.height * 0.8), height: (self.height * 0.8))

                        
                        Text("\(option)")
                            .foregroundColor(self.selected == index ? foregroundSelectedColor : foregroundColor)
//                            .padding(.leading, 60)
                        Spacer()
                    }.padding(.leading, gap)
                }.onTapGesture(count: 1, perform: {
                    self.selected = index
                })
            }
        }
    }
}

struct SelectBulletList_Previews: PreviewProvider {
    @State static var selectedOptions: Int = 0
    static var previews: some View {
        SelectBulletList(selected: $selectedOptions, options: ["Veganism", "A button", "No Restriction"])
    }
}
