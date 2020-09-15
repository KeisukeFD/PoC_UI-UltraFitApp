//
//  PersonalInformationView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import SwiftUI


struct FoodPreferencesView: View {
    @State var selectedNutrition: Int = 2
    @State var nutritions: [String] = ["Vegetarism", "Vegan", "No Restriction"]
    
    @State var selectedLikes: [Int] = []
    @State var likesList: [CellSelect] = []

    var body: some View {
        VStack {
            CardView(backgroundColor: whiteColor) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    TitleView(value: "Nutrition")

                    HStack(spacing: gap * 2) {
                        SelectBulletList(selected: self.$selectedNutrition, options: self.nutritions)
                    }
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            
            CardView(backgroundColor: whiteColor) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    TitleView(value: "What do you like ?")
                    MultiSelectSquareView(selected: self.$selectedLikes, options: self.$likesList)
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])

        }.navigationTitle(Text("Food preferences"))
        .onAppear {
            self.likesList = [
                CellSelect(imageName: "apple", title: "Fruits", selected: true),
                CellSelect(imageName: "salad", title: "Salad"),
                CellSelect(imageName: "chicken", title: "Chicken"),
                CellSelect(imageName: "milk", title: "Dairy"),
                CellSelect(imageName: "fish", title: "Fish"),
                CellSelect(imageName: "avocado", title: "Protein")
            ]
        }
    }
}

struct FoodPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        FoodPreferencesView()
    }
}

