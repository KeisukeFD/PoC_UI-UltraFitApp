//
//  SmallStatsCardView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct SmallStatsCardView: View {
    var title: String
    var subtitle: String
    var progress: CGFloat
    var progressColor: Color
    
    var body: some View {
        CardView(backgroundColor: whiteColor) {
            VStack(alignment: .leading, spacing: gap) {
                CircleProgressView(title: "", subtitle: "", progress: self.progress, isFilled: true, progressColor: self.progressColor, width: 40, height: 40)
                
                Text("\(self.title)")
                    .font(Font.body.bold())
                Text("\(self.subtitle)")
                    .font(Font.caption)
                    .foregroundColor(grayColor)
            }
        }
    }
}

struct SmallStatsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallStatsCardView(title: "Running", subtitle: "2.5/3km", progress: 0.6, progressColor: firstAccentColor)
    }
}
