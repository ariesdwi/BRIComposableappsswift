//
//  OrganismCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPELoginSDK
import TPEComponentSDK

struct OrganismCatalogView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: OrganismCategory = .all
    
    enum OrganismCategory: String, CaseIterable, Identifiable, FilterCategory {
        case all = "All"
        case authentication = "Authentication"
        case navigation = "Navigation"
        case dataDisplay = "Data Display"
        case feedback = "Feedback"
        case layout = "Layout"
        
        var id: String { rawValue }
        var title: String { rawValue }
        
        var icon: String {
            switch self {
            case .all: return "square.grid.2x2"
            case .authentication: return "person.crop.circle"
            case .navigation: return "arrow.triangle.turn.up.right.diamond"
            case .dataDisplay: return "list.bullet.rectangle"
            case .feedback: return "exclamationmark.bubble"
            case .layout: return "rectangle.split.3x3"
            }
        }
    }
    
    // MARK: - Easy to Update Organism List
    private let organisms: [OrganismItem] = [
        // Authentication Category
        .loginOrganism,
        .loginBottomSheet,
        .balanceCard,
        .headerComponent,
        .menuListVertical,
        .transactionSection,
        .promoSection
    ]
    
    var filteredOrganisms: [OrganismItem] {
        let categoryFiltered = selectedCategory == .all ? organisms : organisms.filter { $0.category == selectedCategory }
        
        if searchText.isEmpty {
            return categoryFiltered
        } else {
            return categoryFiltered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Organisms",
                    subtitle: "Complex components built from atoms and molecules"
                )
                
                // Search Bar
                SearchBar(text: $searchText, placeholder: "Search organisms...")
                
                // Category Filter
                CategoryFilter(
                    selectedCategory: $selectedCategory,
                    categories: OrganismCategory.allCases
                )
                
                // Organisms Grid
                if filteredOrganisms.isEmpty {
                    EmptyStateView.noResults(query: searchText.isEmpty ? nil : searchText)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(filteredOrganisms) { organism in
                            OrganismCard(item: organism)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Organisms")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Organism Item Model with Static Properties

struct OrganismItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let category: OrganismCatalogView.OrganismCategory
    let destination: OrganismDestination
    
    // MARK: - Predefined Organisms - Easy to Add New Ones
    
    // Authentication
    static let loginOrganism = OrganismItem(
        title: "Login Organism",
        subtitle: "Complete authentication templates with variants",
        icon: "person.crop.circle",
        category: .authentication,
        destination: .loginOrganism
    )
    
    static let loginBottomSheet = OrganismItem(
        title: "Login Bottom Sheet",
        subtitle: "Modal login forms with validation",
        icon: "rectangle.portrait.bottomthird.inset.filled",
        category: .authentication,
        destination: .loginBottomSheet
    )
    
    // Data Display
    static let balanceCard = OrganismItem(
        title: "Balance Card",
        subtitle: "Taiwan-style balance card with toggle",
        icon: "creditcard.fill",
        category: .dataDisplay,
        destination: .balanceCard
    )
    
    static let headerComponent = OrganismItem(
        title: "Header Component",
        subtitle: "Customizable header with user greeting",
        icon: "rectangle.topthird.inset.filled",
        category: .navigation,
        destination: .headerComponent
    )
    
    static let menuListVertical = OrganismItem(
        title: "Vertical Menu List",
        subtitle: "Horizontally scrolling vertical menu items",
        icon: "square.grid.3x2",
        category: .navigation,
        destination: .menuListVertical
    )
    
    // In OrganismItem struct
    static let transactionSection = OrganismItem(
        title: "Transaction Section",
        subtitle: "Transaction lists with headers and empty states",
        icon: "list.bullet.rectangle",
        category: .dataDisplay,
        destination: .transactionSection
    )
    
    static let promoSection = OrganismItem(
        title: "Promo Section",
        subtitle: "Promotional banners with section headers",
        icon: "tag.fill",
        category: .dataDisplay,
        destination: .promoSection
    )


   
    
    // MARK: - Destination Enum
    enum OrganismDestination {
        case loginOrganism
        case loginBottomSheet
        case balanceCard
        case headerComponent
        case menuListVertical
        case transactionSection
        case promoSection
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .loginOrganism:
                LoginOrganismDetailView()
            case .loginBottomSheet:
                LoginBottomSheetDetailView()
            case .balanceCard:
                BalanceCardDetailView()
            case .headerComponent:
                TPEHeaderComponentDetailView()
            case .menuListVertical:
                TPEMenuListVerticalDetailView()
            case .transactionSection:
                TPETransactionSectionDetailView()
            case .promoSection:
                TPEPromoSectionDetailView()
            }
        }
    }
}

// MARK: - Organism Card

struct OrganismCard: View {
    let item: OrganismItem
    
    var body: some View {
        NavigationLink(destination: item.destination.view) {
            VStack(alignment: .leading, spacing: 12) {
                // Icon
                ZStack {
                    Circle()
                        .fill(item.category.color.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: item.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(item.category.color)
                        .symbolRenderingMode(.hierarchical)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(item.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Category Badge
                HStack {
                    Text(item.category.rawValue)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(item.category.color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(item.category.color.opacity(0.1))
                        .cornerRadius(6)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
            .frame(height: 160)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Category Color Extension

extension OrganismCatalogView.OrganismCategory {
    var color: Color {
        switch self {
        case .all: return .blue
        case .authentication: return .green
        case .navigation: return .orange
        case .dataDisplay: return .purple
        case .feedback: return .pink
        case .layout: return .indigo
        }
    }
}

