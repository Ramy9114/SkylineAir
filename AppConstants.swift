//
//  AppConstants.swift
//  SkylineAir
//
//  Created by Rami on 22/03/2026.
//

import SwiftUI

enum AppConstants {

    // MARK: - Font Sizes

    enum FontSize {
        static let caption: CGFloat = 10
        static let footnote: CGFloat = 11
        static let subheadline: CGFloat = 12
        static let callout: CGFloat = 14
        static let body: CGFloat = 18
        static let title2: CGFloat = 24
        static let title1: CGFloat = 28
    }

    // MARK: - Spacing

    enum Spacing {
        static let xxSmall: CGFloat = 2
        static let xSmall: CGFloat = 4
        static let small: CGFloat = 6
        static let medium: CGFloat = 8
        static let large: CGFloat = 16
    }

    // MARK: - Padding

    enum Padding {
        static let content: CGFloat = 2
        static let badgeHorizontal: CGFloat = 6
        static let badgeVertical: CGFloat = 3
        static let badgeHorizontalMedium: CGFloat = 8
        static let badgeVerticalMedium: CGFloat = 4
    }

    // MARK: - Opacity

    enum Opacity {
        static let subtle: Double = 0.15
        static let muted: Double = 0.5
        static let secondary: Double = 0.6
        static let tertiary: Double = 0.7
        static let prominent: Double = 0.9
    }

    // MARK: - Colors

    enum AppColor {
        static let gradientStart = Color(red: 0.07, green: 0.16, blue: 0.33)
        static let gradientEnd = Color(red: 0.12, green: 0.32, blue: 0.58)
        static let gold = Color(red: 0.98, green: 0.84, blue: 0.46)
    }
}
