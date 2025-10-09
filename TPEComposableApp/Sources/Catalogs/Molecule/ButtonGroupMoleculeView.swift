//
//  ButtonGroupMoleculeView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//


import SwiftUI
import TPEComponentSDK

struct ButtonGroupMoleculeView: View {
    @State private var isPrimaryEnabled: Bool = true
    @State private var showTertiaryButton: Bool = false
    @State private var actionLog: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Button Group",
                    subtitle: "Related action buttons in a group for cohesive user interactions"
                )
                
                // Quick Stats
                statsOverview
                
                // Live Demo Section
                liveDemoSection
                
                // Variants Section
                variantsSection
                
                // Usage Examples
                usageExamplesSection
                
                // Properties Documentation
                propertiesSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Button Group")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Stats Overview
    private var statsOverview: some View {
        HStack(spacing: 16) {
            StatBadge(
                count: "2-3",
                label: "Buttons",
                icon: "square.grid.2x2"
            )
            
            StatBadge(
                count: "\(ButtonGroupMolecule.PreviewData.allCases.count)",
                label: "Variants",
                icon: "rectangle.stack"
            )
            
            StatBadge(
                count: "100%",
                label: "Accessible",
                icon: "accessibility",
                style: .success
            )
        }
    }
    
    // MARK: - Live Demo Section
    private var liveDemoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Interactive Demo",
                subtitle: "Test the button group with different configurations",
                icon: "play.circle.fill"
            )
            
            VStack(spacing: 20) {
                // Demo Controls
                HStack {
                    Toggle("Primary Enabled", isOn: $isPrimaryEnabled)
                    Toggle("Tertiary Button", isOn: $showTertiaryButton)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                // Live Preview
                ButtonGroupMolecule(
                    primaryTitle: "Save Changes",
                    secondaryTitle: "Cancel",
                    tertiaryTitle: showTertiaryButton ? "Help" : nil,
                    isPrimaryEnabled: isPrimaryEnabled,
                    primaryAction: { logAction("Primary: Save Changes tapped") },
                    secondaryAction: { logAction("Secondary: Cancel tapped") },
                    tertiaryAction: showTertiaryButton ? { logAction("Tertiary: Help tapped") } : nil
                )
                
                // Action Log
                if !actionLog.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Action Log")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(Array(actionLog.prefix(5)), id: \.self) { log in
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.green)
                                    
                                    Text(log)
                                        .font(.system(size: 14, design: .monospaced))
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding(12)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        
                        if actionLog.count > 5 {
                            Text("... and \(actionLog.count - 5) more actions")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if actionLog.count > 0 {
                            Button("Clear Log") {
                                actionLog.removeAll()
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
    
    // MARK: - Variants Section
    private var variantsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Common Variants",
                subtitle: "Pre-configured button group patterns for different use cases",
                icon: "rectangle.3.group"
            )
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                ForEach(ButtonGroupMolecule.PreviewData.allCases, id: \.self) { variant in
                    variantCard(for: variant)
                }
            }
        }
    }
    
    // MARK: - Usage Examples Section
    private var usageExamplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Usage Examples",
                subtitle: "Implementation patterns for common scenarios",
                icon: "doc.text.magnifyingglass"
            )
            
            VStack(spacing: 16) {
                UsageExampleCard(
                    scenario: "Form Actions",
                    description: "Save or cancel form changes with optional help",
                    code: """
                    ButtonGroupMolecule(
                        primaryTitle: "Save Changes",
                        secondaryTitle: "Cancel",
                        tertiaryTitle: "Help",
                        isPrimaryEnabled: isFormValid,
                        primaryAction: saveForm,
                        secondaryAction: cancelForm,
                        tertiaryAction: showHelp
                    )
                    """,
                    variant: .formActions
                )
                
                UsageExampleCard(
                    scenario: "Confirmation Dialog",
                    description: "Confirm or dismiss important actions",
                    code: """
                    ButtonGroupMolecule(
                        primaryTitle: "Delete",
                        secondaryTitle: "Keep",
                        isPrimaryEnabled: true,
                        primaryAction: confirmDelete,
                        secondaryAction: cancelDelete
                    )
                    """,
                    variant: .confirmation
                )
                
                UsageExampleCard(
                    scenario: "Simple Actions",
                    description: "Basic primary and secondary actions",
                    code: """
                    ButtonGroupMolecule(
                        primaryTitle: "Continue",
                        secondaryTitle: "Back",
                        primaryAction: navigateForward,
                        secondaryAction: navigateBack
                    )
                    """,
                    variant: .simple
                )
            }
        }
    }
    
    // MARK: - Properties Section
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Properties",
                subtitle: "Configuration options for ButtonGroupMolecule",
                icon: "list.bullet.rectangle"
            )
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                PropertyCard(
                    icon: "text.cursor",
                    title: "primaryTitle",
                    value: "String",
                    description: "Main action button text"
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "secondaryTitle",
                    value: "String?",
                    description: "Optional secondary button text"
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "tertiaryTitle",
                    value: "String?",
                    description: "Optional tertiary button text"
                )
                
                PropertyCard(
                    icon: "checkmark.circle",
                    title: "isPrimaryEnabled",
                    value: "Bool",
                    description: "Primary button enabled state"
                )
                
                PropertyCard(
                    icon: "play.circle",
                    title: "primaryAction",
                    value: "() -> Void",
                    description: "Primary button action handler"
                )
                
                PropertyCard(
                    icon: "play.circle",
                    title: "secondaryAction",
                    value: "(() -> Void)?",
                    description: "Optional secondary action"
                )
            }
        }
    }
    
    // MARK: - Helper Methods
    private func variantCard(for variant: ButtonGroupMolecule.PreviewData) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: variant.icon)
                    .font(.system(size: 16))
                    .foregroundColor(variant.color)
                
                Text(variant.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                ComplexityBadge(complexity: variant.complexity)
            }
            
            Text(variant.description)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            variant.preview
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private func logAction(_ message: String) {
        let timestamp = Date().formatted(date: .omitted, time: .standard)
        actionLog.insert("[\(timestamp)] \(message)", at: 0)
    }
}

