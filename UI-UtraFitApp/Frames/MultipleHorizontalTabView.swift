//
//  MultipleHorizontalTabView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-03.
//

import SwiftUI

struct TabItemView: View {
    var id = UUID()
    var title: String
    var content: AnyView

    init(title: String, content: () -> AnyView) {
        self.title = title
        self.content = content()
    }
    
    @ViewBuilder var body: some View {
        self.content
    }
}

struct MultipleHorizontalTabView: View {
    @State var tabs: [TabItemView]
    
    @State private var selected: Int = 0
    @State private var offset: CGFloat = 0.0
    
    var foregroundColor: Color = grayColor
    var foregroundSelectedColor: Color = firstAccentColor

    var backgroundBarColor: Color = lightGrayColor
    var selectedBarColor: Color = firstAccentColor
        
    @ViewBuilder var body: some View {
        VStack {
            GeometryReader { geo in
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: self.tabs.count)) {
                    ForEach(self.tabs.enumerated().map { $0 }, id:\.element.id) { (index, tab) in
                        Text("\(tab.title.uppercased())")
                            .frame(width: geo.size.width / 2)
                            .font(self.selected == index ? Font.body.bold() : Font.body)
                            .foregroundColor(self.selected == index ? foregroundSelectedColor : foregroundColor)
                            .contentShape(Rectangle())
                            .onTapGesture(perform: {
                                withAnimation {
                                    self.selected = index
                                }
                            })
                    }
                }.overlay(Rectangle()
                            .fill(self.backgroundBarColor)
                            .frame(width: geo.size.width, height: 4)
                            .offset(y: gap * 2)
                          , alignment: .bottomLeading)
                .overlay(Rectangle()
                        .fill(self.foregroundSelectedColor)
                        .frame(width: geo.size.width / CGFloat(self.tabs.count), height: 4)
                        .offset(x: CGFloat(self.selected) * (geo.size.width / CGFloat(self.tabs.count)), y: gap * 2)
                      , alignment: .bottomLeading)
            }.frame(height: gap * 7)

            self.tabs[self.selected].content

            Spacer()
        }
    }
}


struct MultipleHorizontalTabView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleHorizontalTabView(tabs: [
            TabItemView(title: "Blah") { AnyView(Text("Content Blah")) },
            TabItemView(title: "Houosuas") { AnyView(Text("Content hou")) },
            TabItemView(title: "Hou 2") { AnyView(Image("Logo-tr")) }
        ])
    }
}
