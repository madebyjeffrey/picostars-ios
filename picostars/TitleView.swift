//
//  TitleView.swift
//  picostars
//
//  Created by Jeffrey Drake on 2025-04-05.
//

import SwiftUI

struct TitleView: View {
    @State private var image: UIImage?
    @State private var size: CGSize = CGSizeZero
    
    var body: some View {
        ZStack {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .onGeometryChange(for: CGSize.self) {
                    CGSize(width: $0.size.width, height: $0.size.height)
                } action: { newValue in size = newValue }
            if image != nil {
                Image(uiImage: image!)
                    .interpolation(.none)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onChange(of: size, initial: false) {
            print(size)
            
            image = updateImage(size)
        }
    }
    
    func updateImage(_ size: CGSize) -> UIImage? {
        // we are generating an image that should be scaled 2.0 to ensure it is pixelated
        let width = size.width / 2
        let height = size.height / 2
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
    
        context.setFillColor(UIColor.black.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        context.interpolationQuality = .none
        
        guard let bigPlanet = UIImage(named: "Title/Big Planet"),
              let title = UIImage(named: "Title/Title"),
              let starfield = UIImage(named: "Title/Starfield"),
              let blueMoon = UIImage(named: "Title/Blue Moon") else {
            return nil
        }
        
        var scale = 1.0
        
        print("Big Planet: \(bigPlanet.size.width) x \(bigPlanet.size.height)")
        print("Title: \(title.size.width) x \(title.size.height)")
        print("Width: \(width) x Height: \(height)")
        
        if (title.size.width < width / 2.0 && bigPlanet.size.height < height / 4.0) {
            scale = 2.0;
        }
        
        print("Scale: \(scale)")
        
        let starfieldLocation = CGRect(
            x: width * 0.5 - starfield.size.width * scale * 1.0 / 2.0,
            y: height * 0.5 - starfield.size.height * scale * 1.0 / 2.0,
            width: starfield.size.width * scale * 1.0,
            height: starfield.size.height * scale * 1.0
        )
        
        starfield.draw(in: starfieldLocation)
        
        let bigPlanetLocation = CGRect(
            x: width / 2.0 - bigPlanet.size.width * scale / 2.0,
            y: height - bigPlanet.size.height * scale,
            width: bigPlanet.size.width * scale,
            height: bigPlanet.size.height * scale
        )
        
        bigPlanet.draw(in: bigPlanetLocation)
        
        
        let blueMoonLocation = CGRect(
            x: width * 0.75 - blueMoon.size.width * scale / 2.0,
            y: height * 0.6,
            width: blueMoon.size.width * scale,
            height: blueMoon.size.height * scale
        )
        
        blueMoon.draw(in: blueMoonLocation)
        
        // We do this because on an iPad mini in portrait mode the title is too large
        let titleScale = title.size.width * scale > width ? width / title.size.width : scale
        
        let titleLocation = CGRect(
            x: width * 0.50 - title.size.width * titleScale / 2.0,
            y: height * 0.35 - title.size.height * titleScale / 2.0,
            width: title.size.width * titleScale,
            height: title.size.height * titleScale
        )
        
        title.draw(in: titleLocation)
        
        // This is for testing if the image is covering the screen
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(5.0)
//        context.move(to: CGPoint(x: 0, y: height))
//        context.addLine(to: CGPoint(x: width, y: 0))
//        
//        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
        
}

#Preview {
    TitleView()
}