// MARK: - Preview Data Extension
extension ButtonGroupMolecule {
    enum PreviewData: String, CaseIterable {
        case simple = "Simple Actions"
        case formActions = "Form Actions"
        case confirmation = "Confirmation"
        case disabled = "Disabled State"
        
        var title: String {
            return rawValue
        }
        
        var description: String {
            switch self {
            case .simple:
                return "Basic primary and secondary actions"
            case .formActions:
                return "Form submission with multiple options"
            case .confirmation:
                return "Destructive actions with confirmation"
            case .disabled:
                return "Primary action disabled state"
            }
        }
        
        var icon: String {
            switch self {
            case .simple: return "arrow.left.arrow.right"
            case .formActions: return "square.and.pencil"
            case .confirmation: return "exclamationmark.triangle"
            case .disabled: return "slash.circle"
            }
        }
        
        var color: Color {
            switch self {
            case .simple: return .blue
            case .formActions: return .green
            case .confirmation: return .orange
            case .disabled: return .gray
            }
        }
        
        var complexity: String {
            switch self {
            case .simple, .disabled: return "Simple"
            case .formActions, .confirmation: return "Medium"
            }
        }
        
        @ViewBuilder
        var preview: some View {
            switch self {
            case .simple:
                ButtonGroupMolecule(
                    primaryTitle: "Continue",
                    secondaryTitle: "Back",
                    primaryAction: {},
                    secondaryAction: {}
                )
            case .formActions:
                ButtonGroupMolecule(
                    primaryTitle: "Save Changes",
                    secondaryTitle: "Cancel",
                    tertiaryTitle: "Help",
                    primaryAction: {},
                    secondaryAction: {},
                    tertiaryAction: {}
                )
            case .confirmation:
                ButtonGroupMolecule(
                    primaryTitle: "Delete",
                    secondaryTitle: "Cancel",
                    primaryAction: {},
                    secondaryAction: {}
                )
            case .disabled:
                ButtonGroupMolecule(
                    primaryTitle: "Submit",
                    secondaryTitle: "Cancel",
                    isPrimaryEnabled: false,
                    primaryAction: {},
                    secondaryAction: {}
                )
            }
        }
    }
}

// MARK: - Supporting Components
struct UsageExampleCard: View {
    let scenario: String
    let description: String
    let code: String
    let variant: ButtonGroupMolecule.PreviewData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: variant.icon)
                    .font(.system(size: 14))
                    .foregroundColor(variant.color)
                
                Text(scenario)
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
            }
            
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            CodeBlock(code: code)
                .frame(height: 100)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Previews
#Preview("Button Group Molecule View") {
    NavigationView {
        ButtonGroupMoleculeView()
    }
}

#Preview("Button Group Variants") {
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
            ForEach(ButtonGroupMolecule.PreviewData.allCases, id: \.self) { variant in
                VStack(alignment: .leading, spacing: 12) {
                    Text(variant.title)
                        .font(.headline)
                    variant.preview
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
            }
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
