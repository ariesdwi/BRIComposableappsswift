//
//  MoleculeCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI
import TPEComponentSDK

struct MoleculeCatalogView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: MoleculeCategory = .all
    
    enum MoleculeCategory: String, CaseIterable, Identifiable, FilterCategory {
        case all = "All"
        case forms = "Forms"
        case navigation = "Navigation"
        case feedback = "Feedback"
        case layout = "Layout"
        case data = "Data Display"
        case actions = "Actions"
        
        var id: String { rawValue }
        var title: String { rawValue }
        
        var icon: String {
            switch self {
            case .all: return "square.grid.2x2"
            case .forms: return "square.and.pencil"
            case .navigation: return "arrow.triangle.turn.up.right.diamond"
            case .feedback: return "exclamationmark.circle"
            case .layout: return "rectangle.grid.2x2"
            case .data: return "list.bullet"
            case .actions: return "bolt"
            }
        }
    }
    
    // MARK: - Easy to Update Molecule List
    private let molecules: [MoleculeItem] = [
        // Forms Category
        .formField,
        .buttonGroup,
        .loginCard,
        .copyableField,
        .circleIconButton
    ]
    
    var filteredMolecules: [MoleculeItem] {
        let categoryFiltered = selectedCategory == .all ? molecules : molecules.filter { $0.category == selectedCategory }
        
        if searchText.isEmpty {
            return categoryFiltered
        } else {
            return categoryFiltered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText) ||
                $0.atomsUsed.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Molecules",
                    subtitle: "Simple combinations of atoms that form functional UI units"
                )
                
                // Search Bar
                SearchBar(text: $searchText, placeholder: "Search molecules...")
                
                // Category Filter
                CategoryFilter(
                    selectedCategory: $selectedCategory,
                    categories: MoleculeCategory.allCases
                )
                
                // Stats Overview
                statsOverview
                    .padding(.vertical, 8)
                
                // Molecules Grid
                if filteredMolecules.isEmpty {
                    EmptyStateView.noResults(query: searchText.isEmpty ? nil : searchText)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(filteredMolecules) { molecule in
                            MoleculeCard(item: molecule)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Molecules")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var statsOverview: some View {
        HStack(spacing: 16) {
            StatBadge(
                count: "\(molecules.count)",
                label: "Molecules",
                icon: "square.grid.2x2"
            )
            
            StatBadge(
                count: "\(Set(molecules.flatMap { $0.atomsUsed }).count)",
                label: "Atoms Used",
                icon: "atom"
            )
            
            StatBadge(
                count: "100%",
                label: "Reusable",
                icon: "arrow.triangle.merge"
            )
        }
    }
}

// MARK: - Molecule Item Model with Static Properties

