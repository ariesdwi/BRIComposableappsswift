//
//  PromoDetailView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//

// MARK: - Promo Section Detail View
import SwiftUI
import TPEHomepageSDK
import TPEComponentSDK

struct TPEPromoSectionDetailView: View {
    @State private var selectedVariant: PromoVariant = .withHeader
    @State private var showHeader: Bool = true
    @State private var promoCount: Int = 2
    @State private var selectedPromo: String = ""
    @State private var headerTitle: String = "Promo & Cashback"
    @State private var headerSubtitle: String = "Penawaran khusus buat kamu"
    
    // Sample promo data matching your structure
    @State private var promos: [TPEPromoItem] = [
        TPEPromoItem(
            title: "Weekend Special",
            subtitle: "Extra rewards points",
            imageUrl: "https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
            validity: "Every weekend",
            badge: "POPULAR"
        ),
        TPEPromoItem(
            title: "Free Transfer",
            subtitle: "Zero fees international",
            imageUrl: "https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
            validity: "Limited time",
            badge: "NEW"
        ),
        TPEPromoItem(
            title: "Cashback 20%",
            subtitle: "All dining transactions",
            imageUrl: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
            validity: "Until Oct 30",
            badge: "HOT"
        ),
        TPEPromoItem(
            title: "Travel Discount",
            subtitle: "Up to 50% off hotels",
            imageUrl: "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
            validity: "Seasonal offer",
            badge: nil
        )
    ]
    
    enum PromoVariant: String, CaseIterable, Identifiable {
        case withHeader = "With Header"
        case withoutHeader = "Without Header"
        case singlePromo = "Single Promo"
        case multiplePromos = "Multiple Promos"
        case withBadges = "With Badges"
        case custom = "Custom"
        
        var id: String { rawValue }
        
        var description: String {
            switch self {
            case .withHeader: return "Section with header and promo banners"
            case .withoutHeader: return "Promo banners without section header"
            case .singlePromo: return "Single promo banner display"
            case .multiplePromos: return "Multiple promo banners in scroll"
            case .withBadges: return "Promos with special badges"
            case .custom: return "Customizable promo section"
            }
        }
        
        var icon: String {
            switch self {
            case .withHeader: return "text.justify.left"
            case .withoutHeader: return "rectangle.stack"
            case .singlePromo: return "rectangle"
            case .multiplePromos: return "rectangle.stack.fill"
            case .withBadges: return "rosette"
            case .custom: return "slider.horizontal.3"
            }
        }
    }
    
    var displayedPromos: [TPEPromoItem] {
        Array(promos.prefix(promoCount))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Promo Section",
                    subtitle: "Promotional banners with section headers"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Promo Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(PromoVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(PromoVariant.allCases) { variant in
                                PromoVariantCard(
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
                        
                        Text("LIVE PREVIEW")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    
                    previewContainer
                }
                
                // Header Customization
                headerCustomizationPanel
                
                // Promo Settings
                promoSettingsPanel
                
                // Promo Items Management
                promoItemsPanel
                
                // Selection Feedback
                if !selectedPromo.isEmpty {
                    selectionFeedbackSection
                }
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Promo Section")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Preview Container
    private var previewContainer: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.purple)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("Real-time")
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
            
            // Promo Section Preview
            TPEPromoSection(
                sectionHeaderPromo: showHeader ? TpeComponentSectionHeader(
                    title: headerTitle,
                    subtitle: headerSubtitle,
                    onTap: {
                        print("Promo header tapped")
                        selectedPromo = "Header tapped - \(Date().formatted(date: .omitted, time: .standard))"
                    }
                ) : nil,
                promoBannerTw: TpePromoListBannerTw(
                    promos: displayedPromos
                )
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Header Customization Panel
    private var headerCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "text.justify.left")
                    .foregroundColor(.purple)
                
                Text("Header Settings")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle("Show Header", isOn: $showHeader)
                    .font(.system(size: 14))
            }
            
            if showHeader {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    CustomizationCard(
                        icon: "textformat",
                        title: "Header Content",
                        description: "Title and subtitle"
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            CustomTextField("Header Title", text: $headerTitle)
                            CustomTextField("Header Subtitle", text: $headerSubtitle)
                        }
                    }
                    
                    CustomizationCard(
                        icon: "info.circle",
                        title: "Header Info",
                        description: "TpeComponentSectionHeader"
                    ) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Includes tap action")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            Text("Auto-spacing: 16pt")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
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
    
    // MARK: - Promo Settings Panel
    private var promoSettingsPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.purple)
                
