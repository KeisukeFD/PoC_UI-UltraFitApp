//
//  MealDetailView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-03.
//

import SwiftUI

struct MealDetailView: View {
    @State var meal: Meal
        
    let formatNumber: NumberFormatter = {
        let format = NumberFormatter()
        format.minimumIntegerDigits = 1
        return format
    }()
    
    
    var body: some View {
        VStack {
            Image("\(meal.imageName)")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(20)
                .padding(.bottom, gap * 2)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: gap) {
                    TitleView(value: "\(meal.name)")
                    
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
                Image(systemName: "heart")
                    .padding(.leading, gap * 2)
            }
            
            CardView(backgroundColor: whiteColor) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    SmallDetailInfo(name: "Protein", value: meal.protein, unit: "g")
                    SmallDetailInfo(name: "Fat", value: meal.fat, unit: "g")
                    SmallDetailInfo(name: "Net Carbs", value: meal.carbs, unit: "g")
                }
            }.padding(.bottom, gap * 2)

            
            MultipleHorizontalTabView(tabs: [
                TabItemView(title: "Ingredients") {
                    AnyView(
                        CardView(backgroundColor: whiteColor) {
                            HStack {
                                Spacer().frame(width: gap * 2)
                                VStack(alignment: .leading) {
                                    ForEach(meal.ingredients, id: \.self) { ing in
                                        Text("- \(ing.name) : \(formatNumber.string(for: ing.quantity)!) \(ing.unit)")
                                            .foregroundColor(grayColor)
                                            .brightness(-0.3)
                                            .font(Font.callout)
                                            .padding(.bottom, 4)
                                    }
                                }
                                Spacer()
                            }
                        }
                    )
                },
                TabItemView(title: "Directions") {
                    AnyView(DirectionsView(meal: meal))
                }
            ])
            
        }.padding(.all, gap * 2)

    }
}

fileprivate struct DirectionsView: View {
    var meal: Meal
    @State var lastStepFinished: Int = Int.min

    let formatNumber: NumberFormatter = {
        let format = NumberFormatter()
        format.minimumIntegerDigits = 2
        return format
    }()
    
    var body: some View {
        ForEach(0..<self.meal.directions.count, id: \.self) { (index) in
            HStack {
                CardView(backgroundColor: index <= self.lastStepFinished ? whiteColor.opacity(0.7):whiteColor) {
                    HStack(spacing: gap * 2) {
                        Text("\(formatNumber.string(for: index+1)!)")
                            .font(Font.body.bold())
                            .foregroundColor(index <= self.lastStepFinished ? grayColor : firstAccentColor)
                        
                        Text("\(meal.directions[index])")
                            .foregroundColor(index <= self.lastStepFinished ? lightGrayColor:grayColor)
                            .brightness(-0.3)
                            .font(Font.callout)
                        Spacer()
                    }
                }

                Spacer()
                
                ZStack {
                    Circle()
                        .fill(index <= self.lastStepFinished ? secondAccentColor : lightGrayColor)
                        .brightness(0.0)

                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(index <= self.lastStepFinished ? whiteColor:grayColor)
                        .frame(height: 14)
                        
                }
                .frame(width: 24, height: 24)
                .onTapGesture(count: 1, perform: {
                    if self.lastStepFinished == 0 && index == 0 {
                        self.lastStepFinished = Int.min
                    } else {
                        self.lastStepFinished = index
                    }
                })
            }
        }
    }
}

fileprivate struct SmallDetailInfo: View {
    var name: String
    var value: Float
    var unit: String
    
    var formatter: NumberFormatter = {
        let format = NumberFormatter()
        format.maximumFractionDigits = 1
        format.minimumFractionDigits = 0
        return format
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: gap) {
            Text("\(name)")
                .font(Font.callout)
                .foregroundColor(grayColor)
            
            HStack(spacing: 2) {
                Text("\(formatter.string(for: value)!)")
                    .font(Font.body.bold())
                Text("\(unit)")
                    .font(Font.callout)
                    .foregroundColor(grayColor)
            }
        }.overlay(Rectangle().fill(lightGrayColor).frame(width: 1, height: 30).offset(x: gap * 4), alignment: .trailing)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: meals[2])
    }
}
