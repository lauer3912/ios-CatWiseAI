import UIKit
import SnapKit

class Theme {
    // MARK: - Colors
    enum Colors {
        static let primary = UIColor(hex: "#D4AF37")         // Warm Gold
        static let primaryLight = UIColor(hex: "#E8C964")   // Light Gold
        static let secondary = UIColor(hex: "#20B2AA")      // Teal
        static let accent = UIColor(hex: "#FF8C42")          // Tropical Orange
        static let backgroundDark = UIColor(hex: "#1a1a1a")   // Deep Charcoal
        static let backgroundCard = UIColor(hex: "#2D2D2D")  // Dark Card
        static let backgroundElevated = UIColor(hex: "#3D3D3D") // Elevated
        static let textPrimary = UIColor(hex: "#FFF8E7")     // Cream White
        static let textSecondary = UIColor(hex: "#B0A88A")   // Muted Gold
        static let textMuted = UIColor(hex: "#808080")       // Gray
        static let success = UIColor(hex: "#4CAF50")         // Green
        static let warning = UIColor(hex: "#FFC107")        // Yellow
        static let error = UIColor(hex: "#F44336")           // Red
    }

    // MARK: - Gradients
    enum Gradients {
        static let goldGradient: [UIColor] = [Colors.primary, Colors.primaryLight]
        static let darkGradient: [UIColor] = [Colors.backgroundDark, Colors.backgroundCard]
    }

    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xl: CGFloat = 24
        static let full: CGFloat = 9999
    }

    // MARK: - Shadows
    enum Shadow {
        static func apply(to view: UIView, opacity: Float = 0.3, radius: CGFloat = 16, offset: CGSize = CGSize(width: 0, height: 8)) {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = opacity
            view.layer.shadowRadius = radius
            view.layer.shadowOffset = offset
            view.layer.masksToBounds = false
        }

        static func glow(to view: UIView, color: UIColor, radius: CGFloat = 20) {
            view.layer.shadowColor = color.cgColor
            view.layer.shadowOpacity = 0.6
            view.layer.shadowRadius = radius
            view.layer.shadowOffset = .zero
        }
    }

    // MARK: - Fonts
    enum Font {
        static func largeTitle() -> UIFont { return .systemFont(ofSize: 34, weight: .bold) }
        static func title1() -> UIFont { return .systemFont(ofSize: 28, weight: .bold) }
        static func title2() -> UIFont { return .systemFont(ofSize: 22, weight: .semibold) }
        static func title3() -> UIFont { return .systemFont(ofSize: 20, weight: .semibold) }
        static func headline() -> UIFont { return .systemFont(ofSize: 17, weight: .semibold) }
        static func body() -> UIFont { return .systemFont(ofSize: 17, weight: .regular) }
        static func callout() -> UIFont { return .systemFont(ofSize: 16, weight: .regular) }
        static func subhead() -> UIFont { return .systemFont(ofSize: 15, weight: .regular) }
        static func footnote() -> UIFont { return .systemFont(ofSize: 13, weight: .regular) }
        static func caption() -> UIFont { return .systemFont(ofSize: 12, weight: .regular) }
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension CAGradientLayer {
    static func goldGradient(frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = Theme.Gradients.goldGradient.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
}