//
//  DesignSystemBrowser.swift
//  TPEComposable
//
//  Created by Your Name
//

import SwiftUI
import TPELoginSDK
import TPEComponentSDK

struct DesignSystemBrowser: View {
    @State private var selectedCategory: Category = .components
    @State private var searchText: String = ""
    
    enum Category: String, CaseIterable, Identifiable, FilterCategory {
        case components = "Components"
        case templates = "Templates"
        case foundations = "Foundations"
        
        var id: String { rawValue }
        var title: String { rawValue }
        
        var icon: String {
            switch self {
            case .components: return "square.grid.2x2"
            case .templates: return "rectangle.3.group"
            case .foundations: return "paintpalette"
            }
        }
    }
    
    var filteredItems: [DesignSystemItem] {
        let items = DesignSystemItem.allItems
        if searchText.isEmpty {
            return items.filter { $0.category == selectedCategory }
        } else {
            return items.filter {
                $0.category == selectedCategory &&
                ($0.title.localizedCaseInsensitiveContains(searchText) ||
                 $0.subtitle.localizedCaseInsensitiveContains(searchText))
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 24) {
                        HeaderView(
                            title: "TPE Design System",
                            subtitle: "Explore our design system components and templates"
                        )
                        .padding(.horizontal)
                        
                        // Search Bar
                        SearchBar(
                            text: $searchText,
                            placeholder: "Search components..."
                        )
                        .padding(.horizontal)
                        
                        // Category Filter
                        CategoryFilter(
                            selectedCategory: $selectedCategory,
                            categories: Category.allCases
                        )
                        .padding(.horizontal)
                        
                        // Items Grid
                        if filteredItems.isEmpty {
                            EmptyStateView.noResults(query: searchText.isEmpty ? nil : searchText)
                                .padding(.horizontal)
                        } else {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ],
                                spacing: 16
                            ) {
                                ForEach(filteredItems) { item in
                                    DesignSystemCard(item: item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Design System")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Design System Card
struct DesignSystemCard: View {
    let item: DesignSystemItem
    
    var body: some View {
        NavigationLink(destination: item.destinationView) {
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

// MARK: - Design System Item Model
struct DesignSystemItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let category: DesignSystemBrowser.Category
    let destination: Destination
    
    enum Destination {
        case atoms
        case molecules
        case organisms
        case typography
        case colors
        case loginTemplate
        case homepageTemplate
        case accountTemplate
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .atoms:
                AtomsCatalogView()
            case .molecules:
                MoleculeCatalogView()
            case .organisms:
                OrganismCatalogView()
            case .typography:
                TypographyCatalogView()
            case .colors:
                ColorsCatalogView()
            case .loginTemplate:
                LoginTemplateCatalogView()
            case .homepageTemplate:
                HomepageTemplateCatalogView()
            case .accountTemplate:
                AccountTemplateCatalogView()
            }
        }
    }
    
    var destinationView: some View {
        destination.view
    }
    
    static let allItems: [DesignSystemItem] = [
        // Foundations
        DesignSystemItem(
            title: "Colors",
            subtitle: "Color palette and usage guidelines",
            icon: "paintpalette.fill",
            category: .foundations,
            destination: .colors
        ),
        DesignSystemItem(
            title: "Typography",
            subtitle: "Text styles and font hierarchy",
            icon: "textformat",
            category: .foundations,
            destination: .typography
        ),
        
        // Components - Atoms
        DesignSystemItem(
            title: "Atoms",
            subtitle: "Basic building blocks and elements",
            icon: "atom",
            category: .components,
            destination: .atoms
        ),
        
        // Components - Molecules
        DesignSystemItem(
            title: "Molecules",
            subtitle: "Simple component combinations",
            icon: "circle.hexagongrid",
            category: .components,
            destination: .molecules
        ),
        
        // Components - Organisms
        DesignSystemItem(
            title: "Organisms",
            subtitle: "Complex UI sections and patterns",
            icon: "square.3.layers.3d",
            category: .components,
            destination: .organisms
        ),
        
        // Templates
        DesignSystemItem(
            title: "Login",
            subtitle: "Authentication screens and flows",
            icon: "person.crop.circle.fill",
            category: .templates,
            destination: .loginTemplate
        ),
        DesignSystemItem(
            title: "HomePage",
            subtitle: "Main application overview screens",
            icon: "chart.bar.fill",
            category: .templates,
            destination: .homepageTemplate
        ),
        DesignSystemItem(
            title: "Account",
            subtitle: "User profile and settings screens",
            icon: "person.fill",
            category: .templates,
            destination: .accountTemplate
        )
    ]
}

// MARK: - Category Color Extension
extension DesignSystemBrowser.Category {
    var color: Color {
        switch self {
        case .components: return .blue
        case .templates: return .green
        case .foundations: return .orange
        }
    }
}


struct HomepageTemplateCatalogView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeaderView(
                    title: "Homepage Templates",
                    subtitle: "Dashboard and overview screen templates"
                )
                
                EmptyStateView(
                    title: "Template Gallery",
                    subtitle: "Homepage template examples will be displayed here",
                    icon: "chart.bar.fill"
                )
            }
            .padding()
        }
        .navigationTitle("Homepage Templates")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct AccountTemplateCatalogView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeaderView(
                    title: "Account Templates",
                    subtitle: "User profile and account management templates"
                )
                
                EmptyStateView(
                    title: "Template Gallery",
                    subtitle: "Account template examples will be displayed here",
                    icon: "person.fill"
                )
            }
            .padding()
        }
        .navigationTitle("Account Templates")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Previews
#Preview("Design System Browser") {
    DesignSystemBrowser()
}

#Preview("Dark Mode") {
    DesignSystemBrowser()
        .preferredColorScheme(.dark)
}

#Preview("Empty State") {
    DesignSystemBrowser()
        .environment(\.locale, Locale(identifier: "en"))
}
