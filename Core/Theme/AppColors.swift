//
//  AppColors.swift
//  EtherFiTracker
//

import SwiftUI

extension Color {
    // EtherFi Brand Colors
    static let etherFiDarkBackground = Color(hex: "131316")
    static let etherFiCream = Color(hex: "FAF8F0")
    static let etherFiGold = Color(hex: "C8AB7A")
    static let etherFiDarkSurface = Color(hex: "1F1F21")
    
    // Purple Theme Colors
    static let purpleDark = Color(hex: "1A1637")
    static let purpleMedium = Color(hex: "100A30")
    static let purpleLight = Color(hex: "1A0F42")
    static let lavenderText = Color(hex: "B8A9E8")
    static let lavenderAccent = Color(hex: "8B7BC8")
    
    // Gradient Colors
    static let gradientStart = Color(hex: "29BCFA")
    static let gradientMiddle = Color(hex: "6464E4")
    static let gradientEnd = Color(hex: "B45AFA")
    
    // Helper to create color from hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Gradient Definitions
extension LinearGradient {
    static let etherFiGradient = LinearGradient(
        colors: [.gradientStart, .gradientMiddle, .gradientEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
