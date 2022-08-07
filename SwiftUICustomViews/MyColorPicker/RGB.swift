//
//  RGB.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct RGB {
    let r: Double
    let g: Double
    let b: Double
    
    var hsv: HSV {
        let max = max(r, g, b)
        let min = min(r, g, b)
        let range = max - min
        
        var h = 0.0
        let s = range / max
        let v = max
        
        if (range > 0)
        {
            switch max {
            case r:
                h = (g - b) / range + 1.0;
            case g:
                h = (b - r) / range + 3.0;
            default:
                h = (r - g) / range + 5.0;
            }
            h /= 6.0;
        }
        
        return HSV(h: h, s: s, v: v)
    }
    
    var color: Color {
        Color(red: r, green: g, blue: b)
    }
}

