////
////  f.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 23/10/25.
////
//
//import SwiftUI
//
//public struct TPENavigationCardButton: View {
//    // MARK: - Public Properties
//    public let text: String
//    public let onTap: () -> Void
//    public let textColor: Color?
//    public let backgroundColor: Color?
//    public let iconColor: Color?
//    public let padding: EdgeInsets?
//    public let borderRadius: CGFloat?
//    public let showShadow: Bool
//    
//    // MARK: - Public Initializer
//    public init(
//        text: String,
//        onTap: @escaping () -> Void,
//        textColor: Color? = nil,
//        backgroundColor: Color? = nil,
//        iconColor: Color? = nil,
//        padding: EdgeInsets? = nil,
//        borderRadius: CGFloat? = nil,
//        showShadow: Bool = true
//    ) {
//        self.text = text
//        self.onTap = onTap
//        self.textColor = textColor
//        self.backgroundColor = backgroundColor
//        self.iconColor = iconColor
//        self.padding = padding
//        self.borderRadius = borderRadius
//        self.showShadow = showShadow
//    }
//    
//    // MARK: - Public Body
//    public var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Text(text)
//                    .font(.system(size: 14, weight: .regular)) // Secondary variant equivalent
//                    .foregroundColor(textColor ?? defaultTextColor)
//                    .lineLimit(1)
//                
//                Spacer()
//                
//                Image(systemName: "arrow.forward")
//                    .font(.system(size: 20, weight: .medium))
//                    .foregroundColor(iconColor ?? textColor ?? defaultTextColor)
//            }
//            .padding(padding ?? EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
//        }
//        .background(
//            RoundedRectangle(cornerRadius: borderRadius ?? 12)
//                .fill(backgroundColor ?? defaultBgColor)
//        )
//        .overlay(
//            RoundedRectangle(cornerRadius: borderRadius ?? 12)
//                .stroke(Color.clear, lineWidth: 1)
//        )
//        .shadow(
//            color: showShadow ? Color.black.opacity(0.1) : Color.clear,
//            radius: showShadow ? 2 : 0,
//            x: 0,
//            y: showShadow ? 1 : 0
//        )
//        .cornerRadius(borderRadius ?? 12)
//    }
//    
//    // MARK: - Computed Properties for Default Colors
//    
//    private var defaultTextColor: Color {
//        @Environment(\.colorScheme) var colorScheme
//        return colorScheme == .dark ? .white : TPEColors.blue70
//    }
//    
//    private var defaultBgColor: Color {
//        @Environment(\.colorScheme) var colorScheme
//        if let backgroundColor = backgroundColor {
//            return backgroundColor
//        }
//        return colorScheme == .dark ?
//            TPEColors.dark10.opacity(0.8) :
//            TPEColors.white.opacity(0.9)
//    }
//}
//
//// MARK: - Preview
//struct TPENavigationCardButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 16) {
//            TPENavigationCardButton(
//                text: "Light Mode Button",
//                onTap: { print("Tapped!") }
//            )
//            
//            TPENavigationCardButton(
//                text: "Custom Styled Button",
//                onTap: { print("Tapped!") },
//                textColor: .red,
//                backgroundColor: .yellow,
//                borderRadius: 20,
//                showShadow: false
//            )
//        }
//        .padding()
//        .previewLayout(.sizeThatFits)
//    }
//}


//
//  f.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 23/10/25.
//

import SwiftUI

public struct TPENavigationCardButton: View {
    // MARK: - Public Properties
    public let text: String
    public let onTap: () -> Void
    public let textColor: Color?
    public let backgroundColor: Color?
    public let iconColor: Color?
    public let padding: EdgeInsets?
    public let borderRadius: CGFloat?
    public let showShadow: Bool
    
    // MARK: - Public Initializer
    public init(
        text: String,
        onTap: @escaping () -> Void,
        textColor: Color? = nil,
        backgroundColor: Color? = nil,
        iconColor: Color? = nil,
        padding: EdgeInsets? = nil,
        borderRadius: CGFloat? = nil,
        showShadow: Bool = true
    ) {
        self.text = text
        self.onTap = onTap
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.padding = padding
        self.borderRadius = borderRadius
        self.showShadow = showShadow
    }
    
    // MARK: - Public Body
    public var body: some View {
        Button(action: onTap) {
            HStack {
                Text(text)
                    .font(.system(size: 16, weight: .semibold)) // Increased size and weight for better readability
                    .foregroundColor(textColor ?? defaultTextColor)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.right") // Changed to chevron.right for cleaner look
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(iconColor ?? textColor ?? defaultTextColor)
            }
            .padding(padding ?? EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)) // Increased padding for better touch area
        }
        .background(
            RoundedRectangle(cornerRadius: borderRadius ?? 12)
                .fill(backgroundColor ?? defaultBgColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: borderRadius ?? 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Subtle border instead of clear
        )
        .shadow(
            color: showShadow ? Color.black.opacity(0.08) : Color.clear, // Softer shadow
            radius: showShadow ? 4 : 0,
            x: 0,
            y: showShadow ? 2 : 0
        )
        .cornerRadius(borderRadius ?? 12)
    }
    
    // MARK: - Computed Properties for Default Colors
    
    private var defaultTextColor: Color {
        @Environment(\.colorScheme) var colorScheme
        return colorScheme == .dark ? .white : TPEColors.blue70
    }
    
    private var defaultBgColor: Color {
        @Environment(\.colorScheme) var colorScheme
        if let backgroundColor = backgroundColor {
            return backgroundColor
        }
        return colorScheme == .dark ?
            TPEColors.dark10.opacity(0.9) :
            Color.white // Solid white for cleaner look
    }
}

// MARK: - Usage Example for "Lihat Semua Rekeningmu"
extension TPENavigationCardButton {
    /// Convenience method for creating "View All Accounts" style button
    public static func viewAllAccounts(
        onTap: @escaping () -> Void,
        textColor: Color? = TPEColors.blue70,
        backgroundColor: Color? = .white
    ) -> TPENavigationCardButton {
        return TPENavigationCardButton(
            text: "Lihat Semua Rekeningmu",
            onTap: onTap,
            textColor: textColor,
            backgroundColor: backgroundColor,
            iconColor: textColor,
            padding: EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20),
            borderRadius: 12,
            showShadow: true
        )
    }
}

// MARK: - Preview
struct TPENavigationCardButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            // Original style buttons
            TPENavigationCardButton(
                text: "Light Mode Button",
                onTap: { print("Tapped!") }
            )
            
            TPENavigationCardButton(
                text: "Custom Styled Button",
                onTap: { print("Tapped!") },
                textColor: .red,
                backgroundColor: .yellow,
                borderRadius: 20,
                showShadow: false
            )
            
            // New "Lihat Semua Rekeningmu" style
            TPENavigationCardButton.viewAllAccounts(
                onTap: { print("View all accounts tapped!") }
            )
            
            TPENavigationCardButton(
                text: "Lihat Semua Rekeningmu",
                onTap: { print("Tapped!") },
                textColor: TPEColors.blue70,
                backgroundColor: .white,
                padding: EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color.gray.opacity(0.1))
    }
}
