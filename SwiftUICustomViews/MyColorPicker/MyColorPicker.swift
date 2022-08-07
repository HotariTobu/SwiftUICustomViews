//
//  MyColorPicker.swift
//  SwiftUICustomViews
//  
//  Created by HotariTobu on 2022/08/07
//  
//

// Refer to https://github.com/Priva28/SwiftUIColourWheel

import SwiftUI

struct MyColorPicker: View {
    @State var color = Color.red
    
    var body: some View {
        ColorPickingView(color: $color, palette: [HSV]())
    }
}

struct MyColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        MyColorPicker()
    }
}