struct MoleculeItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let category: MoleculeCatalogView.MoleculeCategory
    let destination: MoleculeDestination
    let atomsUsed: [String]
    let complexity: String
    
    // MARK: - Predefined Molecules - Easy to Add New Ones
    
    // Forms Category
    static let formField = MoleculeItem(
        title: "Form Field",
        subtitle: "Input fields with labels and validation",
        icon: "square.and.pencil",
        category: .forms,
        destination: .formField,
        atomsUsed: ["TPEText", "TPEInputField", "Icon"],
        complexity: "Simple"
    )
    
    static let buttonGroup = MoleculeItem(
        title: "Button Group",
        subtitle: "Related action buttons in a group",
        icon: "square.grid.2x2.fill",
        category: .forms,
        destination: .buttonGroup,
        atomsUsed: ["TPEButton", "Spacer"],
        complexity: "Medium"
    )
    
    // Navigation Category
    static let cardHeader = MoleculeItem(
        title: "Card Header",
        subtitle: "Card titles with actions and metadata",
        icon: "rectangle.fill",
        category: .navigation,
        destination: .cardHeader,
        atomsUsed: ["TPEText", "TPEButton", "Icon", "Spacer"],
        complexity: "Medium"
    )
    
    static let infoRow = MoleculeItem(
        title: "Info Row",
        subtitle: "Key-value information displays",
        icon: "list.bullet",
        category: .navigation,
        destination: .infoRow,
        atomsUsed: ["TPEText", "Icon", "Spacer"],
        complexity: "Simple"
    )
    
    // Feedback Category
    static let loadingIndicator = MoleculeItem(
        title: "Loading Indicator",
        subtitle: "Progress and loading states",
        icon: "arrow.2.circlepath",
        category: .feedback,
        destination: .loadingIndicator,
        atomsUsed: ["ProgressView", "TPEText", "Spacer"],
        complexity: "Medium"
    )
    
    // Data Display Category
    static let statCard = MoleculeItem(
        title: "Stat Card",
        subtitle: "Metrics and statistics display",
        icon: "chart.bar",
        category: .data,
        destination: .statCard,
        atomsUsed: ["TPEText", "Icon", "Spacer"],
        complexity: "Medium"
    )
    
    static let loginCard = MoleculeItem(
        title: "Login Card",
        subtitle: "Complete login form with validation",
        icon: "person.crop.circle",
        category: .data,
        destination: .loginCard,
        atomsUsed: ["TPEText", "TPEInputField", "TPEButton", "TPEEyeToggleButton"],
        complexity: "Complex"
    )
    
    // Actions Category
    static let copyableField = MoleculeItem(
        title: "Copyable Field",
        subtitle: "Text fields with copy functionality",
        icon: "doc.on.doc",
        category: .actions,
        destination: .copyableField,
        atomsUsed: ["TPEInputField", "TPECopyButton", "Spacer"],
        complexity: "Simple"
    )
    
    static let circleIconButton = MoleculeItem(
        title: "TPECircleIconButton",
        subtitle: "Circular icon buttons with badges",
        icon: "circle.circle",
        category: .actions,
        destination: .circleIconButton,
        atomsUsed: ["TPECircleIconButton", "TPEButton", "Spacer"],
        complexity: "Medium"
    )
    
    // MARK: - Destination Enum
    enum MoleculeDestination {
        case formField
        case buttonGroup
        case cardHeader
        case infoRow
        case loadingIndicator
        case statCard
        case loginCard
        case copyableField
        case circleIconButton
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .formField:
                FormFieldMoleculeView()
            case .buttonGroup:
                ButtonGroupMoleculeView()
            case .cardHeader:
                CardHeaderMoleculeView()
            case .infoRow:
                InfoRowMoleculeView()
            case .loadingIndicator:
                LoadingIndicatorMoleculeView()
            case .statCard:
                StatCardMoleculeView()
            case .loginCard:
                LoginCardMoleculeView()
            case .copyableField:
                TPECopyButtonCatalogView()
            case .circleIconButton:
                TPECircleIconButtonCatalogView()
            }
        }
    }
}

struct MoleculeCard: View {
    let item: MoleculeItem
    
    var body: some View {
        NavigationLink(destination: item.destination.view) {
            VStack(alignment: .leading, spacing: 12) {
                // Icon and Header
                HStack(alignment: .top) {
                    ZStack {
                        Circle()
                            .fill(item.category.color.opacity(0.1))
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: item.icon)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(item.category.color)
                            .symbolRenderingMode(.hierarchical)
                    }
                    
                    Spacer()
                    
                    ComplexityBadge(complexity: item.complexity)
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
                
                // Atoms Used
                VStack(alignment: .leading, spacing: 8) {
                    Text("Atoms Used")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(Array(item.atomsUsed.prefix(3)), id: \.self) { atom in
                                AtomChip(name: atom)
                            }
                            
                            if item.atomsUsed.count > 3 {
                                Text("+\(item.atomsUsed.count - 3)")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                
                // Footer
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
            .frame(height: 200)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ComplexityBadge: View {
    let complexity: String
    
    private var color: Color {
        switch complexity {
        case "Simple": return .green
        case "Medium": return .orange
        case "Complex": return .red
        default: return .gray
        }
    }
    
    private var icon: String {
        switch complexity {
        case "Simple": return "1.circle"
        case "Medium": return "2.circle"
        case "Complex": return "3.circle"
        default: return "questionmark.circle"
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            
            Text(complexity)
                .font(.system(size: 11, weight: .medium))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color)
        .cornerRadius(6)
    }
}

struct AtomChip: View {
    let name: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "atom")
                .font(.system(size: 8))
                .foregroundColor(.blue)

            Text(name)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

extension MoleculeCatalogView.MoleculeCategory {
    var color: Color {
        switch self {
        case .all: return .blue
        case .forms: return .green
        case .navigation: return .indigo
        case .feedback: return .orange
        case .layout: return .purple
        case .data: return .teal
        case .actions: return .blue
        }
    }
}
