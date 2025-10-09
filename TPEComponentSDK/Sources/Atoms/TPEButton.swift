//
//  TPEButton.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI

public enum TPEButtonVariant: CaseIterable {
    case primary, secondary, outline, danger, success, warning
    
    public var name: String {
        switch self {
        case .primary: return "Primary"
        case .secondary: return "Secondary"
        case .outline: return "Outline"
        case .danger: return "Danger"
        case .success: return "Success"
        case .warning: return "Warning"
        }
    }
}

public enum TPEButtonSize: CaseIterable {
    case small, medium, large
    
    public var name: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        }
    }
}

public enum TPEButtonRound: CaseIterable {
    case rounded, pill, square
    
    public var name: String {
        switch self {
        case .rounded: return "Rounded"
        case .pill: return "Pill"
        case .square: return "Square"
        }
    }
}

public struct TPEButton: View {
    let title: String
    let variant: TPEButtonVariant
    let size: TPEButtonSize
    let roundType: TPEButtonRound
    let isCentered: Bool
    let isEnabled: Bool
    let isLoading: Bool
    let icon: String?
    let iconPosition: IconPosition
    let action: () -> Void
    
    public enum IconPosition {
        case leading, trailing
    }
    
    public init(
        title: String,
        variant: TPEButtonVariant = .primary,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded,
        isCentered: Bool = false,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        icon: String? = nil,
        iconPosition: IconPosition = .leading,
        onPressed action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.roundType = roundType
        self.isCentered = isCentered
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.icon = icon
        self.iconPosition = iconPosition
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: progressViewColor))
                        .scaleEffect(0.8)
                } else {
                    // Leading icon
                    if let icon = icon, iconPosition == .leading {
                        Image(systemName: icon)
                            .font(iconFont)
                    }
                    
                    Text(title)
                        .font(font)
                        .fontWeight(fontWeight)
                        .foregroundColor(foregroundColor)
                    
                    // Trailing icon
                    if let icon = icon, iconPosition == .trailing {
                        Image(systemName: icon)
                            .font(iconFont)
                    }
                }
            }
            .frame(maxWidth: isCentered ? .infinity : nil, minHeight: minHeight)
            .padding(padding)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // ADD THIS LINE
            .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(!isEnabled || isLoading)
        .opacity(opacity)
        .accessibilityLabel(accessibilityLabel)
    }
    
    // MARK: - Computed Properties
    
    private var backgroundColor: Color {
        if !isEnabled {
            return disabledBackgroundColor
        }
        
        switch variant {
        case .primary:
            return TPEColors.blue70
        case .secondary:
            return Color(.systemGray5)
        case .outline:
            return .clear
        case .danger:
            return .red
        case .success:
            return .green
        case .warning:
            return .orange
        }
    }
    
    private var disabledBackgroundColor: Color {
        switch variant {
        case .outline:
            return .clear
        default:
            return Color(.systemGray4)
        }
    }
    
    private var foregroundColor: Color {
        if !isEnabled {
            return disabledForegroundColor
        }
        
        switch variant {
        case .primary, .danger, .success, .warning:
            return .white
        case .secondary:
            return .primary
        case .outline:
            return TPEColors.blue70
        }
    }
    
    private var disabledForegroundColor: Color {
        .gray
    }
    
    private var borderColor: Color {
        if !isEnabled {
            return .gray.opacity(0.3)
        }
        
        switch variant {
        case .outline:
            return TPEColors.blue70
        case .danger:
            return .red
        case .success:
            return .green
        case .warning:
            return .orange
        default:
            return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch variant {
        case .outline, .danger, .success, .warning:
            return 1.5
        default:
            return 0
        }
    }
    
    private var font: Font {
        switch size {
        case .small:
            return .system(size: 14)
        case .medium:
            return .system(size: 16)
        case .large:
            return .system(size: 18)
        }
    }
    
    private var fontWeight: Font.Weight {
        switch size {
        case .small:
            return .medium
        case .medium, .large:
            return .semibold
        }
    }
    
    private var iconFont: Font {
        switch size {
        case .small:
            return .system(size: 12, weight: .medium)
        case .medium:
            return .system(size: 14, weight: .medium)
        case .large:
            return .system(size: 16, weight: .medium)
        }
    }
    
    private var padding: EdgeInsets {
        switch size {
        case .small:
            return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .medium:
            return EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        case .large:
            return EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32)
        }
    }
    
    private var minHeight: CGFloat {
        switch size {
        case .small: return 36
        case .medium: return 44
        case .large: return 52
        }
    }
    
    private var cornerRadius: CGFloat {
        switch roundType {
        case .rounded:
            return 8
        case .pill:
            return minHeight / 2
        case .square:
            return 0
        }
    }
    
    private var opacity: Double {
        if !isEnabled {
            return 0.6
        }
        return 1.0
    }
    
    private var progressViewColor: Color {
        foregroundColor
    }
    
    private var accessibilityLabel: String {
        if isLoading {
            return "\(title) - Loading"
        }
        return title
    }
}

