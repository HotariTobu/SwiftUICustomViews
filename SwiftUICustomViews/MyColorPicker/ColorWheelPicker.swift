//
//  ColorWheelPicker.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorWheelPicker: View {
    @Binding var hue: Double
    @Binding var saturation: Double
    @Binding var brightness: Double
    
    var body: some View {
        GeometryReader {
            let center = CGPoint(x: $0.size.width / 2, y: $0.size.height / 2)
            let radius = max(center.x, center.y)
            ZStack {
                let r = Double(radius) * saturation
                let radian = hue * Double.pi * 2.0
                ColorWheel()
                Color.black
                    .opacity(1.0 - brightness)
                Circle()
                    .fill(HSV(h: hue, s: saturation, v: brightness).color)
                    .overlay(
                        Circle()
                            .stroke(Color.black)
                    )
                    .position(x: CGFloat(r * cos(radian) + 5.0), y: CGFloat(r * sin(radian) + 5.0))
                    .fixedSize()
            }
            .clipShape(Circle())
            .contentShape(Circle())
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { e in
                            let x = center.x - e.location.x
                            let y = center.y - e.location.y
                            
                            hue = (Double(atan2(y, x)) + Double.pi) / Double.pi / 2.0
                            saturation = min(1.0, Double(sqrt(x * x + y * y) / radius))
                        })
        }
    }
}

struct ColorWheelPicker_Previews: PreviewProvider {
    static var previews: some View {
        var h = 0.0
        var s = 0.0
        var v = 0.5
        let _h = Binding<Double>(get: { h }, set: { newValue in h = newValue })
        let _s = Binding<Double>(get: { s }, set: { newValue in s = newValue })
        let _v = Binding<Double>(get: { v }, set: { newValue in v = newValue })
        VStack {
            ColorWheelPicker(hue: _h.projectedValue, saturation: _s.projectedValue, brightness: _v.projectedValue)
                .frame(width: 300, height: 300, alignment: .center)
                .previewLayout(.fixed(width: 300, height: 300))
            Text("\(h), \(s), \(v)")
        }
    }
}
