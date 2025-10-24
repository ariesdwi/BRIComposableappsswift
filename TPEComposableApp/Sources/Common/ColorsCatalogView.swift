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
            name: "Primary Colors",
            colors: [
                ColorItem(name: "Primary Color", color: TPEColors.primaryColor, value: "#1078CA"),
                ColorItem(name: "Secondary Color", color: TPEColors.secondaryColor, value: "#691D01"),
                ColorItem(name: "Primary Blue", color: TPEColors.primaryBlue, value: "#006CC7")
            ]
        ),
        ColorGroup(
            name: "Neutral Colors",
            colors: [
                ColorItem(name: "Black", color: TPEColors.black, value: "#000000"),
                ColorItem(name: "White", color: TPEColors.white, value: "#FFFFFF"),
                ColorItem(name: "Light 10", color: TPEColors.light10, value: "#F8F9F9"),
                ColorItem(name: "Light 20", color: TPEColors.light20, value: "#EAEBEB"),
                ColorItem(name: "Light 30", color: TPEColors.light30, value: "#D3D4D4"),
                ColorItem(name: "Light 40", color: TPEColors.light40, value: "#B5B6B6"),
                ColorItem(name: "Light 50", color: TPEColors.light50, value: "#A3A3A3"),
                ColorItem(name: "Light 60", color: TPEColors.light60, value: "#929393"),
                ColorItem(name: "Light 70", color: TPEColors.light70, value: "#848484"),
                ColorItem(name: "Light 80", color: TPEColors.light80, value: "#777777"),
                ColorItem(name: "Dark 10", color: TPEColors.dark10, value: "#666666"),
                ColorItem(name: "Dark 20", color: TPEColors.dark20, value: "#525252"),
                ColorItem(name: "Dark 30", color: TPEColors.dark30, value: "#3D3D3D"),
                ColorItem(name: "Dark 40", color: TPEColors.dark40, value: "#292929")
            ]
        ),
        ColorGroup(
            name: "Blue Palette",
            colors: [
                ColorItem(name: "Blue 10", color: TPEColors.blue10, value: "#E0F1FF"),
                ColorItem(name: "Blue 20", color: TPEColors.blue20, value: "#A6D6FF"),
                ColorItem(name: "Blue 30", color: TPEColors.blue30, value: "#7AC2FF"),
                ColorItem(name: "Blue 40", color: TPEColors.blue40, value: "#4DAEFF"),
                ColorItem(name: "Blue 50", color: TPEColors.blue50, value: "#2199FF"),
                ColorItem(name: "Blue 60", color: TPEColors.blue60, value: "#0084F4"),
                ColorItem(name: "Blue 70", color: TPEColors.blue70, value: "#006CC7"),
                ColorItem(name: "Blue 80", color: TPEColors.blue80, value: "#00549B"),
                ColorItem(name: "Blue 90", color: TPEColors.blue90, value: "#0E69B1"),
                ColorItem(name: "Blue 100", color: TPEColors.blue100, value: "#00325C")
            ]
        ),
        ColorGroup(
            name: "Yellow Palette",
            colors: [
                ColorItem(name: "Yellow 10", color: TPEColors.yellow10, value: "#FFFEFA"),
                ColorItem(name: "Yellow 20", color: TPEColors.yellow20, value: "#FCF2D2"),
                ColorItem(name: "Yellow 30", color: TPEColors.yellow30, value: "#FAEBBC"),
                ColorItem(name: "Yellow 40", color: TPEColors.yellow40, value: "#F9E4A6"),
                ColorItem(name: "Yellow 50", color: TPEColors.yellow50, value: "#F7DD8F"),
                ColorItem(name: "Yellow 60", color: TPEColors.yellow60, value: "#F5D679"),
                ColorItem(name: "Yellow 70", color: TPEColors.yellow70, value: "#F4D062"),
                ColorItem(name: "Yellow 80", color: TPEColors.yellow80, value: "#F2C94C"),
                ColorItem(name: "Yellow 90", color: TPEColors.yellow90, value: "#EDB812"),
                ColorItem(name: "Yellow 100", color: TPEColors.yellow100, value: "#CD9E0F")
            ]
        ),
        ColorGroup(
            name: "Orange Palette",
            colors: [
                ColorItem(name: "Orange 10", color: TPEColors.orange10, value: "#FFF9F5"),
                ColorItem(name: "Orange 20", color: TPEColors.orange20, value: "#FEDCC0"),
                ColorItem(name: "Orange 30", color: TPEColors.orange30, value: "#FDCAA0"),
                ColorItem(name: "Orange 40", color: TPEColors.orange40, value: "#FDB980"),
                ColorItem(name: "Orange 50", color: TPEColors.orange50, value: "#FCA760"),
                ColorItem(name: "Orange 60", color: TPEColors.orange60, value: "#FC9641"),
                ColorItem(name: "Orange 70", color: TPEColors.orange70, value: "#FB8421"),
                ColorItem(name: "Orange 80", color: TPEColors.orange80, value: "#F87304"),
                ColorItem(name: "Orange 90", color: TPEColors.orange90, value: "#FF7104"),
                ColorItem(name: "Orange 100", color: TPEColors.orange100, value: "#BE5804")
            ]
        ),
        ColorGroup(
            name: "Green Palette",
            colors: [
                ColorItem(name: "Green 10", color: TPEColors.green10, value: "#F3FCF7"),
                ColorItem(name: "Green 20", color: TPEColors.green20, value: "#C2F1D6"),
                ColorItem(name: "Green 30", color: TPEColors.green30, value: "#A4EBC2"),
                ColorItem(name: "Green 40", color: TPEColors.green40, value: "#86E4AD"),
                ColorItem(name: "Green 50", color: TPEColors.green50, value: "#67DD99"),
                ColorItem(name: "Green 60", color: TPEColors.green60, value: "#49D685"),
                ColorItem(name: "Green 70", color: TPEColors.green70, value: "#2ECC71"),
                ColorItem(name: "Green 80", color: TPEColors.green80, value: "#27AE60"),
                ColorItem(name: "Green 90", color: TPEColors.green90, value: "#229854"),
                ColorItem(name: "Green 100", color: TPEColors.green100, value: "#19713E")
            ]
        ),
        ColorGroup(
            name: "Red Palette",
            colors: [
                ColorItem(name: "Red 10", color: TPEColors.red10, value: "#FCE7E7"),
                ColorItem(name: "Red 20", color: TPEColors.red20, value: "#F9CFCF"),
                ColorItem(name: "Red 30", color: TPEColors.red30, value: "#F6B7B7"),
                ColorItem(name: "Red 40", color: TPEColors.red40, value: "#F49F9F"),
                ColorItem(name: "Red 50", color: TPEColors.red50, value: "#F18888"),
                ColorItem(name: "Red 60", color: TPEColors.red60, value: "#EE7070"),
                ColorItem(name: "Red 70", color: TPEColors.red70, value: "#EB5858"),
                ColorItem(name: "Red 80", color: TPEColors.red80, value: "#E84040"),
                ColorItem(name: "Red 90", color: TPEColors.red90, value: "#E41F1F"),
                ColorItem(name: "Red 100", color: TPEColors.red100, value: "#FB6116")
            ]
        ),
        ColorGroup(
            name: "Utility",
            colors: [
                ColorItem(name: "Transparent", color: TPEColors.transparent, value: "Clear")
            ]
        )
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 32) {
                HeaderView(
                    title: "Color System",
                    subtitle: "Comprehensive color palette for TPE design system"
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
                    .multilineTextAlignment(.center)
                
                Text(item.value)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 40)
        }
    }
}
