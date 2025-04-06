//
//  TitleView.swift
//  picostars
//
//  Created by Jeffrey Drake on 2025-04-05.
//

import SwiftUI

struct TitleView: View {
    @Environment(PicoStarsTheme.self) var theme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                AlignedImage(name: "Title/Big Planet", geometry: geometry, alignment: (x: 50, y: 100), offset: { width, height in (0, height / 2) })
                AlignedImage(name: "Title/Blue Moon", geometry: geometry, alignment: (x: 75, y: 90))
                AlignedImage(name: "Title/Title", geometry: geometry, alignment: (x: 50, y: 35))
            }
            .border(Color.white, width: 1)
        }
    }
    
    func AlignedImage(name: String,
                      geometry: GeometryProxy,
                      alignment: (x: CGFloat, y: CGFloat),
                      offset: ((_ width: CGFloat, _ height: CGFloat) -> (x: CGFloat, y: CGFloat))? = nil) -> some View {
        guard let img = try? theme.image(forName: name) else {
            fatalError("Image \(name) not found")
        }
        
        let parentWidth = geometry.size.width
        let parentHeight = geometry.size.height
        
        let (width, height) = (img.size.width, img.size.height)
        
        let adjustment = offset?(width, height) ?? (x: 0, y: 0)
                
        let image = Image(uiImage: img)
            .interpolation(Image.Interpolation.none)
            .position(x: parentWidth * alignment.x / 100.0 + adjustment.x, y: parentHeight * alignment.y / 100.0 - adjustment.y)
        
        return image
    }
}

#Preview {
    let theme = PicoStarsTheme(name: "default",
                               imageNames: ["Title/Big Planet", "Title/Blue Moon", "Title/Title"])
    
    TitleView()
        .environment(theme)
}

