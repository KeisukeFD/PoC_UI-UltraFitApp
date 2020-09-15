//
//  SegmentSelectorView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct SegmentSelectorView: View {
    @Binding var selected: Int
    @State var segments: [String] = []
    
    
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = 48
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(firstAccentColor)
                .frame(width: self.width / CGFloat(self.segments.count))
                .cornerRadius(10)
                .offset(x: self.offset)
                .transition(AnyTransition.move(edge: .trailing))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: gap), count: self.segments.count)) {
                ForEach(self.segments.enumerated().map { $0 }, id: \.element) { (i, s) in
                    Text("\(s)")
                        .padding()
                        .font(Font.callout)
                        .foregroundColor(self.selected == i ? whiteColor : grayColor)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Rectangle()
                                .fill(lightGrayColor)
                                .frame(width: 1, height: gap * 3)
                                .offset(x: -(gap/2) - 0.5)
                                .opacity(i > 0 ? 1.0 : 0.0)
                        , alignment: .leading)

                    .onTapGesture(count: 1, perform: {
                        withAnimation {
                            self.selected = i
                            self.offset = (self.width / CGFloat(self.segments.count)) * CGFloat(i)
                        }
                    })
                }
            }
        }
        .frame(width: self.width, height: self.height)
    }
}

struct SegmentSelectorView_Previews: PreviewProvider {
    @State static var selected: Int = 0
    
    static var previews: some View {
        SegmentSelectorView(selected: $selected, segments: ["Breakfast", "Lunch", "Dinner"])
    }
}
