//
//  SliderRulerView.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-07-29.
//
// Depends On: Conversions.swift, Utils.swift

import SwiftUI


typealias CSize = (width: CGFloat, height: CGFloat)

enum Size {
    case Small
    case Medium
    case Large
}

extension Size: RawRepresentable {
    typealias RawValue = CSize

    init?(rawValue: RawValue) {
        switch rawValue {
            case (width: 1, height: 10): self = .Small
            case (width: 2, height: 20): self = .Medium
            case (width: 3, height: 30): self = .Large
            default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
            case .Small: return (width: 1, height: 10)
            case .Medium: return (width: 2, height: 20)
            case .Large: return (width: 3, height: 30)
        }
    }
}

enum VerticalPosition {
    case bottom
    case top
}


struct SliderConfiguration {
    var id = UUID()
    var barSize: Size = Size.Medium
    var cellWidth: CGFloat = gap * 3
    var value: Double
    var formattedValue: String
    var showValue: Bool = false
    var valuePosition: VerticalPosition = .bottom
}

fileprivate struct SliderRulerBarView: View {
    var config: SliderConfiguration

    var formatter: NumberFormatter = {
        let format = NumberFormatter()
        format.maximumFractionDigits = 1
        format.minimumFractionDigits = 0
        return format
    }()
        
    var body: some View {
        VStack {
            switch self.config.barSize {
            case Size.Small:
                if config.valuePosition == .bottom {
                    Spacer().frame(height: 40)
                    Rectangle()
                        .frame(width: Size.Small.rawValue.width, height: Size.Small.rawValue.height)
                        .cornerRadius(Size.Small.rawValue.width * 2)
                } else if config.valuePosition == .top {
                    Rectangle()
                        .frame(width: Size.Small.rawValue.width, height: Size.Small.rawValue.height)
                        .cornerRadius(Size.Small.rawValue.width * 2)
                }
            case Size.Medium:
                if config.valuePosition == .bottom {
                    Spacer().frame(height: 30)
                    Rectangle()
                        .fill(lightGrayColor)
                        .frame(width: Size.Medium.rawValue.width, height: Size.Medium.rawValue.height)
                        .cornerRadius(Size.Medium.rawValue.width * 2)

                    if config.showValue {
                        Text("\(config.formattedValue)")
                            .font(Font.caption)
                            .foregroundColor(lightGrayColor)
                            .allowsTightening(true)
                    }
                } else if config.valuePosition == .top {
                    if config.showValue {
                        Spacer().frame(height: 10)
                        
                        Text("\(config.formattedValue)")
                            .font(Font.caption)
                            .foregroundColor(lightGrayColor)
                            .allowsTightening(true)
                    }
                    Rectangle()
                        .fill(lightGrayColor)
                        .frame(width: Size.Medium.rawValue.width, height: Size.Medium.rawValue.height)
                        .cornerRadius(Size.Medium.rawValue.width * 2)
                }
            case Size.Large:
                if config.valuePosition == .bottom {
                    Rectangle()
                        .frame(width: Size.Large.rawValue.width, height: Size.Large.rawValue.height)
                        .cornerRadius(Size.Large.rawValue.width * 2)
                    if config.showValue {
                        Text("\(config.formattedValue)")
                            .font(Font.caption)
                            .allowsTightening(true)
                    }

                } else if config.valuePosition == .top {
                    if config.showValue {
                        Text("\(config.formattedValue)")
                            .font(Font.caption)
                            .allowsTightening(true)
                    }
                    Rectangle()
                        .frame(width: Size.Large.rawValue.width, height: Size.Large.rawValue.height)
                        .cornerRadius(Size.Large.rawValue.width * 2)
                }
            }
        }
        .padding([.top, .bottom, .trailing], 0)
        .fixedSize()
        .frame(minWidth: config.cellWidth, maxWidth: config.cellWidth)
    }
}

struct SliderRulerView: View {
    @Binding var barsConfig: [SliderConfiguration]
    @Binding var value: Double
    
    
    @State private var xPos: CGFloat = 0.0
    @State private var lastXPos: CGFloat = 0.0
    
    @State private var totalWidth: CGFloat = 0.0
    @State private var startPosition: CGFloat = 0.0
    
    @State private var allPosition: [CGFloat] = []
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                ForEach(barsConfig, id: \.self.id) { conf in
                    SliderRulerBarView(config: conf)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .offset(x: self.xPos)
            .overlay(Rectangle().fill(Color.red).frame(width: 2, height: 40), alignment: .bottom)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 1)
                .onChanged({ (c) in
                    self.xPos = self.lastXPos + c.translation.width
                    print(self.xPos)
                }).onEnded({ (c) in
                    let newIndex = self.closest(value: self.xPos, in: self.allPosition)
                    withAnimation {
                        self.xPos = self.allPosition[newIndex]
                    }
                    self.lastXPos = self.xPos
                    if let first = barsConfig.first {
                        self.value = Double(newIndex) + first.value
                    }
            }))
            .onChange(of: self.barsConfig.count, perform: { value in
                if self.barsConfig.count > 0 {
                    self.allPosition.removeAll()
                    
                    self.totalWidth = barsConfig.reduce(0) { (r, c) in return r + c.cellWidth }
                    if let first = barsConfig.first {
                        self.startPosition = (totalWidth / 2) - first.cellWidth / 2
                    }

                    var lastPosition = startPosition
                    for (i, e) in barsConfig.enumerated() {
                        self.allPosition.append(lastPosition)
                        if i < barsConfig.count-1 {
                            let nextE = barsConfig.index(after: i)
                            lastPosition -= (e.cellWidth + barsConfig[nextE].cellWidth) / 2
                            
                        }
                    }
                    
                    let index = self.closest(value: CGFloat(self.value), in: barsConfig.map { CGFloat($0.value) })
                    withAnimation {
                        self.xPos = self.allPosition[index]
                    }
                    self.lastXPos = self.xPos
                }
            })
        }
    }
    
    
    private func closest(value: CGFloat, in arr: [CGFloat]) -> Int {
        var smallestDiff = abs(value - arr.first!)
        var closest: Int = 0

        for (i, e) in arr.enumerated() {
            let currentDiff = abs(value - e);
            if (currentDiff < smallestDiff) {
                smallestDiff = currentDiff
                closest = i
            }
        }
        return closest
    }

}

struct SliderRulerView_Previews: PreviewProvider {
    @State static var age: Double = 1.0
    @State static var bars: [SliderConfiguration] = []
    
    static var previews: some View {
        SliderRulerView(barsConfig: $bars, value: $age)
            .onAppear {
                for i in 1...32 {
                    if Double(i).truncatingRemainder(dividingBy: 5) == 0 {
                        bars.append(SliderConfiguration(barSize: Size.Large, cellWidth: gap * 3, value: Double(i), formattedValue: String(i), showValue: true, valuePosition: .top))
                    } else {
                        bars.append(SliderConfiguration(barSize: Size.Medium, cellWidth: gap * 2, value: Double(i), formattedValue: String(i)))
                    }
                }
            }
    }
}
