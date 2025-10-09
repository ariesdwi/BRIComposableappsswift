
//
//  TPEButtonCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPEButtonCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPEButton",
                    subtitle: "Interactive button components with multiple variants and states"
                )
                
                // Button Variants
                ComponentSection(title: "Button Variants", icon: "button.programmable") {
                    VStack(spacing: 16) {
                        ForEach(TPEButtonVariant.allCases, id: \.self) { variant in
                            TPEButton(
                                title: variant.name,
                                variant: variant,
                                size: .medium,
                                roundType: .rounded,
                                isCentered: true,
                                onPressed: {}
                            )
                        }
                    }
                }
                
                // Button Sizes
                ComponentSection(title: "Button Sizes", icon: "textformat.size") {
                    VStack(spacing: 16) {
                        ForEach(TPEButtonSize.allCases, id: \.self) { size in
                            TPEButton(
                                title: size.name,
                                variant: .primary,
                                size: size,
                                roundType: .rounded,
                                isCentered: true,
                                onPressed: {}
                            )
                        }
                    }
                }
                
                // Round Types
                ComponentSection(title: "Round Types", icon: "square.rounded") {
                    VStack(spacing: 16) {
                        ForEach(TPEButtonRound.allCases, id: \.self) { roundType in
                            TPEButton(
                                title: roundType.name,
                                variant: .primary,
                                size: .medium,
                                roundType: roundType,
                                isCentered: true,
                                onPressed: {}
                            )
                        }
                    }
                }
                
                // Button States
                ComponentSection(title: "Button States", icon: "circle.hexagonpath") {
                    VStack(spacing: 16) {
                        TPEButton(
                            title: "Normal",
                            variant: .primary,
                            roundType: .rounded,
                            isCentered: true,
                            onPressed: {}
                        )
                        
                        TPEButton(
                            title: "Disabled",
                            variant: .primary,
                            roundType: .rounded,
                            isCentered: true,
                            isEnabled: false,
                            onPressed: {}
                        )
                        
                        TPEButton(
                            title: "Loading",
                            variant: .primary,
                            roundType: .rounded,
                            isCentered: true,
                            isLoading: true,
                            onPressed: {}
                        )
                    }
                }
                
                // Button with Icons
                ComponentSection(title: "Buttons with Icons", icon: "plus.circle") {
                    VStack(spacing: 16) {
                        TPEButton.withIcon(
                            "Save Changes",
                            icon: "checkmark",
                            variant: .success,
                            roundType: .rounded,
                            action: {}
                        )
                        
                        TPEButton.withIcon(
                            "Delete Item",
                            icon: "trash",
                            variant: .danger,
                            roundType: .rounded,
                            iconPosition: .trailing,
                            action: {}
                        )
                        
                        // Show different round types with icons
                        TPEButton.withIcon(
                            "Pill Style",
                            icon: "heart",
                            variant: .primary,
                            roundType: .pill,
                            action: {}
                        )
                        
                        TPEButton.withIcon(
                            "Square Style",
                            icon: "star",
                            variant: .outline,
                            roundType: .square,
                            action: {}
                        )
                    }
                }
                
                // Combined Examples
                ComponentSection(title: "Combined Examples", icon: "square.grid.2x2") {
                    VStack(spacing: 16) {
                        Text("Danger Pill Button")
                            .font(.headline)
                        
                        TPEButton(
                            title: "Delete Account",
                            variant: .danger,
                            size: .medium,
                            roundType: .pill,
                            isCentered: true,
                            onPressed: {}
                        )
                        
                        Text("Outline Square Button")
                            .font(.headline)
                        
                        TPEButton(
                            title: "Cancel",
                            variant: .outline,
                            size: .small,
                            roundType: .square,
                            isCentered: true,
                            onPressed: {}
                        )
                        
                        Text("Success Rounded with Icon")
                            .font(.headline)
                        
                        TPEButton.withIcon(
                            "Complete Order",
                            icon: "checkmark.circle",
                            variant: .success,
                            roundType: .rounded,
                            size: .large,
                            action: {}
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("TPEButton")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Convenience Extension for TPEButton

public extension TPEButton {
    /// Primary button with centered text
    static func primary(
        _ title: String,
        size: TPEButtonSize = .medium,
        roundType: TPEButtonRound = .rounded,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .primary,
            size: size,
            roundType: roundType,
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
        roundType: TPEButtonRound = .rounded,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .secondary,
            size: size,
            roundType: roundType,
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
        roundType: TPEButtonRound = .rounded,
        iconPosition: IconPosition = .leading,
        size: TPEButtonSize = .medium,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: variant,
            size: size,
            roundType: roundType,
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
        roundType: TPEButtonRound = .rounded,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) -> TPEButton {
        TPEButton(
            title: title,
            variant: .danger,
            size: size,
            roundType: roundType,
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
}

// MARK: - Previews

#Preview("Button Catalog") {
    NavigationView {
        TPEButtonCatalogView()
    }
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

#Preview("Mixed Examples") {
    VStack(spacing: 16) {
        TPEButton(
            title: "Rounded Primary",
            variant: .primary,
            roundType: .rounded,
            isCentered: true,
            onPressed: {}
        )
        
        TPEButton(
            title: "Pill Secondary",
            variant: .secondary,
            roundType: .pill,
            isCentered: true,
            onPressed: {}
        )
        
        TPEButton(
            title: "Square Outline",
            variant: .outline,
            roundType: .square,
            isCentered: true,
            onPressed: {}
        )
        
        TPEButton.withIcon(
            "Rounded with Icon",
            icon: "star",
            variant: .success,
            roundType: .rounded,
            action: {}
        )
        
        TPEButton.withIcon(
            "Pill with Trailing Icon",
            icon: "arrow.right",
            variant: .primary,
            roundType: .pill,
            iconPosition: .trailing,
            action: {}
        )
    }
    .padding()
}
