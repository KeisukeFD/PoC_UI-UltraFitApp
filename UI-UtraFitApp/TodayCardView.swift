//
//  TodayCardView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct TodayCardView: View {
    @State var heartbeats: [Double] = []
    
    var body: some View {
        CardView(backgroundColor: whiteColor) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                VStack(alignment: .leading, spacing: gap) {
                    TitleView(value: "Today")

                    Text("Budget 2600 Cal")
                        .font(Font.callout)
                        .foregroundColor(grayColor)
                        .padding(.bottom, gap * 2)

                    CircleProgressView(title: "1200", subtitle: "Cal left", progress: 0.65, width: 120)
                }
                VStack(spacing: gap * 2) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                            .brightness(-0.1)

                        Text("Heart")
                            .font(Font.body.bold())
                    }
                    
                    HeartBeatSimpleView(values: self.$heartbeats, width: 120, height: 100)
                    
                    VStack(spacing: gap / 2) {
                        Text("93.5")
                            .font(Font.body.bold())
                        Text("bpm")
                            .font(Font.caption)
                            .foregroundColor(grayColor)
                    }
                }
            }.overlay(Rectangle().fill(grayColor).frame(width: 1).opacity(0.6))
        }.padding()
        .onAppear {
            for _ in 0..<10 {
                self.heartbeats.append(Double.random(in: 40...200))
            }
            self.heartbeats = self.heartbeats.shuffled()
        }
    }
}

struct TodayCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayCardView()
    }
}
