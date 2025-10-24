//
//  BalanceCardDetailView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//


import SwiftUI
import TPEHomepageSDK
import TPEComponentSDK

struct BalanceCardDetailView: View {
    @State private var balanceVisible = true
    @State private var selectedVariant: BalanceCardVariant = .default
    @State private var customHeight: CGFloat = 140
    @State private var customWidth: CGFloat = 320
    @State private var showBackgroundImage = true
    @State private var showDivider = true
    @State private var showSeeAllButton = false
    
    enum BalanceCardVariant: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case customSize = "Custom Size"
        case noBackground = "No Background"
        case noDivider = "No Divider"
        
        var id: String { rawValue }
        
        var description: String {
            switch self {
            case .default: return "Standard Taiwan balance card"
            case .customSize: return "Custom width and height"
            case .noBackground: return "Without background image"
            case .noDivider: return "Without divider line"
            }
        }
        
        var icon: String {
            switch self {
            case .default: return "creditcard"
            case .customSize: return "arrow.up.left.and.arrow.down.right"
            case .noBackground: return "photo"
            case .noDivider: return "minus"
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Balance Card",
                    subtitle: "Taiwan-style balance card with account number and balance toggle"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Card Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(BalanceCardVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(BalanceCardVariant.allCases) { variant in
                            BalanceCardVariantCard(
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
                }
                
                // Interactive Preview
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Interactive Preview")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Toggle("Show Balance", isOn: $balanceVisible)
                            .font(.system(size: 14))
                    }
                    
                    previewCard
                }
                
                // Customization Panel
                customizationPanel
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Balance Card")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Preview Card
    private var previewCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.purple)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("Live Preview")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text(selectedVariant.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Card Preview
            TPEBalanceCardTW(
                accountNumber: "1234567890123456",
                currency: "NT$",
                currentBalance: 12500.75,
                isLoading: false,
                backgroundColor: .white,
                backgroundImage: showBackgroundImage ? "assets/images/Taiwan_card_image_2.png" : nil,
                borderRadius: 16,
                height: selectedVariant == .customSize ? customHeight : nil,
                width: selectedVariant == .customSize ? customWidth : nil,
                showDivider: showDivider,
                onSeeAll: showSeeAllButton ? {
                    print("See All tapped")
                } : nil
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Customization Panel
    private var customizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.purple)
                
                Text("Customization Options")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Reset") {
                    withAnimation {
                        resetCustomization()
                    }
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationCard(
                    icon: "photo",
                    title: "Appearance",
                    description: "Visual styling"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Background Image", isOn: $showBackgroundImage)
                        Toggle("Show Divider", isOn: $showDivider)
                        Toggle("See All Button", isOn: $showSeeAllButton)
                    }
                }
                
                if selectedVariant == .customSize {
                    CustomizationCard(
                        icon: "ruler",
                        title: "Dimensions",
                        description: "Card size"
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Width: \(Int(customWidth))pt")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Slider(
                                    value: $customWidth,
                                    in: 200...400,
                                    step: 20
                                )
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Height: \(Int(customHeight))pt")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Slider(
                                    value: $customHeight,
                                    in: 100...200,
                                    step: 20
                                )
                            }
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
    
    // MARK: - Code Integration
    private var codeIntegrationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "curlybraces")
                    .foregroundColor(.purple)
                
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
                .frame(height: 200)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private var codeSnippet: String {
        """
import SwiftUI
import TPEComponentSDK

struct ContentView: View {
    var body: some View {
        TPEBalanceCardTW(
            accountNumber: "1234567890123456",
            currency: "NT$",
            currentBalance: 12500.75,
            isLoading: false\(selectedVariant == .noBackground ? "\n            backgroundImage: nil," : "")\(selectedVariant == .customSize ? "\n            height: \(Int(customHeight)),\n            width: \(Int(customWidth))," : "")\(selectedVariant == .noDivider ? "\n            showDivider: false," : "")\(showSeeAllButton ? "\n            onSeeAll: {\n                print(\"See All tapped\")\n            }" : "")
        )
        .padding()
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func updateVariantSettings(for variant: BalanceCardVariant) {
        switch variant {
        case .default:
            showBackgroundImage = true
            showDivider = true
            showSeeAllButton = false
        case .customSize:
            showBackgroundImage = true
            showDivider = true
            showSeeAllButton = false
            customHeight = 140
            customWidth = 320
        case .noBackground:
            showBackgroundImage = false
            showDivider = true
            showSeeAllButton = false
        case .noDivider:
            showBackgroundImage = true
            showDivider = false
            showSeeAllButton = false
        }
    }
    
    private func resetCustomization() {
        selectedVariant = .default
        showBackgroundImage = true
        showDivider = true
        showSeeAllButton = false
        customHeight = 140
        customWidth = 320
    }
}



struct BalanceCardVariantCard: View {
    let variant: BalanceCardDetailView.BalanceCardVariant
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: variant.icon)
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .purple)
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
                }
                
                Spacer()
            }
            .padding(16)
            .frame(height: 120)
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
        isSelected ? .purple : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .purple : Color.gray.opacity(0.2)
    }
}
