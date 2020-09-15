//
//  PersonalInformationView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//

import Combine
import SwiftUI


struct PersonalInformationView: View {
    enum Gender: String, CaseIterable {
        case Male = "Male"
        case Female = "Female"
    }
    
    @State var gender: Gender = Gender.Male

    @State var age: Double = 24.0
    @State var height: Double = 170
    @State var heightUnit: UnitLength = UnitLength.centimeters
    @State var weight: Double = 70
    @State var weightUnit: UnitMass = UnitMass.kilograms

    @State var barsAge: [SliderConfiguration] = []
    @State var barsHeight: [SliderConfiguration] = []
    @State var barsWeight: [SliderConfiguration] = []
    
    @State var heightIsLoading: Bool = false
    @State var weightIsLoading: Bool = false

    var body: some View {
        VStack {
            CardView(backgroundColor: whiteColor) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    TitleView(value: "Gender")

                    HStack(spacing: gap * 2) {
                        ForEach(Gender.allCases, id: \.self) { g in
                            if self.gender == g {
                            Text("\(g.rawValue)")
                                .frame(minWidth: 60)
                                .modifier(RoundButtonModifier(background: firstAccentColor, cornerRadius: 30))
                                .onTapGesture {
                                    withAnimation {
                                        self.gender = g
                                    }
                                }
                            }
                            else {
                            Text("\(g.rawValue)")
                                .frame(minWidth: 60)
                                .modifier(RoundButtonModifier(background: veryLightGrayColor, foreground: Color.black.opacity(0.7), cornerRadius: 30))
                                .onTapGesture {
                                    withAnimation {
                                        self.gender = g
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])
            
            CardView(backgroundColor: whiteColor) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    HStack {
                        TitleView(value: "Age")
                        Spacer()
                        Text("\(String(format: "%.f", self.age))")
                            .font(Font.body)
                            .foregroundColor(lightGrayColor)
                    }
                    
                    SliderRulerView(barsConfig: self.$barsAge, value: self.$age)
                        
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])


            CardView(backgroundColor: whiteColor, isLoading: self.heightIsLoading) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    HStack {
                        TitleView(value: "Height")
                        
                        Spacer()

                        
                        let mesure = self.heightUnit == UnitLength.centimeters ? getCentimeters(from: self.height) : getInches(from: self.height)
                        let strValue = self.heightUnit == UnitLength.centimeters ? getFormattedCentimeters(from: mesure) : getFormattedFeet(from: mesure)
                        
                        Text("\(strValue)")
                            .font(Font.body)
                            .foregroundColor(lightGrayColor)
                        
                        Spacer()
                        
                        SwitchView(leftLabel: "cm", rightLabel: "ft", width: 30, height: 10, leftAction: {
                            self.heightIsLoading.toggle()
                            self.heightUnit = UnitLength.centimeters
                        }, rightAction: {
                            self.heightIsLoading.toggle()
                            self.heightUnit = UnitLength.feet
                        })
                        .font(Font.caption)   
                    }
                    
                    SliderRulerView(barsConfig: self.$barsHeight, value: self.$height)
                    
                }
            }
            .padding([.leading, .trailing, .bottom])

            
            CardView(backgroundColor: whiteColor, isLoading: self.weightIsLoading) {
                VStack(alignment: .leading, spacing: gap * 2) {
                    HStack {
                        TitleView(value: "Weight")

                        Spacer()
                        
                        let mesure = self.weightUnit == UnitMass.kilograms ? getKilograms(from: self.weight) : getPounds(from: self.weight)
                        let strValue = self.weightUnit == UnitMass.kilograms ? getFormattedKilograms(from: mesure) : getFormattedPounds(from: mesure)
                        
                        Text("\(strValue)")
                            .font(Font.body)
                            .foregroundColor(lightGrayColor)
                        
                        Spacer()
                        
                        SwitchView(leftLabel: "Kg", rightLabel: "lb", width: 30, height: 10, leftAction: {
                            self.weightIsLoading.toggle()
                            self.weightUnit = UnitMass.kilograms
                        }, rightAction: {
                            self.weightIsLoading.toggle()
                            self.weightUnit = UnitMass.pounds
                        })
                        .font(Font.caption)
                    }
                    
                    SliderRulerView(barsConfig: $barsWeight, value: $weight)
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom])

            
        }.navigationTitle(Text("Personal Information"))
        .onAppear {
            generateAgesBars()
                        
            generateHeightsBars(in: self.heightUnit)
            
            generateWeightsBars(in: self.weightUnit)
        }
        .onChange(of: self.heightUnit, perform: { newUnit in
            if newUnit == UnitLength.centimeters {
                self.height = convertInchesToCentimeter(from: getInches(from: self.height)).value
            } else if newUnit == UnitLength.feet {
                self.height = convertCentimeterToInches(from: getCentimeters(from: self.height)).value
            }
            DispatchQueue.main.async {
                generateHeightsBars(in: self.heightUnit)
                self.heightIsLoading.toggle()
            }
            
        })
        .onChange(of: self.weightUnit, perform: { newUnit in
            if newUnit == UnitMass.kilograms {
                self.weight = convertPoundsToKilograms(from: getPounds(from: self.weight)).value
            } else if newUnit == UnitMass.pounds {
                self.weight = convertKilogramsToPounds(from: getKilograms(from: self.weight)).value
            }
            DispatchQueue.main.async {
                generateWeightsBars(in: self.weightUnit)
                self.weightIsLoading.toggle()
            }
            
        })
    }
        


    fileprivate func generateAgesBars() {
        self.barsAge.removeAll()
        
        for i in 1...120 {
            if Double(i).truncatingRemainder(dividingBy: 5) == 0 {
                barsAge.append(SliderConfiguration(barSize: Size.Large, cellWidth: (gap * 3), value: Double(i), formattedValue: String(i), showValue: true, valuePosition: .top))
            } else {
                barsAge.append(SliderConfiguration(barSize: Size.Medium, cellWidth: (gap * 1.5), value: Double(i), formattedValue: String(i)))
            }
        }
    }
    
    
    fileprivate func generateHeightsBars(in unit: UnitLength) {
        self.barsHeight.removeAll()

        if unit == UnitLength.centimeters {
            for i in 40...210 {
                let cm = getCentimeters(from: Double(i))
                let strValue = getFormattedCentimeters(from: cm)

                if cm.value.truncatingRemainder(dividingBy: 10) == 0.0 {
                    barsHeight.append(SliderConfiguration(barSize: Size.Large, cellWidth: (gap * 3), value: Double(i), formattedValue: strValue, showValue: true, valuePosition: .top))

                } else {
                    barsHeight.append(SliderConfiguration(barSize: Size.Medium, cellWidth: (gap * 1.5), value: Double(i), formattedValue: strValue))
                }
            }

        } else if unit == UnitLength.feet {
            for i in 1...86 {
                let inches = Measurement(value: Double(i), unit: UnitLength.inches)
                if Double(i).truncatingRemainder(dividingBy: 12) == 0 {
                    barsHeight.append(SliderConfiguration(barSize: Size.Large, cellWidth: (gap * 3), value: Double(i), formattedValue: getFormattedFeet(from: inches), showValue: true, valuePosition: .top))
                } else {
                    barsHeight.append(SliderConfiguration(barSize: Size.Medium, cellWidth: (gap * 1.5), value: Double(i), formattedValue: ""))
                }
            }
        }
    }
    
    fileprivate func generateWeightsBars(in unit: UnitMass) {
        self.barsWeight.removeAll()
        
        if unit == UnitMass.kilograms {
            for i in stride(from: 30.0, through: 300.0, by: 1.0) {
                let strValue = getFormattedKilograms(from: getKilograms(from: i))
                
                if i.truncatingRemainder(dividingBy: 10) == 0.0 {
                    barsWeight.append(SliderConfiguration(barSize: Size.Large, cellWidth: (gap * 3), value: i, formattedValue: strValue, showValue: true, valuePosition: .top))
                } else if i.truncatingRemainder(dividingBy: 5) == 0.0 {
                    barsWeight.append(SliderConfiguration(barSize: Size.Medium, cellWidth: (gap * 1.3), value: i, formattedValue: strValue, showValue: true, valuePosition: .top))
                } else {
                    barsWeight.append(SliderConfiguration(barSize: Size.Small, cellWidth: (gap * 1.2), value: i, formattedValue: strValue))
                }
            }
        } else if unit == UnitMass.pounds {
            for i in stride(from: 40.0, through: 660.0, by: 1.0) {
                let strValue = getFormattedPounds(from: getPounds(from: i))
                
                if i.truncatingRemainder(dividingBy: 10) == 0.0 {
                    barsWeight.append(SliderConfiguration(barSize: Size.Large, cellWidth: (gap * 3), value: i, formattedValue: strValue, showValue: true, valuePosition: .top))
                } else if i.truncatingRemainder(dividingBy: 5) == 0.0 {
                    barsWeight.append(SliderConfiguration(barSize: Size.Medium, cellWidth: (gap * 1.3), value: i, formattedValue: strValue, showValue: true, valuePosition: .top))
                } else {
                    barsWeight.append(SliderConfiguration(barSize: Size.Small, cellWidth: (gap * 1.2), value: i, formattedValue: strValue))
                }
            }
        }
    }

}

struct PersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationView()
    }
}

