//
//  MealCardView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

struct MealCardView: View {
    @State var meal: Meal
    @State var liked: Bool = false
    @State var likeAction: (_ value: Bool) -> Void
    
    var body: some View {
        CardView(backgroundColor: whiteColor) {
            ZStack(alignment: .topLeading) {
                HStack(spacing: gap) {
                    Image("\(meal.imageName)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140)
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: gap * 2) {
                        Text("\(meal.name)")
                            .font(Font.title2.bold())
                        
                        HStack(spacing: 4) {
                            Image(systemName: "flame")
                            Text("\(String(format: "%d", meal.calories)) cal")
                            
                            Spacer().frame(width: gap)
                            
                            Image(systemName: "clock")
                            Text("\(String(format: "%d", meal.preparationDuration)) mins")
                        }
                        .foregroundColor(grayColor)
                        .font(Font.system(size: 14))
                    }
                    Spacer()
                }
                GeometryReader { geo in
                    Image(systemName: self.liked ? "heart.fill": "heart")
                        .position(x: geo.size.width - gap, y: gap)
                        .foregroundColor(self.liked ? firstAccentColor : grayColor)
                        .onTapGesture {
                            self.liked.toggle()
                            self.likeAction(self.liked)
                        }
                }.frame(height: 88)
            }
        }
    }
}

struct MealCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        MealCardView(meal: meals[1]) { (value) in
            
        }
    }
}
