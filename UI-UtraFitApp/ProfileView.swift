//
//  ProfileView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backColor
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(firstAccentColor)
                .frame(height: 320)
                
            HStack {
                Spacer()
                
                VStack(spacing: gap) {
                    Image("profile_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96)
                    
                    Text("Anabelle Kosta")
                        .font(Font.title3)
                        .foregroundColor(whiteColor)

                    Text("@anbelle_68")
                        .font(Font.caption)
                        .foregroundColor(whiteColor.opacity(0.7))
                    
                    Spacer().frame(height: gap)
                    
                    HStack(spacing: gap * 4) {
                        
                        HStack {
                            CapsuleIcon(imageName: "dumbell", imageRotation: .degrees(90), width: 20, height: 40)
                                
                            VStack(alignment: .leading) {
                                Text("70 kg")
                                    .font(Font.callout)
                                    .foregroundColor(whiteColor)
                                Text("Weight")
                                    .font(Font.callout)
                                    .foregroundColor(grayColor)
                            }
                        }

                        HStack {
                            CapsuleIcon(imageName: "height", width: 20, height: 40)
                                
                            VStack(alignment: .leading) {
                                Text("5ft 6\"")
                                    .font(Font.callout)
                                    .foregroundColor(whiteColor)
                                Text("Height")
                                    .font(Font.callout)
                                    .foregroundColor(grayColor)
                            }
                        }

                        HStack {
                            CapsuleIcon(imageName: "human", width: 20, height: 40)
                                
                            VStack(alignment: .leading) {
                                Text("25 yrs")
                                    .font(Font.callout)
                                    .foregroundColor(whiteColor)
                                Text("Age")
                                    .font(Font.callout)
                                    .foregroundColor(grayColor)
                            }
                        }

                    }
                }
                
                Spacer()
            }.offset(y: 80)
        

            ScrollView(showsIndicators: false) {
                VStack {

                    TodayCardView()

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                        SmallStatsCardView(title: "Running", subtitle: "2.5/3km", progress: 0.6, progressColor: firstAccentColor)

                        SmallStatsCardView(title: "Push-ups", subtitle: "78/100", progress: 0.78, progressColor: Color.orange)

                        SmallStatsCardView(title: "Cycling", subtitle: "6.5/10km", progress: 0.65, progressColor: Color.green)
                    }
                    .padding([.leading, .trailing, .bottom])
                    
                
                    CardView(backgroundColor: whiteColor) {
                        VStack(alignment: .leading) {
                            TitleView(value: "Goals for Today")

                            
                            HStack(spacing: gap * 2) {
                                
                                VStack {
                                    CircleProgressView(title: "", subtitle: "", progress: 1.0, width: 40)
                                    Text("Run")
                                        .font(Font.caption)
                                        .foregroundColor(grayColor)
                                }

                                VStack {
                                    CircleProgressView(title: "", subtitle: "", progress: 0.8, progressColor: Color.orange, width: 40)
                                    Text("Push-up")
                                        .font(Font.caption)
                                        .foregroundColor(grayColor)
                                }

                                VStack {
                                    CircleProgressView(title: "", subtitle: "", progress: 1.0, progressColor: Color.green, width: 40)
                                    Text("Walk")
                                        .font(Font.caption)
                                        .foregroundColor(grayColor)
                                }

                                VStack {
                                    CircleProgressView(title: "", subtitle: "", progress: 0.4, progressColor: Color.purple, width: 40)
                                    Text("Cycling")
                                        .font(Font.caption)
                                        .foregroundColor(grayColor)
                                }

                                VStack {
                                    CircleProgressView(title: "", subtitle: "", progress: 0.2, progressColor: Color.pink, width: 40)
                                    Text("Jump")
                                        .font(Font.caption)
                                        .foregroundColor(grayColor)
                                }
                            }
                        }
                    }.padding([.leading, .trailing, .bottom])
                    
                    Spacer().frame(height: 400)
                }
            }
            .offset(y: 320)
            
        }.ignoresSafeArea()

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
