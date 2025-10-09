//
//  StatBadge.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

struct StatBadge: View {
    let count: String
    let label: String
    let icon: String?
    let style: Style
    
    enum Style {
        case primary
        case secondary
        case success
        case warning
        case error
        
        var backgroundColor: Color {
            switch self {
            case .primary: return .blue.opacity(0.1)
            case .secondary: return .gray.opacity(0.1)
            case .success: return .green.opacity(0.1)
            case .warning: return .orange.opacity(0.1)
            case .error: return .red.opacity(0.1)
            }
        }
        
        var textColor: Color {
            switch self {
            case .primary: return .blue
            case .secondary: return .gray
            case .success: return .green
            case .warning: return .orange
            case .error: return .red
            }
        }
        
        var iconColor: Color {
            return textColor
        }
    }
    
    // Convenience initializers
    init(count: String, label: String, icon: String? = nil, style: Style = .primary) {
        self.count = count
        self.label = label
        self.icon = icon
        self.style = style
    }
    
    init(count: Int, label: String, icon: String? = nil, style: Style = .primary) {
        self.count = "\(count)"
        self.label = label
        self.icon = icon
        self.style = style
    }
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(style.iconColor)
                }
                
                Text(count)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(style.textColor)
            }
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(style.backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style.textColor.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Previews

#Preview("StatBadge Variants") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            StatBadge(count: "15", label: "Molecules", icon: "square.grid.2x2")
            StatBadge(count: "8", label: "Atoms Used", icon: "atom")
        }
        
        HStack(spacing: 12) {
            StatBadge(count: "100%", label: "Reusable", icon: "arrow.triangle.merge", style: .success)
            StatBadge(count: "3", label: "Warnings", icon: "exclamationmark.triangle", style: .warning)
        }
        
        HStack(spacing: 12) {
            StatBadge(count: "0", label: "Errors", icon: "xmark.circle", style: .error)
            StatBadge(count: "24", label: "Components", icon: "puzzlepiece", style: .secondary)
        }
        
        // Single column for smaller screens
        VStack(spacing: 12) {
            StatBadge(count: "15", label: "Total Molecules", icon: "square.grid.2x2")
            StatBadge(count: "8", label: "Atoms Used", icon: "atom")
            StatBadge(count: "100%", label: "Reusability Score", icon: "arrow.triangle.merge", style: .success)
        }
        .frame(width: 150)
    }
    .padding()
}

#Preview("StatBadge in Context") {
    VStack(spacing: 20) {
        Text("Design System Overview")
            .font(.title2)
            .fontWeight(.bold)
        
        HStack(spacing: 16) {
            StatBadge(count: "42", label: "Atoms", icon: "atom")
            StatBadge(count: "15", label: "Molecules", icon: "square.grid.2x2")
            StatBadge(count: "8", label: "Organisms", icon: "puzzlepiece.fill")
        }
        
        HStack(spacing: 16) {
            StatBadge(count: "100%", label: "Accessible", icon: "accessibility", style: .success)
            StatBadge(count: "95%", label: "Tested", icon: "checkmark.shield", style: .success)
            StatBadge(count: "2", label: "Deprecated", icon: "exclamationmark.triangle", style: .warning)
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
