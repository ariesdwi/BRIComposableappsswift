//
//  ButtonGroupMolecule.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct ButtonGroupMolecule: View {
    let primaryAction: () -> Void
    let secondaryAction: (() -> Void)?
    let tertiaryAction: (() -> Void)?
    let primaryTitle: String
    let secondaryTitle: String?
    let tertiaryTitle: String?
    let isPrimaryEnabled: Bool
    
    public init(
        primaryTitle: String = "Primary Action",
        secondaryTitle: String? = "Secondary",
        tertiaryTitle: String? = nil,
        isPrimaryEnabled: Bool = true,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil,
        tertiaryAction: (() -> Void)? = nil
    ) {
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.tertiaryTitle = tertiaryTitle
        self.isPrimaryEnabled = isPrimaryEnabled
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.tertiaryAction = tertiaryAction
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Primary Button
            TPEButton(
                title: primaryTitle,
                variant: .primary,
                isEnabled: isPrimaryEnabled,
                onPressed: primaryAction
            )
            
            // Secondary Buttons
            if secondaryAction != nil || tertiaryAction != nil {
                HStack(spacing: 12) {
                    if let secondaryTitle = secondaryTitle, let secondaryAction = secondaryAction {
                        TPEButton(
                            title: secondaryTitle,
                            variant: .secondary,
                            onPressed: secondaryAction
                        )
                    }
                    
                    if let tertiaryTitle = tertiaryTitle, let tertiaryAction = tertiaryAction {
                        TPEButton(
                            title: tertiaryTitle,
                            variant: .secondary,
                            onPressed: tertiaryAction
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Previews
#if DEBUG
public struct ButtonGroupMolecule_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 24) {
            ButtonGroupMolecule(
                primaryAction: { print("Primary tapped") },
                secondaryAction: { print("Secondary tapped") }
            )
            
            ButtonGroupMolecule(
                primaryTitle: "Save Changes",
                secondaryTitle: "Cancel",
                tertiaryTitle: "Help",
                isPrimaryEnabled: false,
                primaryAction: { print("Save tapped") },
                secondaryAction: { print("Cancel tapped") },
                tertiaryAction: { print("Help tapped") }
            )
        }
        .padding()
    }
}
#endif
