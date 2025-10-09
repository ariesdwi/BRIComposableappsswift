//
//  StatCardMolecule.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct StatCardMolecule: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String
    let trend: Trend?
    let color: Color
    
    public enum Trend {
        case up(String)
        case down(String)
        case neutral(String)
    }
    
    public init(
        title: String,
        value: String,
        subtitle: String? = nil,
        icon: String = "chart.bar.fill",
        trend: Trend? = nil,
        color: Color = .blue
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.trend = trend
        self.color = color
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(color)
                
                Spacer()
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            // Title
            TPEText(
                text: title,
                variant: .text16Bold,
                color: .primary,
                textAlignment: .leading
            )
            
            // Subtitle and Trend
            HStack {
                if let subtitle = subtitle {
                    TPEText(
                        text: subtitle,
                        variant: .secondary,
                        color: .secondary,
                        textAlignment: .leading
                    )
                }
                
                Spacer()
                
                if let trend = trend {
                    trendView(trend)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    @ViewBuilder
    private func trendView(_ trend: Trend) -> some View {
        HStack(spacing: 4) {
            switch trend {
            case .up(let value):
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                
                TPEText(
                    text: value,
                    variant: .secondary,
                    color: .green,
                    textAlignment: .leading
                )
                
            case .down(let value):
                Image(systemName: "arrow.down.right")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                
                TPEText(
                    text: value,
                    variant: .secondary,
                    color: .red,
                    textAlignment: .leading
                )
                
            case .neutral(let value):
                Image(systemName: "minus")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                TPEText(
                    text: value,
                    variant: .secondary,
                    color: .gray,
                    textAlignment: .leading
                )
            }
        }
    }
}

// MARK: - Previews
#if DEBUG
public struct StatCardMolecule_Previews: PreviewProvider {
    public static var previews: some View {
        HStack(spacing: 16) {
            StatCardMolecule(
                title: "Monthly Users",
                value: "1,234",
                subtitle: "Active users",
                trend: .up("12%")
            )
            
            StatCardMolecule(
                title: "Revenue",
                value: "$12.5K",
                subtitle: "This month",
                icon: "dollarsign.circle.fill",
                trend: .down("5%"),
                color: .green
            )
        }
        .padding()
    }
}
#endif
