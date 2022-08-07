//
//  HSV.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct HSV {
    let h: Double
    let s: Double
    let v: Double
    
    var rgb: RGB {
        let max = v
        let range = s * max;
        let min = max - range;
        
        let hd = Int(h * 6.0) % 6
        let hdd = Int(h * 3.0) % 3
        
        var rgb = [0.0, 0.0, 0.0]
        rgb[hdd] = max;
        rgb[((hd + 1) / 2 + 1) % 3] = min;
        rgb[(5 - hd) % 3] = Double(hd % 2 == 0 ? -1 : 1) * (h * 6.0 - Double(hdd * 2 - 1)) * range + min;
        
        return RGB(r: rgb[0], g: rgb[1], b: rgb[2])
    }
    
    var color: Color {
        Color(hue: h, saturation: s, brightness: v)
    }
}

