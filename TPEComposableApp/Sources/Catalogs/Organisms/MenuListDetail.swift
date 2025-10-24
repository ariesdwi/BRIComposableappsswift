//
//  MenuListDetail.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//
import SwiftUI
import TPEHomepageSDK
import TPEComponentSDK

struct MenuVariantCard: View {
    let variant: TPEMenuListVerticalDetailView.MenuVariant
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: variant.icon)
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .pink)
                        .frame(width: 24)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(variant.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .primary)
                        .lineLimit(1)
                    
                    Text(variant.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Configuration summary
                VStack(alignment: .leading, spacing: 4) {
                    ConfigRow(title: "Spacing:", value: "\(Int(variant.config.spacing))pt")
                    ConfigRow(title: "Width:", value: "\(Int(variant.config.itemWidth))pt")
                    ConfigRow(title: "Icons:", value: "\(Int(variant.config.iconSize))pt")
                    ConfigRow(title: "Badges:", value: variant.config.showNewBadges ? "Yes" : "No")
                }
            }
            .padding(16)
            .frame(width: 160, height: 160)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var backgroundColor: Color {
        isSelected ? .pink : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .pink : Color.gray.opacity(0.2)
    }
}

struct ConfigRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct TPEMenuListVerticalDetailView: View {
    @State private var selectedVariant: MenuVariant = .default
    @State private var showMenu: Bool = true
    @State private var spacing: CGFloat = 16
    @State private var itemWidth: CGFloat = 100
    @State private var iconSize: CGFloat = 40
    @State private var showNewBadges: Bool = true
    @State private var selectedMenuItem: String = ""
    
    // Sample menu items - UPDATED to use iconUrl
    @State private var menuItems: [TPEMenuItemHorizontal] = [
        TPEMenuItemHorizontal(
            title: "Transfer",
            iconUrl: "https://example.com/transfer.png",
            iconSize: 40,
            isNew: false,
            onTap: {
                print("transfer")
            }
        ),
        TPEMenuItemHorizontal(
            title: "Pay Bills",
            iconUrl: "https://example.com/bills.png",
            iconSize: 40,
            isNew: false,
            onTap: {
                print("bills")
            }
        ),
        TPEMenuItemHorizontal(
            title: "Top Up",
            iconUrl: "https://example.com/topup.png",
            iconSize: 40,
            isNew: true,
            onTap: {
                print("topup")
            }
        ),
        TPEMenuItemHorizontal(
            title: "History",
            iconUrl: "https://example.com/history.png",
            iconSize: 40,
            isNew: false,
            onTap: {
                print("history")
            }
        )
    ]
    
    enum MenuVariant: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case compact = "Compact"
        case spacious = "Spacious"
        case largeIcons = "Large Icons"
        case withNewBadges = "With New Badges"
        case custom = "Custom"
        
        var id: String { rawValue }
        
        var description: String {
            switch self {
            case .default: return "Standard menu with balanced spacing"
            case .compact: return "Tight spacing for more items"
            case .spacious: return "Wide spacing for emphasis"
            case .largeIcons: return "Larger icons for better visibility"
            case .withNewBadges: return "Highlight new features with badges"
            case .custom: return "Fully customizable menu"
            }
        }
        
        var icon: String {
            switch self {
            case .default: return "square.grid.2x2"
            case .compact: return "rectangle.compress.vertical"
            case .spacious: return "rectangle.expand.vertical"
            case .largeIcons: return "photo"
            case .withNewBadges: return "sparkles"
            case .custom: return "slider.horizontal.3"
            }
        }
        
