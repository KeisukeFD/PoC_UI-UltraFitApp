//
//  HeartBeatSimpleView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct HeartBeatSimpleView: View {
    @Binding var values: [Double]

    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        HStack(spacing: self.width / (gap + self.width * 0.03)) {
            ForEach(values.enumerated().map { $0 }, id: \.element) { (index, value) in
                let h = (CGFloat(value) * self.height / 2) / self.height
                Rectangle()
                    .fill(index % 2 == 0 ? lightGrayColor : secondAccentColor)
                    .cornerRadius(6)
                    .frame(width: self.width * 0.03, height: h)
            }
        }.frame(width: self.width, height: self.height)
    }
}

struct HeartBeatSimpleView_Previews: PreviewProvider {
    @State static var values: [Double] = []
    
    static var previews: some View {
        HeartBeatSimpleView(values: self.$values)
    }
}
