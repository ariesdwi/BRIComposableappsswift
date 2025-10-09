//
//  ColorsCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI
import TPEComponentSDK

struct ColorsCatalogView: View {
    let colorGroups = [
        ColorGroup(
            name: "Primary",
            colors: [
                ColorItem(name: "Blue 70", color: TPEColors.blue70, value: "#1260CC"),
                ColorItem(name: "Blue 50", color: .blue, value: "#007AFF"),
                ColorItem(name: "Blue 30", color: .blue.opacity(0.3), value: "#B3D7FF")
            ]
        ),
        ColorGroup(
            name: "Neutral",
            colors: [
                ColorItem(name: "Black", color: .black, value: "#000000"),
                ColorItem(name: "Gray", color: .gray, value: "#8E8E93"),
                ColorItem(name: "Light Gray", color: .gray.opacity(0.3), value: "#C6C6C8")
            ]
        ),
        ColorGroup(
            name: "Feedback",
            colors: [
                ColorItem(name: "Success", color: .green, value: "#34C759"),
                ColorItem(name: "Warning", color: .orange, value: "#FF9500"),
                ColorItem(name: "Error", color: .red, value: "#FF3B30")
            ]
        )
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 32) {
                HeaderView(
                    title: "Color System",
                    subtitle: "Consistent color palette for branding and UI"
                )
                
                ForEach(colorGroups) { group in
                    ColorGroupView(group: group)
                }
            }
            .padding()
        }
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ColorGroup: Identifiable {
    let id = UUID()
    let name: String
    let colors: [ColorItem]
}

struct ColorItem: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let value: String
}

struct ColorGroupView: View {
    let group: ColorGroup
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(group.name)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(group.colors) { item in
                    ColorSwatch(item: item)
                }
            }
        }
    }
}

struct ColorSwatch: View {
    let item: ColorItem
    
    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(item.color)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            VStack(spacing: 4) {
                Text(item.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(item.value)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}
