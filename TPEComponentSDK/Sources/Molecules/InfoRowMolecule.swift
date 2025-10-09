//
//  InfoRowMolecule.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct InfoRowMolecule: View {
    let title: String
    let value: String?
    let subtitle: String?
    let icon: String?
    let showChevron: Bool
    let action: (() -> Void)?
    
    public init(
        title: String,
        value: String? = nil,
        subtitle: String? = nil,
        icon: String? = nil,
        showChevron: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.showChevron = showChevron
        self.action = action
    }
    
    public var body: some View {
        Button(action: action ?? {}) {
            HStack(spacing: 16) {
                // Icon
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 24)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        TPEText(
                            text: title,
                            variant: .text16Bold,
                            color: .primary,
                            textAlignment: .leading
                        )
                        
                        Spacer()
                        
                        if let value = value {
                            TPEText(
                                text: value,
                                variant: .secondary,
                                color: .secondary,
                                textAlignment: .trailing
                            )
                        }
                    }
                    
                    if let subtitle = subtitle {
                        TPEText(
                            text: subtitle,
                            variant: .secondary,
                            color: .secondary,
                            textAlignment: .leading
                        )
                    }
                }
                
                // Chevron
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 12)
        }
        .disabled(action == nil)
        .foregroundColor(.primary)
    }
}

// MARK: - Previews
#if DEBUG
public struct InfoRowMolecule_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 0) {
            InfoRowMolecule(
                title: "Account Type",
                value: "Premium",
                icon: "person.fill",
                showChevron: true,
                action: { print("Account Type tapped") }
            )
            
            Divider()
            
            InfoRowMolecule(
                title: "Email Address",
                subtitle: "user@example.com",
                icon: "envelope.fill",
                showChevron: true,
                action: { print("Email tapped") }
            )
            
            Divider()
            
            InfoRowMolecule(
                title: "Version",
                value: "1.0.0",
                icon: "info.circle.fill"
            )
        }
        .padding()
    }
}
#endif
