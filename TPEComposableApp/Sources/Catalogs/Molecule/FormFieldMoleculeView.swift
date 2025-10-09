//
//  Untitled.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct FormFieldMoleculeView: View {
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var usernameText: String = ""
    @State private var phoneText: String = ""
    @State private var customText: String = ""
    
    @State private var showError: Bool = false
    @State private var isEnabled: Bool = true
    @State private var showIcon: Bool = true
    @State private var isSecure: Bool = false
    @State private var actionLog: [String] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Form Field",
                    subtitle: "Input fields with labels, validation, and various input types"
                )
                
                // Quick Stats
                statsOverview
                
                // Live Demo Section
                liveDemoSection
                
                // Pre-built Fields Section
                prebuiltFieldsSection
                
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
        .navigationTitle("Form Field")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Stats Overview
    private var statsOverview: some View {
        HStack(spacing: 16) {
            StatBadge(
                count: "15+",
                label: "Options",
                icon: "slider.horizontal.3"
            )
            
            StatBadge(
                count: "\(FormFieldMolecule.PreviewData.allCases.count)",
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
                subtitle: "Test the form field with different configurations",
                icon: "play.circle.fill"
            )
            
            VStack(spacing: 20) {
                // Demo Controls
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    Toggle("Show Icon", isOn: $showIcon)
                    Toggle("Show Error", isOn: $showError)
                    Toggle("Is Enabled", isOn: $isEnabled)
                    Toggle("Secure Text", isOn: $isSecure)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                // Live Preview
                FormFieldMolecule(
                    title: "Custom Field",
                    subtitle: "Try typing something here",
                    placeholder: "Enter your text...",
                    icon: showIcon ? "pencil.circle.fill" : nil,
                    isSecure: isSecure,
                    showError: showError,
                    errorMessage: showError ? "This field is required" : nil,
                    isEnabled: isEnabled,
                    trailingIcon: "xmark.circle.fill",
                    onTrailingIconTap: {
                        customText = ""
                        logAction("Clear button tapped")
                    },
                    text: $customText
                )
                
                // Current Value Display
                if !customText.isEmpty {
                    HStack {
                        Text("Current value:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(customText)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(6)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
    }
    
    // MARK: - Pre-built Fields Section
    private var prebuiltFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Pre-built Fields",
                subtitle: "Specialized form fields for common use cases",
                icon: "square.grid.2x2"
            )
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                FormFieldMolecule.email(
                    title: "Email Address",
                    subtitle: "We'll never share your email",
                    text: $emailText
                )
                
                FormFieldMolecule.password(
                    title: "Password",
                    text: $passwordText
                )
                
                FormFieldMolecule.username(
                    title: "Username",
                    text: $usernameText
                )
                
                FormFieldMolecule.phone(
                    title: "Phone Number",
                    text: $phoneText
                )
            }
        }
    }
    
    // MARK: - Variants Section
    private var variantsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Field Variants",
                subtitle: "Different states and configurations of form fields",
                icon: "rectangle.3.group"
            )
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                ForEach(FormFieldMolecule.PreviewData.allCases, id: \.self) { variant in
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
                    scenario: "Email Field",
                    description: "Specialized email input with validation",
                    code: """
                    FormFieldMolecule.email(
                        title: "Email Address",
                        subtitle: "We'll never share your email",
                        text: $email
                    )
                    """,
                    variant: .simple
                )
                
                UsageExampleCard(
                    scenario: "Password with Validation",
                    description: "Secure field with error states",
                    code: """
                    FormFieldMolecule(
                        title: "Password",
                        placeholder: "Enter your password",
                        icon: "lock.fill",
                        isSecure: true,
                        showError: !isPasswordValid,
                        errorMessage: "Password must be 8+ characters",
                        textContentType: .password,
                        text: $password
                    )
                    """,
                    variant: .simple
                )
                
                UsageExampleCard(
                    scenario: "Disabled Field",
                    description: "Read-only or inactive field state",
                    code: """
                    FormFieldMolecule(
                        title: "Account ID",
                        subtitle: "Cannot be changed",
                        placeholder: "ACC-12345",
                        icon: "number.circle",
                        isEnabled: false,
                        text: $accountId
                    )
                    """,
                    variant: .disabled
                )
            }
        }
    }
    
    // MARK: - Properties Section
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Properties",
                subtitle: "Configuration options for FormFieldMolecule",
                icon: "list.bullet.rectangle"
            )
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                PropertyCard(
                    icon: "text.cursor",
                    title: "title",
                    value: "String",
                    description: "Primary field label",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "subtitle",
                    value: "String?",
                    description: "Optional secondary text"
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "placeholder",
                    value: "String",
                    description: "Placeholder text"
                )
                
                PropertyCard(
                    icon: "icon.circle",
                    title: "icon",
                    value: "String?",
                    description: "Optional leading icon"
                )
                
                PropertyCard(
                    icon: "eye.slash",
                    title: "isSecure",
                    value: "Bool",
                    description: "Secure text entry"
                )
                
                PropertyCard(
                    icon: "exclamationmark.triangle",
                    title: "showError",
                    value: "Bool",
                    description: "Show error state"
                )
                
                PropertyCard(
                    icon: "checkmark.circle",
                    title: "isEnabled",
                    value: "Bool",
                    description: "Field enabled state"
                )
                
                PropertyCard(
                    icon: "keyboard",
                    title: "keyboardType",
                    value: "UIKeyboardType",
                    description: "Keyboard type"
                )
                
                PropertyCard(
                    icon: "textformat",
                    title: "textContentType",
                    value: "UITextContentType?",
                    description: "Content type for autofill"
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "text",
                    value: "Binding<String>",
                    description: "Text binding",
                    isRequired: true
                )
            }
        }
    }
    
    // MARK: - Helper Methods
    private func variantCard(for variant: FormFieldMolecule.PreviewData) -> some View {
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
extension FormFieldMolecule {
    enum PreviewData: String, CaseIterable {
        case email = "Email Field"
        case password = "Password Field"
        case error = "Error State"
        case disabled = "Disabled State"
        case withSubtitle = "With Subtitle"
        case withTrailing = "With Trailing Icon"
        
        var title: String {
            return rawValue
        }
        
        var description: String {
            switch self {
            case .email:
                return "Email input with proper keyboard and validation"
            case .password:
                return "Secure password field with visibility toggle"
            case .error:
                return "Field showing validation error state"
            case .disabled:
                return "Disabled read-only field state"
            case .withSubtitle:
                return "Field with additional descriptive text"
            case .withTrailing:
                return "Field with trailing action icon"
            }
        }
        
        var icon: String {
            switch self {
            case .email: return "envelope.fill"
            case .password: return "lock.fill"
            case .error: return "exclamationmark.triangle.fill"
            case .disabled: return "slash.circle"
            case .withSubtitle: return "text.bubble"
            case .withTrailing: return "ellipsis.circle"
            }
        }
        
        var color: Color {
            switch self {
            case .email: return .blue
            case .password: return .green
            case .error: return .red
            case .disabled: return .gray
            case .withSubtitle: return .orange
            case .withTrailing: return .purple
            }
        }
        
        var complexity: String {
            switch self {
            case .email, .password, .withSubtitle: return "Simple"
            case .error, .disabled, .withTrailing: return "Medium"
            }
        }
        
        @ViewBuilder
        var preview: some View {
            switch self {
            case .email:
                FormFieldMolecule.email(
                    title: "Email Address",
                    placeholder: "user@example.com"
                )
            case .password:
                FormFieldMolecule.password(
                    title: "Password",
                    placeholder: "Enter your password"
                )
            case .error:
                FormFieldMolecule(
                    title: "Username",
                    placeholder: "Enter username",
                    icon: "person.fill",
                    showError: true,
                    errorMessage: "Username already taken",
                    text: .constant("")
                )
            case .disabled:
                FormFieldMolecule(
                    title: "Account Type",
                    subtitle: "Cannot be changed",
                    placeholder: "Premium",
                    icon: "person.circle",
                    isEnabled: false,
                    text: .constant("Premium")
                )
            case .withSubtitle:
                FormFieldMolecule(
                    title: "Full Name",
                    subtitle: "As shown on your government ID",
                    placeholder: "John Appleseed",
                    icon: "person.fill",
                    text: .constant("")
                )
            case .withTrailing:
                FormFieldMolecule(
                    title: "Search",
                    placeholder: "Search...",
                    icon: "magnifyingglass",
                    trailingIcon: "xmark.circle.fill",
                    onTrailingIconTap: {},
                    text: .constant("Search query")
                )
            }
        }
    }
}


// MARK: - Previews
#Preview("Form Field Molecule View") {
    NavigationView {
        FormFieldMoleculeView()
    }
}

#Preview("Form Field Variants") {
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
            ForEach(FormFieldMolecule.PreviewData.allCases, id: \.self) { variant in
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
