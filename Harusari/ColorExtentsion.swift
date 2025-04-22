//
//  ColorExtentsion.swift
//  Harusari
//
//  Created by Hwnag Seyeon on 4/14/25.
//

import SwiftUI

extension Color {
    
    static let pink0 = Color(hex: "F8BBD0")
    static let pink1 = Color(hex: "F48FB1")
    static let pink2 = Color(hex: "EC407A")
    static let pink3 = Color(hex: "FF4081")
    static let black0 = Color(hex: "2E2E2E")
    static let black1 = Color(hex: "1C1C1C")
    static let gray0 = Color(hex: "CCCCCC")
    static let gray1 = Color(hex: "F4F1F2")
    static let gray2 = Color(hex: "E2E2DF")
}

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
}
