//
//  ColorPickingView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

import WrappingHStack

struct ColorPickingView: View {
    @Binding var color: Color
    
    @State var palette: [HSV]
    
    @State var isPopoverPresented = false
    
    @State var hue = 0.0
    @State var saturation = 0.0
    @State var brightness = 1.0
    @State var opacity = 1.0
    
    var body: some View {
        color = Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
        return VStack {
            Capsule()
                .fill(color)
                .frame(height: 10)
                .padding(.horizontal)
            Divider()
            ColorWheelPicker(hue: $hue, saturation: $saturation, brightness: $brightness)
                .frame(width: 200, height: 200, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 4)
                )
            ColorSlider(value: $brightness, color: color, colors: [Color(hue: hue, saturation: saturation, brightness: 0.0), Color(hue: hue, saturation: saturation, brightness: 1.0)])
                .padding(.horizontal)
            ColorSlider(value: $opacity, color: color, colors: [Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 0.0), Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 1.0)])
                .background(
                    GeometryReader {
                        let tileSize = $0.size.height / 3.0
                        let count = Int(round($0.size.width / tileSize))
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(0 ..< count) {
                                    ($0 % 2 == 0 ? Color.gray : Color.white)
                                        .frame(width: tileSize)
                                }
                            }
                            HStack(spacing: 0) {
                                ForEach(0 ..< count) {
                                    ($0 % 2 == 0 ? Color.white : Color.gray)
                                        .frame(width: tileSize)
                                }
                            }
                            HStack(spacing: 0) {
                                ForEach(0 ..< count) {
                                    ($0 % 2 == 0 ? Color.gray : Color.white)
                                        .frame(width: tileSize)
                                }
                            }
                        }
                    }
                )
                .clipShape(Capsule())
                .padding(.horizontal)
            Divider()
            ScrollView {
                WrappingHStack(-1 ..< palette.count, id:\.self, spacing: .constant(10)) { index -> AnyView in
                    if index == -1 {
                        return AnyView(
                            ZStack {
                                Circle()
                                    .fill(color)
                                    .frame(width: 50, height: 50)
                                    .padding(.vertical, 5)
                                    .onTapGesture {
                                        palette.insert(HSV(h: hue, s: saturation, v: brightness), at: 0)
                                    }
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                                    .shadow(radius: 10)
                            }
                            .shadow(radius: 10)
                        )
                    }
                    else {
                        return AnyView(
                            Circle()
                                .fill(palette[index].color)
                                .frame(width: 50, height: 50)
                                .padding(.vertical, 5)
                                .onTapGesture {
                                    let hsv = palette[index]
                                    hue = hsv.h
                                    saturation = hsv.s
                                    brightness = hsv.v
                                    color = hsv.color
                                }
                        )
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 150)
        }
    }
}

struct ColorPickingView_Previews: PreviewProvider {
    static var previews: some View {
        var color = Color.white
        let _color = Binding<Color>( get: { color }, set: { color = $0 })
        var palette = Array(0...10).map { _ in
            HSV(h: Double.random(in: 0...1), s: Double.random(in: 0...1), v: Double.random(in: 0...1))
        }
        let _palette = Binding<[HSV]>(get: { palette }, set: { palette = $0 })
        ColorPickingView(color: _color, palette: palette)
    }
}
