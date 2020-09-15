//
//  YourProgressionView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

struct YourProgressionView: View {
    @State var value: Int
    @State var total: Int
    
    var body: some View {
        CardView(backgroundColor: darkGrayColor.opacity(0.8)){
            VStack(alignment: .leading, spacing: gap * 2) {
                HStack {
                    Text("Your Progress: ")
                    Text("\(self.value)/\(self.total)")
                }
                
                ProgressView(value: Double(self.value), total: Double(self.total))
                    .background(secondAccentColor.opacity(0.2))
                    .accentColor(secondAccentColor)
                    
            }.padding(.all, gap)
        }
    }
}

struct YourProgressionView_Previews: PreviewProvider {
    static var previews: some View {
        YourProgressionView(value: 4, total: 7)
    }
}
