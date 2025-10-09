////
////  AtomsCatalogView.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 06/10/25.
////
//
//import SwiftUI
//import TPEComponentSDK
//
//struct AtomsCatalogView: View {
//    var body: some View {
//        ScrollView {
//            LazyVStack(alignment: .leading, spacing: 32) {
//                HeaderView(
//                    title: "Atoms",
//                    subtitle: "Basic building blocks of our design system"
//                )
//                
//                // Buttons Section
//                ComponentSection(title: "Buttons", icon: "button.programmable") {
//                    VStack(spacing: 16) {
//                        TPEButton(
//                            title: "Primary Action",
//                            variant: .primary,
//                            onPressed: {}
//                        )
//                        
//                        TPEButton(
//                            title: "Secondary Action",
//                            variant: .secondary,
//                            onPressed: {}
//                        )
//                        
//                        TPEButton(
//                            title: "Disabled State",
//                            variant: .primary,
//                            isEnabled: false,
//                            onPressed: {}
//                        )
//                    }
//                }
//                
//                // Text Section
//                ComponentSection(title: "Typography", icon: "textformat") {
//                    VStack(alignment: .leading, spacing: 12) {
//                        TPEText(
//                            text: "Display Headline",
//                            variant: .text16Bold,
//                            color: .primary,
//                            textAlignment: .leading
//                        )
//                        
//                        TPEText(
//                            text: "Supporting text that provides additional context and can span multiple lines for detailed descriptions.",
//                            variant: .secondary,
//                            color: .secondary,
//                            textAlignment: .leading
//                        )
//                    }
//                }
//                
//                // Form Elements Section
//                ComponentSection(title: "Form Elements", icon: "square.and.pencil") {
//                    VStack(spacing: 16) {
//                        // Example form field using atoms
//                        HStack {
//                            Image(systemName: "envelope")
//                                .foregroundColor(.gray)
//                            
//                            TextField("Email address", text: .constant(""))
//                                .textFieldStyle(PlainTextFieldStyle())
//                        }
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Atoms")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//struct ComponentSection<Content: View>: View {
//    let title: String
//    let icon: String
//    let content: () -> Content
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            HStack {
//                Image(systemName: icon)
//                    .foregroundColor(.blue)
//                    .font(.system(size: 18))
//                
//                Text(title)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                
//                Spacer()
//            }
//            
//            content()
//                .padding()
//                .background(Color(.systemBackground))
//                .cornerRadius(12)
//                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
//        }
//    }
//}

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
    
    let atoms: [AtomItem] = [
        // Buttons
        AtomItem(
            title: "TPEButton",
            subtitle: "Primary, secondary, and variant buttons",
            icon: "button.programmable",
            category: .buttons,
            destination: .tpeButton
        ),
        
        // Typography
        AtomItem(
            title: "TPEText",
            subtitle: "Text styles and typography system",
            icon: "textformat",
            category: .typography,
            destination: .tpeText
        ),
        
        // Form Elements
        AtomItem(
            title: "Input Fields",
            subtitle: "Text fields and input components",
            icon: "square.and.pencil",
            category: .formElements,
            destination: .inputFields
        ),
        
        AtomItem(
            title: "Checkbox & Toggle",
            subtitle: "Selection and toggle components",
            icon: "checkmark.square",
            category: .formElements,
            destination: .checkboxToggle
        ),
        
        // Indicators
        AtomItem(
            title: "Progress Indicators",
            subtitle: "Loading and progress indicators",
            icon: "circle.hexagongrid",
            category: .indicators,
            destination: .progressIndicators
        ),
        
        AtomItem(
            title: "TPELink",
            subtitle: "Link library and usage",
            icon: "star",
            category: .indicators,
            destination: .link
        ),
        
        // Navigation
        AtomItem(
            title: "Navigation Items",
            subtitle: "Back buttons and navigation elements",
            icon: "arrow.triangle.turn.up.right.diamond",
            category: .navigation,
            destination: .navigationItems
        )
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

// MARK: - Atom Item Model

struct AtomItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let category: AtomsCatalogView.AtomCategory
    let destination: AtomDestination
    
    enum AtomDestination {
        case tpeButton
        case tpeText
        case inputFields
        case checkboxToggle
        case progressIndicators
        case link
        case navigationItems
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .tpeButton:
                TPEButtonCatalogView()
            case .tpeText:
                TPETextCatalogView()
            case .inputFields:
                InputFieldsCatalogView()
            case .checkboxToggle:
                CheckboxToggleCatalogView()
            case .progressIndicators:
                ProgressIndicatorsCatalogView()
            case .link:
                TpeLinkCatalogView()
            case .navigationItems:
                NavigationItemsCatalogView()
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

//// MARK: - Previews
//
//#Preview("Atoms Catalog") {
//    NavigationView {
//        AtomsCatalogView()
//    }
//}
//
//#Preview("Empty State") {
//    NavigationView {
//        ScrollView {
//            LazyVStack(spacing: 24) {
//                HeaderView(
//                    title: "Atoms",
//                    subtitle: "Basic building blocks of our design system"
//                )
//                
//                SearchBar(text: .constant("Invalid Search"), placeholder: "Search atoms...")
//                
//                CategoryFilter(
//                    selectedCategory: .constant(.buttons),
//                    categories: AtomsCatalogView.AtomCategory.allCases
//                )
//                
//                EmptyStateView.noResults(query: "Invalid Search")
//            }
//            .padding()
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Atoms")
//    }
//}
