//
//  PicoStarsTheme.swift
//  picostars
//
//  Created by Jeffrey Drake on 2025-04-05.
//

import Foundation
import SwiftUI
import ImageIO

@Observable
final class PicoStarsTheme: Sendable {
    let name: String
    
    let titleImageNames = ["Title/Big Planet", "Title/Blue Moon", "Title/Title", "Title/Starfield"]
    
    private let images: [String: UIImage]
        
    init(name: String, imageNames: [String]) {
        self.name = name;
        self.images = try! imageNames.reduce(into: [String:UIImage]()) { result, name in
            guard let img = UIImage(named: name) else {
                throw NSError(domain: "PicoStarsTheme", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image \(name) not found"])
            }
            
            result[name] = img
        }
    }
        
    func image(forName name: String) throws -> UIImage? {
        guard let image = images[name] else {
            throw NSError(domain: "PicoStarsTheme", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image \(name) not found"])
        }
     
        return image
    }
    
    func copy() -> PicoStarsTheme {
        PicoStarsTheme(name: name, imageNames: images.keys.map { $0 })
    }
}
