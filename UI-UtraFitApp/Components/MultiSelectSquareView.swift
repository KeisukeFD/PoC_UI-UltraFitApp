//
//  MultiSelectSquareView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct CellSelect: Hashable {
    var imageName: String
    var title: String
    var selected: Bool = false
}

struct MultiSelectSquareView: View {
    
    @Binding var selected: [Int]
    @Binding var options: [CellSelect]

    var numberOfColumns: Int = 3

    var backgroundColor: Color = veryLightGrayColor
    var selectedColor: Color = firstAccentColor
    var foregroundColor: Color = grayColor
    var foregroundSelectedColor: Color = whiteColor

    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = gap * 10
    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: gap), count: self.numberOfColumns), spacing: gap) {
            ForEach(self.options.enumerated().map { $0 }, id: \.element) { (index, option) in
                ZStack {
                    Rectangle()
                        .fill(option.selected ? selectedColor : backgroundColor)
                        .cornerRadius(gap * 2)
                        .frame(height: self.height)
                
                    GeometryReader { geo in
                        ZStack {
                            Circle()
                                .fill(option.selected ? selectedColor : whiteColor)
                                .brightness(option.selected ? 0.14 : 0.0)

                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 16 * 0.6)
                                .foregroundColor(option.selected ? foregroundSelectedColor : foregroundColor)
                        }.frame(width: 16, height: 16)
                        .offset(x: geo.size.width - 16 - gap, y: gap)
                    }

                    VStack {
                        Image("\(option.imageName)")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                            .foregroundColor(option.selected ? foregroundSelectedColor: foregroundColor)
                        Text("\(option.title)")
                            .foregroundColor(option.selected ? foregroundSelectedColor : foregroundColor)
                    }
                        
                    Spacer()
                }.onTapGesture(count: 1, perform: {
                    if self.options[index].selected {
                        self.options[index].selected = false
                        if let i = selected.firstIndex(of: index) {
                            selected.remove(at: i)
                        }
                    } else {
                        self.options[index].selected = true
                        if !selected.contains(index) {
                            selected.append(index)
                        }
                    }
                })
            }
        }
    }

}

struct MultiSelectSquareView_Previews: PreviewProvider {
    @State static var selected: [Int] = [0]
    @State static var options: [CellSelect] = []
    
    static var previews: some View {
        MultiSelectSquareView(selected: $selected, options: $options)
            .onAppear {
                self.options = [
                    CellSelect(imageName: "apple", title: "Fruits"),
                    CellSelect(imageName: "salad", title: "Salad"),
                    CellSelect(imageName: "chicken", title: "Chicken"),
                    CellSelect(imageName: "milk", title: "Dairy")
                ]
            }
    }
}
