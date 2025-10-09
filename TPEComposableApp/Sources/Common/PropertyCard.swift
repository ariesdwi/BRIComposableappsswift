//
//  PropertyCard.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

struct PropertyCard: View {
    let icon: String
    let title: String
    let value: String
    let description: String
    let isRequired: Bool
    
    init(
        icon: String,
        title: String,
        value: String,
        description: String,
        isRequired: Bool = false
    ) {
        self.icon = icon
        self.title = title
        self.value = value
        self.description = description
        self.isRequired = isRequired
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack(alignment: .top) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        if isRequired {
                            Text("•")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.red)
                        }
                    }
                    
                    Text(value)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                }
                
                Spacer()
            }
            
            // Description
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Alternative simpler version
struct SimplePropertyCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.blue)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Previews
#Preview("Property Card") {
    VStack(spacing: 16) {
        PropertyCard(
            icon: "text.cursor",
            title: "primaryTitle",
            value: "String",
            description: "Main action button text",
            isRequired: true
        )
        
        PropertyCard(
            icon: "text.cursor",
            title: "secondaryTitle",
            value: "String?",
            description: "Optional secondary button text"
        )
        
        PropertyCard(
            icon: "checkmark.circle",
            title: "isPrimaryEnabled",
            value: "Bool",
            description: "Primary button enabled state",
            isRequired: false
        )
        
        SimplePropertyCard(
            icon: "text.cursor",
            title: "Primary Title",
            value: "String"
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
