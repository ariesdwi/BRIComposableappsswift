//
//  CardHeaderMolecule.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct CardHeaderMolecule: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let actionTitle: String?
    let action: (() -> Void)?
    
    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.actionTitle = actionTitle
        self.action = action
    }
    
    public var body: some View {
        HStack(alignment: subtitle == nil ? .center : .top) {
            // Content
            HStack(spacing: 12) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 24)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    TPEText(
                        text: title,
                        variant: .text16Bold,
                        color: .primary,
                        textAlignment: .leading
                    )
                    
                    if let subtitle = subtitle {
                        TPEText(
                            text: subtitle,
                            variant: .secondary,
                            color: .secondary,
                            textAlignment: .leading
                        )
                    }
                }
            }
            
            Spacer()
            
            // Action
            if let actionTitle = actionTitle, let action = action {
                TPEButton(
                    title: actionTitle,
                    variant: .primary,
                    size: .small,
                    onPressed: action
                )
            }
        }
    }
}

// MARK: - Previews
#if DEBUG
public struct CardHeaderMolecule_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 20) {
            CardHeaderMolecule(
                title: "Profile Settings",
                subtitle: "Manage your account preferences",
                icon: "person.circle.fill",
                actionTitle: "Edit",
                action: { print("Edit tapped") }
            )
            
            CardHeaderMolecule(
                title: "Simple Header",
                actionTitle: "Action",
                action: { print("Action tapped") }
            )
            
            CardHeaderMolecule(
                title: "Information Card",
                subtitle: "Additional details about this section",
                icon: "info.circle.fill"
            )
        }
        .padding()
    }
}
#endif
