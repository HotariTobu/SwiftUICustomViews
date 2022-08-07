//
//  ContentView.swift
//  SwiftUICustomViews
//  
//  Created by HotariTobu on 2022/08/07
//  
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Group {
                        NavigationLink("MyColorPicker") {
                            MyColorPicker()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