// MARK: - Convenience Initializers

public extension TPEButton {
    /// Primary button with centered text
    static func primary(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded, // ADD THIS PARAMETER
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .primary,
            size: size,
            roundType: roundType, // PASS IT HERE
            isCentered: true,
            isEnabled: isEnabled,
            isLoading: isLoading,
            onPressed: action
        )
    }
    
    /// Secondary button with centered text
    static func secondary(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded, // ADD THIS PARAMETER
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .secondary,
            size: size,
            roundType: roundType, // PASS IT HERE
            isCentered: true,
            isEnabled: isEnabled,
            isLoading: isLoading,
            onPressed: action
        )
    }
    
    /// Button with icon
    static func withIcon(
        _ title: String,
        icon: String,
        variant: TPEButtonVariant = .primary,
        roundType: TPEButtonRound = .rounded, // ADD THIS PARAMETER
        iconPosition: IconPosition = .leading,
        size: TPEButtonSize = .medium,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: variant,
            size: size,
            roundType: roundType, // PASS IT HERE
            isCentered: true,
            icon: icon,
            iconPosition: iconPosition,
            onPressed: action
        )
    }
    
    /// Danger button for destructive actions
    static func danger(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded, // ADD THIS PARAMETER
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .danger,
            size: size,
            roundType: roundType, // PASS IT HERE
            isCentered: true,
            isLoading: isLoading,
            onPressed: action
        )
    }
    
    /// Outline button
    static func outline(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .outline,
            size: size,
            roundType: roundType,
            isCentered: true,
            isEnabled: isEnabled,
            onPressed: action
        )
    }
    
    /// Success button
    static func success(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .success,
            size: size,
            roundType: roundType,
            isCentered: true,
            isLoading: isLoading,
            onPressed: action
        )
    }
    
    /// Warning button
    static func warning(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .warning,
            size: size,
            roundType: roundType,
            isCentered: true,
            isLoading: isLoading,
            onPressed: action
        )
    }
}

// MARK: - Previews

#Preview("Button Variants") {
    VStack(spacing: 16) {
        ForEach(TPEButtonVariant.allCases, id: \.self) { variant in
            TPEButton(
                title: variant.name,
                variant: variant,
                size: .medium,
                roundType: .rounded, // ADD THIS
                isCentered: true,
                onPressed: { print("\(variant.name) tapped") }
            )
        }
    }
    .padding()
}

#Preview("Button Sizes") {
    VStack(spacing: 16) {
        ForEach(TPEButtonSize.allCases, id: \.self) { size in
            TPEButton(
                title: size.name,
                variant: .primary,
                size: size,
                roundType: .rounded, // ADD THIS
                isCentered: true,
                onPressed: { print("\(size.name) tapped") }
            )
        }
    }
    .padding()
}

#Preview("Button States") {
    VStack(spacing: 16) {
        TPEButton(
            title: "Normal Button",
            variant: .primary,
            roundType: .rounded, // ADD THIS
            isCentered: true,
            onPressed: { print("Normal tapped") }
        )
        
        TPEButton(
            title: "Disabled Button",
            variant: .primary,
            roundType: .rounded, // ADD THIS
            isCentered: true,
            isEnabled: false,
            onPressed: { print("Disabled tapped") }
        )
        
        TPEButton(
            title: "Loading Button",
            variant: .primary,
            roundType: .rounded, // ADD THIS
            isCentered: true,
            isLoading: true,
            onPressed: { print("Loading tapped") }
        )
    }
    .padding()
}

#Preview("Button with Icons") {
    VStack(spacing: 16) {
        TPEButton.withIcon(
            "Save Changes",
            icon: "checkmark",
            variant: .success,
            roundType: .rounded, // ADD THIS
            action: { print("Save tapped") }
        )
        
        TPEButton.withIcon(
            "Delete Item",
            icon: "trash",
            variant: .danger,
            roundType: .rounded, // ADD THIS
            iconPosition: .trailing,
            action: { print("Delete tapped") }
        )
        
        TPEButton.withIcon(
            "Download",
            icon: "arrow.down",
            variant: .outline,
            roundType: .rounded, // ADD THIS
            action: { print("Download tapped") }
        )
    }
    .padding()
}

#Preview("Round Types") {
    VStack(spacing: 16) {
        ForEach(TPEButtonRound.allCases, id: \.self) { roundType in
            TPEButton(
                title: roundType.name,
                variant: .primary,
                roundType: roundType,
                isCentered: true,
                onPressed: { print("\(roundType.name) tapped") }
            )
        }
    }
    .padding()
}

#Preview("Mixed Round Types") {
    VStack(spacing: 16) {
        TPEButton.primary("Rounded Primary", roundType: .rounded) {}
        TPEButton.secondary("Pill Secondary", roundType: .pill) {}
        TPEButton.outline("Square Outline", roundType: .square) {}
        TPEButton.withIcon("Pill with Icon", icon: "star", roundType: .pill) {}
        TPEButton.danger("Rounded Danger", roundType: .rounded) {}
    }
    .padding()
}
