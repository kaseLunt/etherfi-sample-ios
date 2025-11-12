//
//  AppColors.swift
//  EtherFiTracker
//

import SwiftUI

// MARK: - Color Extensions
extension Color {
    // App Brand Colors - Purple Theme
    static let appBackground = Color(hex: "1A1637")
    static let cardBackground = Color(hex: "100A30")
    static let cardBackgroundLight = Color(hex: "1A0F42")
    static let cardBorder = Color(hex: "302659")
    static let textLavender = Color(hex: "B8A9E8")
    static let textAccent = Color(hex: "8B7BC8")
    static let purpleArrow = Color(hex: "BA86FC")
    
    // Gradient Colors
    static let gradientStart = Color(hex: "29BCFA")
    static let gradientMiddle = Color(hex: "6464E4")
    static let gradientEnd = Color(hex: "B45AFA")
    
    // Input Gradient Colors
    static let inputGradientStart = Color(hex: "9F62F2")
    static let inputGradientEnd = Color(hex: "5FEDEB")
    
    // Card Screen Specific
    static let cardScreenBackground = Color(hex: "0a0a0d")
    static let cardScreenDivider = Color(hex: "262628")
    
    // EtherFi Brand Colors
    static let etherFiDarkBackground = Color(hex: "131316")
    static let etherFiCream = Color(hex: "FAF8F0")
    static let etherFiGold = Color(hex: "C8AB7A")
    static let etherFiDarkSurface = Color(hex: "1F1F21")
    
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

// MARK: - Gradient Definitions
extension LinearGradient {
    static let primaryGradient = LinearGradient(
        stops: [
            .init(color: .gradientStart, location: 0.1423),
            .init(color: .gradientMiddle, location: 0.4515),
            .init(color: .gradientEnd, location: 0.8614)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let inputBoxGradient = LinearGradient(
        stops: [
            .init(color: .inputGradientStart.opacity(0.16), location: -0.04),
            .init(color: .inputGradientEnd.opacity(0), location: 1.2034)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let dividerGradient = LinearGradient(
        stops: [
            .init(color: .inputGradientStart.opacity(0.45), location: -0.04),
            .init(color: .inputGradientEnd.opacity(0), location: 1.2034)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Custom View Modifiers
struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.textLavender)
    }
}

extension View {
    func appTheme() -> some View {
        modifier(AppThemeModifier())
    }
}
