//
//  b.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//

import SwiftUI
import TPEComponentSDK
import TPELoginSDK

struct LoginBottomSheetDetailView: View {
    @State private var selectedVariant: LoginBottomSheetVariant = .simple
    @State private var showBottomSheet: Bool = false
    @State private var customizationSettings = BottomSheetCustomizationSettings()
    @State private var loginResult: String = ""
    
    enum LoginBottomSheetVariant: String, CaseIterable, Identifiable {
        case simple = "Simple Login"
        case withIdCard = "With ID Card"
        case withRememberMe = "With Remember Me"
        
        var id: String { rawValue }
        
        var loginType: TPELoginBottomSheet.LoginType {
            switch self {
            case .simple: return .tl
            case .withIdCard: return .tw
            case .withRememberMe: return .tw
            }
        }
        
        var description: String {
            switch self {
            case .simple: return "Basic username/password login"
            case .withIdCard: return "Includes ID card field"
            case .withRememberMe: return "Includes remember me checkbox"
            }
        }
        
        var icon: String {
            switch self {
            case .simple: return "person.fill"
            case .withIdCard: return "person.badge.key"
            case .withRememberMe: return "checkmark.square"
            }
        }
    }
    
    struct BottomSheetCustomizationSettings {
        var title: String = "Login"
        var forgotPasswordText: String = "Forgot Username/Password?"
        var maximumInputChar: Int = 100
        var minimumUsernameLength: Int = 6
        var minimumPasswordLength: Int = 8
        var showForgotPassword: Bool = true
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Login Bottom Sheet",
                    subtitle: "Modal login forms with different configurations and validation"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Login Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(LoginBottomSheetVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(LoginBottomSheetVariant.allCases) { variant in
                            BottomSheetVariantCard(
                                variant: variant,
                                isSelected: selectedVariant == variant
                            ) {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedVariant = variant
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
                        
                        Button(action: { showBottomSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "play.fill")
                                Text("Show Bottom Sheet")
                            }
                            .font(.system(size: 14, weight: .medium))
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                    }
                    
                    previewCard
                }
                
                // Customization Panel
                customizationPanel
                
                // Login Results
                if !loginResult.isEmpty {
                    resultsSection
                }
                
                // Usage Guidelines
                usageGuidelines
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Login Bottom Sheet")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showBottomSheet) {
            TPELoginBottomSheet(
                isPresented: $showBottomSheet,
                loginType: selectedVariant.loginType,
                maximumInputChar: customizationSettings.maximumInputChar,
                minimumUsernameLength: customizationSettings.minimumUsernameLength,
                minimumPasswordLength: customizationSettings.minimumPasswordLength,
                onSaveSuccess: { data in
                    handleLoginSuccess(data)
                },
                onForgotPassword: customizationSettings.showForgotPassword ? {
                    handleForgotPassword()
                } : nil,
                titleText: customizationSettings.title,
                forgotPasswordText: customizationSettings.forgotPasswordText
            )
        }
    }
    
    // MARK: - Preview Card
    private var previewCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("Tap to preview")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text(selectedVariant.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Configuration summary
            VStack(alignment: .leading, spacing: 6) {
                ConfigurationRow(title: "Fields:", value: fieldSummary)
                ConfigurationRow(title: "Validation:", value: validationSummary)
                ConfigurationRow(title: "Options:", value: optionsSummary)
            }
            .font(.system(size: 12))
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        .onTapGesture {
            showBottomSheet = true
        }
    }
    
    private var fieldSummary: String {
        switch selectedVariant {
        case .simple: return "Username, Password"
        case .withIdCard: return "ID Card, Username, Password"
        case .withRememberMe: return "Username, Password, Remember Me"
        }
    }
    
    private var validationSummary: String {
        "\(customizationSettings.minimumUsernameLength)+ chars username, \(customizationSettings.minimumPasswordLength)+ chars password"
    }
    
    private var optionsSummary: String {
        customizationSettings.showForgotPassword ? "Forgot Password enabled" : "Basic login only"
    }
    
