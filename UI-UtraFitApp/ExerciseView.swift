//
//  ExerciseView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI
import AVKit


struct ExerciseView: View {
//    @State var player: AVPlayer = AVPlayer()
    
    @State var finished: Bool = false
    
    var body: some View {
        VStack {
            YourProgressionView(value: 4, total: 7)
                .padding(.bottom, gap * 2)
            
            Section(header: VStack(alignment: .leading, spacing: gap) {
                Text("Round 1")
                    .font(Font.title.bold())
                    
                Text("Legs & Butt Workouts")
                    .font(Font.callout)
                    .foregroundColor(grayColor)
                HStack { Spacer() }
                }
            .padding(.bottom, gap)
            ) {
                CardView(backgroundColor: whiteColor) {
                    VStack {
                        HStack {
                            TitleView(value: "Butterfly Sit Ups")
                            Spacer()
                            Image(systemName: "checkmark")
                                .font(Font.caption)
                                .foregroundColor(self.finished ? whiteColor : grayColor)
                                .padding(.all, gap / 2)
                                .background(Circle().fill(self.finished ? tealColor.opacity(0.6) : lightGrayColor))
                                .onTapGesture(count: 1, perform: {
                                    self.finished.toggle()
                                })
                        }
                        .padding(.bottom, gap)
                        
//                        VideoPlayer(player: self.player) {
//                            Image(systemName: "play.fill")
//                                .foregroundColor(.blue)
//                                .offset(x: 4)
//                                .font(Font.title)
//                                .padding()
//                                .background(Circle().fill(whiteColor))
//                                .onTapGesture(count: 1, perform: {
//                                    self.player.play()
//                                    print("Play")
//                                })
//                        }
                        ZStack {
                            Image("women-situps")
                                .resizable()
                                .scaledToFit()
                                .overlay(Rectangle().opacity(0.2))
                            
                            Image(systemName: "play.fill")
                                .foregroundColor(.blue)
                                .offset(x: 4)
                                .font(Font.title)
                                .padding()
                                .background(Circle().fill(whiteColor))
                        }
                        .cornerRadius(20)
                        .frame(height: 200)
                        .padding(.bottom, gap * 2)
                        
                        StepsView(steps: [
                            "Lie faceup on the mat, with your arms extended past your head",
                            "Bend your knees and have the soles of your feet facing one another so it's in a diamond shape"
                        ])
                    }.padding(.all, gap)
                }
            }
            Spacer()
        }.padding()
        .onAppear {
//            self.player = AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=1fbU_MkV7NE")!)
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
