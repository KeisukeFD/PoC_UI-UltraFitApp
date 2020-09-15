//
//  StepsView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

struct StepsView: View {
    @State var steps: [String]
    
    let formatNumber: NumberFormatter = {
        let format = NumberFormatter()
        format.minimumIntegerDigits = 2
        return format
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: gap * 2) {
            ForEach(self.steps.enumerated().map { $0 }, id: \.element) { (index, step) in
                HStack(alignment: .top, spacing: gap * 2) {
                    Text("\(formatNumber.string(for: index+1)!)")
                        .font(Font.body.bold())
                        .foregroundColor(firstAccentColor)
                    
                    Text("\(step)")
                        .foregroundColor(grayColor)
                        .brightness(-0.3)
                        .font(Font.callout)
                    Spacer()
                }
                .padding(.bottom, gap * 2)
                .overlay(Rectangle().fill(grayColor.opacity(0.4)).frame(height: 1), alignment: .bottom)
            }
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView(steps: [
            "Lie faceup on the mat, with your arms extended past your head",
            "Bend your knees and have the soles of your feet facing one another so it's in a diamond shape"
        ])
    }
}
