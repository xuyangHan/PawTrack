import SwiftUI

enum AppTheme {
    static let background = Color(hex: 0xFAF9F7)
    static let card = Color.white
    static let primary = Color(hex: 0x146B4F)
    static let secondary = Color(hex: 0x34618D)
    static let tertiary = Color(hex: 0x8E4E14)
    static let textPrimary = Color(hex: 0x1A1C1B)
    static let textSecondary = Color(hex: 0x3F4943)
    static let divider = Color(hex: 0xBEC9C2)
}

enum AppSpacing {
    static let page: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let cardGap: CGFloat = 20
    static let cornerRadius: CGFloat = 16
}

extension Font {
    static let appDisplay = Font.system(size: 34, weight: .bold, design: .rounded)
    static let appHeadline = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let appBody = Font.system(size: 17, weight: .regular, design: .default)
    static let appCaption = Font.system(size: 13, weight: .semibold, design: .default)
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}