                Text("Promo Settings")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(displayedPromos.count) promos")
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
            ], spacing: 16) {
                CustomizationCard(
                    icon: "number",
                    title: "Display Count",
                    description: "Number of promo banners"
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Showing: \(promoCount) of \(promos.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Stepper("", value: $promoCount, in: 1...4)
                    }
                }
                
                CustomizationCard(
                    icon: "info.circle",
                    title: "Banner Info",
                    description: "TpePromoListBannerTw"
                ) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Horizontal scroll")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        Text("Auto-padding: 16pt")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Promo Items Panel
    private var promoItemsPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "photo.on.rectangle")
                    .foregroundColor(.purple)
                
                Text("Promo Items")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Add Sample") {
                    addSamplePromo()
                }
                .font(.caption)
                .buttonStyle(.bordered)
            }
            
            // Promo Items List
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(promos.enumerated()), id: \.offset) { index, promo in
                    PromoItemRow(promo: promo, index: index) {
                        removePromo(at: index)
                    }
                    .onTapGesture {
                        handlePromoTap(promo.title)
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
                    selectedPromo = ""
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            Text("Last tapped: \(selectedPromo)")
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
                .frame(height: 350)
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
        TPEPromoSection(\(showHeader ? """
                sectionHeaderPromo: TpeComponentSectionHeader(
                    title: "\(headerTitle)",
                    subtitle: "\(headerSubtitle)",
                    onTap: {
                        print("Header tapped")
                    }
                ),
                """ : "")
                promoBannerTw: TpePromoListBannerTw(
                    promos: [\(displayedPromos.map { promo in """
                        TPEPromoItem(
                            title: "\(promo.title)",
                            subtitle: "\(promo.subtitle)",
                            imageUrl: "\(promo.imageUrl)",
                            validity: "\(promo.validity)",\(promo.badge != nil ? "\n                            badge: \"\(promo.badge!)\"" : "")
                        )
"""
                    }.joined(separator: ",\n                    "))
                    ]
                )
            )
        }
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func updateVariantSettings(for variant: PromoVariant) {
        switch variant {
        case .withHeader:
            showHeader = true
            promoCount = 2
            headerTitle = "Promo & Cashback"
            headerSubtitle = "Penawaran khusus buat kamu"
        case .withoutHeader:
            showHeader = false
            promoCount = 3
        case .singlePromo:
            showHeader = true
            promoCount = 1
            headerTitle = "Special Offer"
            headerSubtitle = "Limited time deal"
        case .multiplePromos:
            showHeader = true
            promoCount = 4
            headerTitle = "Latest Promotions"
            headerSubtitle = "Multiple offers available"
        case .withBadges:
            showHeader = true
            promoCount = 3
            headerTitle = "Featured Promos"
            headerSubtitle = "Special highlighted offers"
            // Ensure we have badges
//            if !promos.contains(where: { $0.badge != nil }) {
//                promos[0].badge = "POPULAR"
//                promos[1].badge = "NEW"
//            }
        case .custom:
            showHeader = true
            promoCount = 2
            headerTitle = "Custom Promo Section"
            headerSubtitle = "Your custom subtitle"
        }
    }
    
    private func handlePromoTap(_ title: String) {
        selectedPromo = "\(title) - \(Date().formatted(date: .omitted, time: .standard))"
        print("Promo tapped: \(title)")
    }
    
    private func addSamplePromo() {
        let samplePromos = [
            TPEPromoItem(
                title: "Shopping Spree",
                subtitle: "Extra cashback on shopping",
                imageUrl: "https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                validity: "Weekdays only",
                badge: "EXCLUSIVE"
            ),
            TPEPromoItem(
                title: "Movie Night",
                subtitle: "Buy 1 get 1 free tickets",
                imageUrl: "https://images.unsplash.com/photo-1489599809505-7c8e1c75ce13?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                validity: "Friday nights",
                badge: nil
            )
        ]
        
        if let randomPromo = samplePromos.randomElement() {
            promos.append(randomPromo)
        }
    }
    
    private func removePromo(at index: Int) {
        promos.remove(at: index)
        if promoCount > promos.count {
            promoCount = max(1, promos.count)
        }
    }
}

// MARK: - Supporting Views for Promo Section

struct PromoVariantCard: View {
    let variant: TPEPromoSectionDetailView.PromoVariant
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
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Feature indicators
                VStack(alignment: .leading, spacing: 4) {
                    FeatureIndicator(
                        icon: "text.justify.left",
                       
                        isEnabled: variant == .withHeader || variant == .singlePromo || variant == .multiplePromos || variant == .withBadges || variant == .custom
                    )
                    FeatureIndicator(
                        icon: "photo",
                       
                        isEnabled: true
                    )
                    FeatureIndicator(
                        icon: "rosette",
                        
                        isEnabled: variant == .withBadges
                    )
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
        isSelected ? .purple : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .purple : Color.gray.opacity(0.2)
    }
}

struct PromoItemRow: View {
    let promo: TPEPromoItem
    let index: Int
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Promo image preview
            AsyncImage(url: URL(string: promo.imageUrl)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                case .failure:
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.blue)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(promo.title)
                        .font(.system(size: 14, weight: .medium))
                    
                    if let badge = promo.badge {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(badgeColor(for: badge))
                            .cornerRadius(4)
                    }
                }
                
                Text(promo.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Text("Valid: \(promo.validity)")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.8))
            }
            
            Spacer()
            
            Button("Remove", role: .destructive) {
                onRemove()
            }
            .font(.system(size: 12))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func badgeColor(for badge: String) -> Color {
        switch badge {
        case "POPULAR": return .orange
        case "NEW": return .green
        case "HOT": return .red
        case "EXCLUSIVE": return .purple
        default: return .blue
        }
    }
}



