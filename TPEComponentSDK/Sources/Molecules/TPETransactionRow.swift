//
//  TPETransactionRow.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPETransactionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let amount: String
    let iconColor: Color
    let amountColor: Color
    
    public init(icon: String, title: String, subtitle: String, amount: String, iconColor: Color, amountColor: Color) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.iconColor = iconColor
        self.amountColor = amountColor
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(iconColor)
                .cornerRadius(8)
            
            // Details
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount
            Text(amount)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(amountColor)
        }
        .padding(.vertical, 4)
    }
}
