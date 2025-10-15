//
//  TPECircleButton.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPECircleIconButton: View {
    let icon: String
    let size: CGFloat
    let iconColor: Color
    let backgroundColor: Color
    let borderColor: Color?
    let borderWidth: CGFloat
    let onPressed: (() -> Void)?
    let badgeCount: Int
    let badgeColor: Color
    let badgeTextColor: Color
    let badgeSize: CGFloat
    let showShadow: Bool
    
    public init(
        icon: String,
        size: CGFloat = 50,
        iconColor: Color = .white,
        backgroundColor: Color = TPEColors.primaryBlue,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        onPressed: (() -> Void)? = nil,
        badgeCount: Int = 0,
        badgeColor: Color = .red,
        badgeTextColor: Color = .white,
        badgeSize: CGFloat = 17,
        showShadow: Bool = false
    ) {
        self.icon = icon
        self.size = size
        self.iconColor = iconColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.onPressed = onPressed
        self.badgeCount = badgeCount
        self.badgeColor = badgeColor
        self.badgeTextColor = badgeTextColor
        self.badgeSize = badgeSize
        self.showShadow = showShadow
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            // Main circle button
            Button(action: {
                onPressed?()
            }) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: size, height: size)
                        .shadow(
                            color: showShadow ? .black.opacity(0.2) : .clear,
                            radius: showShadow ? 4 : 0,
                            x: 0,
                            y: showShadow ? 2 : 0
                        )
                    
                    if let borderColor = borderColor, borderWidth > 0 {
                        Circle()
                            .stroke(borderColor, lineWidth: borderWidth)
                            .frame(width: size, height: size)
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: size * 0.6, weight: .medium))
                        .foregroundColor(iconColor)
                }
            }
            .buttonStyle(CircleButtonStyle())
            .disabled(onPressed == nil)
            
            // Badge - positioned exactly like Flutter (top: 9, right: 7)
            if badgeCount > 0 {
                TPECountBadgeIcon(
                    badgeCount: badgeCount,
                    badgeSize: badgeSize,
                    badgeColor: badgeColor,
                    badgeTextColor: badgeTextColor
                )
                .offset(
                    x: badgeSize / 3, // Equivalent to right: 7
                    y: -badgeSize / 3 // Equivalent to top: 9
                )
            }
        }
        .frame(width: size, height: size)
    }
}

// Custom button style for circle button
public struct CircleButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
