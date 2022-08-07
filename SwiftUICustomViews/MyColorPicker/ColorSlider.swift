//
//  ColorSlider.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    
    let color: Color
    let colors: [Color]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
            GeometryReader {
                let range = $0.size.width - 34
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 34, height: 34)
                        .shadow(radius: 10)
                    Circle()
                        .fill(color)
                        .frame(width: 28, height: 28)
                        .shadow(radius: 10)
                }
                .position(x: CGFloat(value) * range + 17, y: 17)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged { e in
                                let newValue = (e.location.x - 34) / range
                                if newValue < 0 {
                                    value = 0
                                }
                                else if newValue > 1 {
                                    value = 1
                                }
                                else {
                                    value = Double(newValue)
                                }
                            })
            }
            .padding(3)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 40)
        .clipShape(Capsule())
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        var value = 0.3
        let _value = Binding<Double>(get: { value }, set: { value = $0 })
        ColorSlider(value: _value, color: .purple, colors: [.red, .blue])
    }
}
