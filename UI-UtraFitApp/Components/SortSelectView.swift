//
//  SortSelectView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

enum SortDirection {
    case Ascending
    case Descending
}

struct SortSelectView: View {
    @State var name: String
    @Binding var direction: SortDirection
    
    var body: some View {
        HStack(spacing: gap * 2) {
            Text("\(name) \(self.direction == .Ascending ? "low to high":"high to low")")
                .rotation3DEffect(
                    .degrees(self.direction == .Ascending ? 0:360),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(self.direction == .Ascending ? 0:180*3))
        }
        .foregroundColor(secondAccentColor)
        .font(Font.caption2)
        .padding(.all, gap)
        .padding([.leading, .trailing], gap * 2)
        .background(secondAccentColor.opacity(0.2))
        .cornerRadius(20)
        .onTapGesture(count: 1, perform: {
            withAnimation {
                if self.direction == .Descending {
                    self.direction = .Ascending
                } else {
                    self.direction = .Descending
                }
            }
        })
    }
}

struct SortSelectView_Previews: PreviewProvider {
    @State static private var sortDirection = SortDirection.Ascending
    
    static var previews: some View {
        SortSelectView(name: "Cal", direction: self.$sortDirection)
    }
}
