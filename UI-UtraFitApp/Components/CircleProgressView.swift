//
//  CircleProgressView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-01.
//

import SwiftUI

struct CircleProgressView: View {
    
    var title: String
    var subtitle: String
    @State var progress: CGFloat = 0.0
    
    var isFilled: Bool = false

    var backgroundColor: Color = lightGrayColor
    var progressColor: Color = firstAccentColor
    
    @State var width: CGFloat = UIScreen.main.bounds.width
    @State var height: CGFloat = UIScreen.main.bounds.height
    
    @State private var progressAngle: Angle = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: self.width * 0.08)
                .frame(width: self.width - (self.width * 0.08))


            if self.isFilled {
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(style: StrokeStyle(lineWidth: self.width * 0.08, lineCap: .round, lineJoin: .round))
                    .fill(progressColor)
                    .frame(width: self.width - (self.width * 0.08))

                WedgeShape(angleStart: Angle(degrees: 0), angleEnd: self.progressAngle)
                    .rotation(.degrees(-90))
                    .fill(progressColor)
                    .frame(width: self.width - (self.width * 0.25), height: self.width - (self.width * 0.25))

            } else {
                Circle()
                    .trim(from: 0.0, to: self.progress)
                    .rotation(.degrees(-90))
                    .stroke(style: StrokeStyle(lineWidth: self.width * 0.08, lineCap: .round, lineJoin: .round))
                    .fill(progressColor)
                    .frame(width: self.width - (self.width * 0.08))

                VStack {
                    Text("\(title)")
                        .font(Font.system(size: self.width * 0.17).bold())
                        
                        
                        
                    Text("\(subtitle)")
                        .font(Font.system(size: self.width * 0.12))
                        .foregroundColor(grayColor)
                }
            }
        }
        .onChange(of: self.progress, perform: { value in
            self.progressAngle = Angle(degrees: Double(value * 360) )
        })
        .onAppear {
            self.height = self.width
            
            if self.progress < 0.0 {
                self.progress = 0.0
            } else if self.progress > 1.0 {
                self.progress = 1.0
            }
            self.progressAngle = Angle(degrees: Double(self.progress * 360) )
        }.frame(width: self.width, height: self.height)
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
//        CircleProgressView(title: "1200", subtitle: "Cal left", progress: 0.6)

        CircleProgressView(title: "", subtitle: "", progress: 0.6, isFilled: true)
    }
}

struct WedgeShape: Shape {
    var angleStart: Angle
    var angleEnd: Angle
    
//    public var animatableData: AnimatablePair<Double, Double> {
//        get {
//           AnimatablePair(Double(angleOffset), Double(wedgeWidth))
//        }
//
//        set {
//            self.angleOffset = newValue.first
//            self.wedgeWidth = newValue.second
//        }
//    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = Double(rect.width)
            let height = Double(rect.height)
            
            let middlePoint = CGPoint(x: width/2, y: height/2)
            path.move(to: middlePoint)

            path.addArc(center: middlePoint, radius: rect.width / 2, startAngle: self.angleStart, endAngle: self.angleEnd, clockwise: false)
            path.addLine(to: middlePoint)
        }
    }
}
