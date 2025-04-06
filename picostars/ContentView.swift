//
//  ContentView.swift
//  picostars
//
//  Created by Jeffrey Drake on 2025-04-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TitleView()
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    let theme = PicoStarsTheme(name: "default", imageNames: ["Title/Big Planet", "Title/Blue Moon", "Title/Title"])
    
    ContentView()
        .environment(theme)
        
        
}
