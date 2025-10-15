//
//  TPEMenuRow.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEMenuRow: View {
    let icon: String
    let title: String
    let color: Color
    let badge: String?
    let showChevron: Bool
    
    public init(icon: String, title: String, color: Color, badge: String? = nil, showChevron: Bool = true) {
        self.icon = icon
        self.title = title
        self.color = color
        self.badge = badge
        self.showChevron = showChevron
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            
            // Title
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            // Badge
            if let badge = badge {
                TPEBadge(text: badge)
            }
            
            // Chevron
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
