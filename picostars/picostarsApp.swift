//
//  picostarsApp.swift
//  picostars
//
//  Created by Jeffrey Drake on 2025-04-05.
//

import SwiftUI

@main
struct picostarsApp: App {
    @State private var theme = PicoStarsTheme(name: "default", imageNames: ["Title/Big Planet", "Title/Blue Moon", "Title/Title"])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(theme)
        }
    }
}
