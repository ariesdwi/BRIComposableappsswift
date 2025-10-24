//
//  AtomsCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI
import TPEComponentSDK

struct AtomsCatalogView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: AtomCategory = .all
    
    enum AtomCategory: String, CaseIterable, Identifiable, FilterCategory {
        case all = "All"
        case buttons = "Buttons"
        case typography = "Typography"
        case formElements = "Form Elements"
        case indicators = "Indicators"
        case navigation = "Navigation"
        
        var id: String { rawValue }
        var title: String { rawValue }
        
        var icon: String {
            switch self {
            case .all: return "square.grid.2x2"
            case .buttons: return "button.programmable"
            case .typography: return "textformat"
            case .formElements: return "square.and.pencil"
            case .indicators: return "circle.hexagongrid"
            case .navigation: return "arrow.triangle.turn.up.right.diamond"
            }
        }
    }
    
    // MARK: - Easy to Update Atom List
    private let atoms: [AtomItem] = [
        // Buttons Category
        .tpeButton,
        // Form Elements Category
        .inputField,
        .eyeToggleButton,
        
        // Indicators Category
        .balanceIndicator,
        
        // Typography Category
        .tpeText,
        .tpeLink,
        
      
        
    ]
    
    var filteredAtoms: [AtomItem] {
        let categoryFiltered = selectedCategory == .all ? atoms : atoms.filter { $0.category == selectedCategory }
        
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
                    title: "Atoms",
                    subtitle: "Basic building blocks of our design system"
                )
                
                // Search Bar
                SearchBar(text: $searchText, placeholder: "Search atoms...")
                
                // Category Filter
                CategoryFilter(
                    selectedCategory: $selectedCategory,
                    categories: AtomCategory.allCases
                )
                
                // Atoms Grid
                if filteredAtoms.isEmpty {
                    EmptyStateView.noResults(query: searchText.isEmpty ? nil : searchText)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(filteredAtoms) { atom in
                            AtomCard(item: atom)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Atoms")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Atom Item Model with Static Properties

struct AtomItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let category: AtomsCatalogView.AtomCategory
    let destination: AtomDestination
    
    // MARK: - Predefined Atoms - Easy to Add New Ones
    
    // Buttons
    static let tpeButton = AtomItem(
        title: "TPEButton",
        subtitle: "Primary, secondary, and variant buttons",
        icon: "button.programmable",
        category: .buttons,
        destination: .tpeButton
    )
    
    static let circleIconButton = AtomItem(
        title: "TPECircleIconButton",
        subtitle: "Circular icon buttons with badges",
        icon: "circle.circle",
        category: .buttons,
        destination: .circleIconButton
    )
    
    // Form Elements
    static let inputField = AtomItem(
        title: "TPEInputField",
        subtitle: "Text fields and input components",
        icon: "square.and.pencil",
        category: .formElements,
        destination: .inputField
    )
    
    static let eyeToggleButton = AtomItem(
        title: "TPEEyeToggleButton",
        subtitle: "Toggle visibility for sensitive content",
        icon: "eye",
        category: .formElements,
        destination: .eyeToggleButton
    )
    
    // Indicators
    static let balanceIndicator = AtomItem(
        title: "TPEBalanceIndicator",
        subtitle: "Visual balance and progress indicators",
        icon: "circle.grid.3x3",
        category: .indicators,
        destination: .balanceIndicator
    )
    
    // Typography
    static let tpeText = AtomItem(
        title: "TPEText",
        subtitle: "Text styles and typography system",
        icon: "textformat",
        category: .typography,
        destination: .tpeText
    )
    
    static let tpeLink = AtomItem(
        title: "TPELink",
        subtitle: "Link components and navigation",
        icon: "link",
        category: .typography,
        destination: .tpeLink
    )
    
    static let copyButton = AtomItem(
           title: "TPECopyButton",
           subtitle: "Copy text to clipboard with feedback",
           icon: "doc.on.doc",
           category: .buttons,
           destination: .copyButton
       )
    
    // Navigation
//    static let progressIndicators = AtomItem(
//        title: "Progress Indicators",
//        subtitle: "Loading and progress indicators",
//        icon: "circle.hexagongrid",
//        category: .navigation,
//        destination: .progressIndicators
//    )
    
    // MARK: - Easy to Add New Atoms Here
    /*
    static let newComponent = AtomItem(
        title: "New Component",
        subtitle: "Description of new component",
        icon: "star",
        category: .buttons, // Choose appropriate category
        destination: .newComponent
    )
    */
    
    // MARK: - Destination Enum
    enum AtomDestination {
        case tpeButton
        case circleIconButton
        case inputField
        case eyeToggleButton
        case balanceIndicator
        case tpeText
        case tpeLink
        case copyButton

        
        @ViewBuilder
        var view: some View {
            switch self {
            case .tpeButton:
                TPEButtonCatalogView()
            case .circleIconButton:
                TPECircleIconButtonCatalogView()
            case .inputField:
                TPEInputFieldCatalogView()
            case .eyeToggleButton:
                TPEEyeToggleButtonCatalogView()
            case .balanceIndicator:
                TPEBalanceIndicatorCatalogView()
            case .tpeText:
                TPETextCatalogView()
            case .tpeLink:
                TpeLinkCatalogView()
            case .copyButton:
                TPECopyButtonCatalogView()
            }
        }
    }
}

// MARK: - Atom Card

struct AtomCard: View {
    let item: AtomItem
    
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

extension AtomsCatalogView.AtomCategory {
    var color: Color {
        switch self {
        case .all: return .blue
        case .buttons: return .green
        case .typography: return .orange
        case .formElements: return .purple
        case .indicators: return .pink
        case .navigation: return .indigo
        }
    }
}

// MARK: - Helper Extension for Easy Updates

extension AtomsCatalogView {
    /// Helper method to get all atoms for a specific category
    func atoms(in category: AtomCategory) -> [AtomItem] {
        atoms.filter { $0.category == category }
    }
    
    /// Helper method to get atom count by category
    var atomCountByCategory: [AtomCategory: Int] {
        Dictionary(grouping: atoms, by: { $0.category })
            .mapValues { $0.count }
    }
}

// MARK: - Placeholder for Missing Catalog Views

struct ProgressIndicatorsCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "Progress Indicators",
                    subtitle: "Loading and progress indicator components"
                )
                
                Text("Progress Indicators Catalog")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Progress Indicators")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Previews

#Preview("Atoms Catalog") {
    NavigationView {
        AtomsCatalogView()
    }
}

#Preview("Atom Card") {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
        AtomCard(item: .tpeButton)
        AtomCard(item: .inputField)
        AtomCard(item: .balanceIndicator)
        AtomCard(item: .eyeToggleButton)
    }
    .padding()
}