        var config: MenuConfig {
            switch self {
            case .default:
                return MenuConfig(spacing: 16, itemWidth: 100, iconSize: 40, showNewBadges: true)
            case .compact:
                return MenuConfig(spacing: 8, itemWidth: 80, iconSize: 35, showNewBadges: false)
            case .spacious:
                return MenuConfig(spacing: 24, itemWidth: 120, iconSize: 40, showNewBadges: true)
            case .largeIcons:
                return MenuConfig(spacing: 16, itemWidth: 110, iconSize: 50, showNewBadges: false)
            case .withNewBadges:
                return MenuConfig(spacing: 16, itemWidth: 100, iconSize: 40, showNewBadges: true)
            case .custom:
                return MenuConfig(spacing: 20, itemWidth: 100, iconSize: 45, showNewBadges: true)
            }
        }
    }
    
    struct MenuConfig {
        let spacing: CGFloat
        let itemWidth: CGFloat
        let iconSize: CGFloat
        let showNewBadges: Bool
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Horizontal Menu List",
                    subtitle: "Horizontally scrolling menu with vertical item layout"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Menu Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(MenuVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(MenuVariant.allCases) { variant in
                                MenuVariantCard(
                                    variant: variant,
                                    isSelected: selectedVariant == variant
                                ) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedVariant = variant
                                        updateVariantSettings(for: variant)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                    }
                }
                
                // Interactive Preview
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Interactive Preview")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Toggle("Show Menu", isOn: $showMenu)
                            .font(.system(size: 14))
                    }
                    
                    previewContainer
                }
                
                // Menu Items Customization
                menuItemsCustomizationPanel
                
                // Layout Customization
                layoutCustomizationPanel
                
                // Selection Feedback
                if !selectedMenuItem.isEmpty {
                    selectionFeedbackSection
                }
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Horizontal Menu List")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Preview Container
    private var previewContainer: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.pink)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("LIVE PREVIEW")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green)
                    .cornerRadius(4)
            }
            
            Text(selectedVariant.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Menu Preview - UPDATED to use TPEMenuListHorizontal
            TPEMenuListHorizontal(
                menuItems: menuItems.map { item in
                    TPEMenuItemHorizontal(
                        title: item.title,
                        iconUrl: item.iconUrl,
                        iconSize: selectedVariant == .custom ? iconSize : selectedVariant.config.iconSize,
                        isNew: selectedVariant.config.showNewBadges ? item.isNew : false,
                        onTap: {
                            handleMenuItemTap(item.title)
                        }
                    )
                },
                show: showMenu,
                spacing: selectedVariant == .custom ? spacing : selectedVariant.config.spacing,
                itemWidth: selectedVariant == .custom ? itemWidth : selectedVariant.config.itemWidth,
                horizontalPadding: 16,
                verticalPadding: 8
            )
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .padding(.vertical, 8)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Menu Items Customization Panel
    private var menuItemsCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "square.grid.3x2")
                    .foregroundColor(.pink)
                
                Text("Menu Items")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(menuItems.count) items")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.pink.opacity(0.1))
                    .cornerRadius(6)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationCard(
                    icon: "plus.circle",
                    title: "Add Items",
                    description: "Add new menu items"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button("Add Sample Item") {
                            addSampleMenuItem()
                        }
                        .buttonStyle(.bordered)
                        .font(.system(size: 14))
                        
                        Button("Clear All Items", role: .destructive) {
                            clearAllItems()
                        }
                        .buttonStyle(.bordered)
                        .font(.system(size: 14))
                    }
                }
                
                CustomizationCard(
                    icon: "sparkles",
                    title: "Badges",
                    description: "New item indicators"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Show New Badges", isOn: $showNewBadges)
                        
                        if showNewBadges {
                            Text("\(menuItems.filter { $0.isNew }.count) items marked as new")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            // Menu Items List
            VStack(alignment: .leading, spacing: 12) {
                Text("Current Menu Items")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ForEach(Array(menuItems.enumerated()), id: \.offset) { index, item in
                    HStack {
                        // Show placeholder for icon since we're using URLs
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 24, height: 24)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            )
                        
                        Text(item.title)
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                        
                        if item.isNew {
                            Text("NEW")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                        
                        Button("Remove") {
                            removeMenuItem(at: index)
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Layout Customization Panel
    private var layoutCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "ruler")
                    .foregroundColor(.pink)
                
                Text("Layout Customization")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationCard(
                    icon: "arrow.left.and.right",
                    title: "Spacing",
                    description: "Item spacing and width"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Spacing: \(Int(spacing))pt")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $spacing, in: 8...32, step: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Width: \(Int(itemWidth))pt")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $itemWidth, in: 80...150, step: 10)
                        }
                    }
                }
                
                CustomizationCard(
                    icon: "photo",
                    title: "Icons",
                    description: "Icon size and styling"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Icon Size: \(Int(iconSize))pt")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $iconSize, in: 30...60, step: 5)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Selection Feedback Section
    private var selectionFeedbackSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                
                Text("Selection Feedback")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Clear") {
                    selectedMenuItem = ""
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            Text("Last tapped: \(selectedMenuItem)")
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Code Integration
    private var codeIntegrationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "curlybraces")
                    .foregroundColor(.pink)
                
                Text("Code Integration")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Copy") {
                    UIPasteboard.general.string = codeSnippet
                }
                .font(.caption)
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            
            CodeBlock(code: codeSnippet)
                .frame(height: 300)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private var codeSnippet: String {
        """
import SwiftUI

struct ContentView: View {
    let menuItems = [
        TPEMenuItemHorizontal(
            title: "Transfer",
            iconUrl: "https://example.com/transfer.png",
            iconSize: \(selectedVariant == .custom ? CGFloat(Int(iconSize)) : selectedVariant.config.iconSize),
            isNew: \(selectedVariant.config.showNewBadges ? "true" : "false"),
            onTap: {
                print("Transfer tapped")
            }
        ),
        TPEMenuItemHorizontal(
            title: "Pay Bills",
            iconUrl: "https://example.com/bills.png",
            iconSize: \(selectedVariant == .custom ? CGFloat(Int(iconSize)) : selectedVariant.config.iconSize),
            isNew: false,
            onTap: {
                print("Pay Bills tapped")
            }
        ),
        TPEMenuItemHorizontal(
            title: "Top Up",
            iconUrl: "https://example.com/topup.png",
            iconSize: \(selectedVariant == .custom ? CGFloat(Int(iconSize)) : selectedVariant.config.iconSize),
            isNew: \(selectedVariant.config.showNewBadges ? "true" : "false"),
            onTap: {
                print("Top Up tapped")
            }
        )\(menuItems.count > 3 ? ",\n        // ... \(menuItems.count - 3) more items" : "")
    ]
    
    var body: some View {
        TPEMenuListHorizontal(
            menuItems: menuItems,
            show: true,
            spacing: \(selectedVariant == .custom ? Int(spacing) : Int(selectedVariant.config.spacing)),
            itemWidth: \(selectedVariant == .custom ? Int(itemWidth) : Int(selectedVariant.config.itemWidth)),
            horizontalPadding: 16,
            verticalPadding: 8
        )
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func updateVariantSettings(for variant: MenuVariant) {
        switch variant {
        case .default:
            spacing = 16
            itemWidth = 100
            iconSize = 40
            showNewBadges = true
        case .compact:
            spacing = 8
            itemWidth = 80
            iconSize = 35
            showNewBadges = false
        case .spacious:
            spacing = 24
            itemWidth = 120
            iconSize = 40
            showNewBadges = true
        case .largeIcons:
            spacing = 16
            itemWidth = 110
            iconSize = 50
            showNewBadges = false
        case .withNewBadges:
            spacing = 16
            itemWidth = 100
            iconSize = 40
            showNewBadges = true
        case .custom:
            spacing = 20
            itemWidth = 100
            iconSize = 45
            showNewBadges = true
        }
        
        // Update menu items with new badge settings
        updateMenuItemsBadges()
    }
    
    private func handleMenuItemTap(_ title: String) {
        selectedMenuItem = "\(title) - \(Date().formatted(date: .omitted, time: .standard))"
        print("Menu item tapped: \(title)")
    }
    
    private func addSampleMenuItem() {
        let sampleItems = [
            ("Invest", "https://example.com/invest.png"),
            ("Insurance", "https://example.com/insurance.png"),
            ("Loans", "https://example.com/loans.png"),
            ("Rewards", "https://example.com/rewards.png"),
            ("Support", "https://example.com/support.png")
        ]
        
        if let randomItem = sampleItems.randomElement() {
            let newItem = TPEMenuItemHorizontal(
                title: randomItem.0,
                iconUrl: randomItem.1,
                iconSize: iconSize,
                isNew: Bool.random(),
                onTap: {
                    handleMenuItemTap(randomItem.0)
                }
            )
            menuItems.append(newItem)
        }
    }
    
    private func removeMenuItem(at index: Int) {
        menuItems.remove(at: index)
    }
    
    private func clearAllItems() {
        menuItems.removeAll()
    }
    
    private func updateMenuItemsBadges() {
        // This would update the actual menu items in a real scenario
        // For demo purposes, we're handling it through the mapping in the preview
    }
}

// MARK: - Supporting Views (keep these the same as in your original code)
// ... [Keep the MenuVariantCard, ConfigRow, and other supporting views unchanged]