    // MARK: - Customization Panel
    private var customizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.blue)
                
                Text("Customization Options")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Reset") {
                    withAnimation {
                        customizationSettings = BottomSheetCustomizationSettings()
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
                    icon: "textformat",
                    title: "Content",
                    description: "Text and labels"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        CustomTextField("Title", text: $customizationSettings.title)
                        CustomTextField("Forgot Password Text", text: $customizationSettings.forgotPasswordText)
                        Toggle("Show Forgot Password", isOn: $customizationSettings.showForgotPassword)
                    }
                }
                
                CustomizationCard(
                    icon: "number",
                    title: "Validation",
                    description: "Input requirements"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Stepper("Min Username: \(customizationSettings.minimumUsernameLength)",
                               value: $customizationSettings.minimumUsernameLength, in: 3...20)
                        
                        Stepper("Min Password: \(customizationSettings.minimumPasswordLength)",
                               value: $customizationSettings.minimumPasswordLength, in: 6...50)
                        
                        Stepper("Max Input: \(customizationSettings.maximumInputChar)",
                               value: $customizationSettings.maximumInputChar, in: 50...500)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Results Section
    private var resultsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                
                Text("Login Results")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Clear") {
                    loginResult = ""
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            Text(loginResult)
                .font(.system(.caption, design: .monospaced))
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
    
    // MARK: - Usage Guidelines
    private var usageGuidelines: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "book.fill")
                    .foregroundColor(.blue)
                
                Text("Usage Guidelines")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                GuidelineCard(
                    icon: "1.circle.fill",
                    title: "Integration",
                    description: "Use .showTPELoginBottomSheet modifier"
                )
                
                GuidelineCard(
                    icon: "2.circle.fill",
                    title: "Variants",
                    description: "Choose between .tl (simple) and .tw (advanced)"
                )
                
                GuidelineCard(
                    icon: "3.circle.fill",
                    title: "Validation",
                    description: "Automatic form validation with custom rules"
                )
                
                GuidelineCard(
                    icon: "4.circle.fill",
                    title: "Customization",
                    description: "Flexible text, validation, and behavior options"
                )
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
                    .foregroundColor(.blue)
                
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
    @State private var showLoginSheet = false
    
    var body: some View {
        Button("Show Login") {
            showLoginSheet = true
        }
        .showTPELoginBottomSheet(
            isPresented: $showLoginSheet,
            loginType: .\(selectedVariant == .simple ? "tl" : "tw"),
            maximumInputChar: \(customizationSettings.maximumInputChar),
            minimumUsernameLength: \(customizationSettings.minimumUsernameLength),
            minimumPasswordLength: \(customizationSettings.minimumPasswordLength),
            onSaveSuccess: { data in
                // Handle login data
                print("Login data: \\(data)")
            },
            onForgotPassword: \(customizationSettings.showForgotPassword ? """
            {
                // Handle forgot password
                print("Forgot password tapped")
            }
            """ : "nil"),
            titleText: "\(customizationSettings.title)",
            forgotPasswordText: "\(customizationSettings.forgotPasswordText)"
        )
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func handleLoginSuccess(_ data: [String: Any]) {
        let formattedData = data.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
        loginResult = """
        Login Successful!
        
        Received Data:
        \(formattedData)
        
        Timestamp: \(Date().formatted())
        """
    }
    
    private func handleForgotPassword() {
        loginResult = """
        Forgot Password Flow Initiated
        
        This would typically:
        • Show password reset screen
        • Send reset instructions
        • Guide user through recovery process
        
        Timestamp: \(Date().formatted())
        """
    }
}

// MARK: - Supporting Views for Bottom Sheet Catalog

struct BottomSheetVariantCard: View {
    let variant: LoginBottomSheetDetailView.LoginBottomSheetVariant
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: variant.icon)
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .blue)
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
                
                // Features
                VStack(alignment: .leading, spacing: 4) {
                    FeatureTag(icon: "person.fill", text: "Username")
                    FeatureTag(icon: "lock.fill", text: "Password")
                    
                    if variant == .withIdCard {
                        FeatureTag(icon: "person.badge.key", text: "ID Card")
                    }
                    
                    if variant == .withRememberMe {
                        FeatureTag(icon: "checkmark.square", text: "Remember Me")
                    }
                }
            }
            .padding(16)
            .frame(height: 160)
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
        isSelected ? .blue : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .blue : Color.gray.opacity(0.2)
    }
}

struct FeatureTag: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 8))
                .foregroundColor(.secondary)
            
            Text(text)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(Color(.systemGray6))
        .cornerRadius(4)
    }
}

struct ConfigurationRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text(value)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}
