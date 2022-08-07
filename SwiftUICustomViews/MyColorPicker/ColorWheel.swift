//
//  ColorWheel.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorWheel: View {
    @State var quality = 10
    
    var body: some View {
        let colors = Array(0 ... quality).map {
            Color(hue: Double($0) / Double(quality), saturation: 1, brightness: 1)
        }
        ZStack {
            AngularGradient(gradient: Gradient(colors: colors), center: .center)
                .blur(radius: 8)
            GeometryReader {
                let radius = max($0.size.width, $0.size.height) / 2
                RadialGradient(gradient: Gradient(colors: [.white, .black]), center: .center, startRadius: 0, endRadius: radius)
                    .blendMode(.screen)
            }
        }
        .clipShape(Ellipse())
    }
}

struct ColorWheel_Previews: PreviewProvider {
    static var previews: some View {
        ColorWheel(quality: 10)
            .previewLayout(.fixed(width: 300, height: 300
            ))
    }
}
