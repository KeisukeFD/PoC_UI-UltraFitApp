//
//  MenuListView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

struct MenuListView: View {
    @State var filterSelected: Int = 0
    
    @State var likes: [UUID] = []
    @State var count: Int = 0
    
    @State var filteredMeals: [Meal] = []
    
    @State var caloriesSortDirection = SortDirection.Ascending
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                SegmentSelectorView(selected: self.$filterSelected, segments: MealCategory.allCases.map { $0.rawValue }, width: geo.size.width)
            }.frame(height: 60)

            HStack {
                Text("\(self.count)")
                    .font(Font.title2.bold())
                Text("meals")
                    .font(Font.title2)
                
                Spacer()

                SortSelectView(name: "Cal", direction: self.$caloriesSortDirection)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: gap * 2) {
                    ForEach(self.filteredMeals, id: \.id) { (meal) in
                        if meal.category == MealCategory.allCases[self.filterSelected] {
                            MealCardView(meal: meal, liked: self.likes.contains(meal.id)) { (value) in
                                if value {
                                    self.likes.append(meal.id)
                                } else {
                                    if let i = self.likes.firstIndex(of: meal.id) {
                                        self.likes.remove(at: i)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.padding()
        .onChange(of: self.filterSelected, perform: { value in
            self.updateCount()
        })
        .onChange(of: self.caloriesSortDirection, perform: { value in
            self.sortMealsByCalories(for: value)
        })
        .onAppear {
            self.caloriesSortDirection = .Ascending
            sortMealsByCalories(for: self.caloriesSortDirection)
            self.updateCount()
        }
    }

    private func updateCount() {
        self.count = meals.filter({ (m) -> Bool in
            m.category == MealCategory.allCases[self.filterSelected]
        }).count
    }
    
    private func sortMealsByCalories(for direction: SortDirection) {
        self.filteredMeals = meals.sorted { (m1, m2) -> Bool in
            if direction == .Descending {
                return m1.calories > m2.calories
            }
            return m1.calories < m2.calories
        }
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        MenuListView()
    }
}
