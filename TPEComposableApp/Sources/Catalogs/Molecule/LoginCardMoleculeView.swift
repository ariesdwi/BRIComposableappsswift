//
//  LoginCardMoleculeView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct LoginCardMoleculeView: View {
    @State private var actionLog: [String] = []
    @State private var cardHeight: CGFloat = 320
    @State private var titleText: String = "Welcome Back!"
    @State private var subtitleText: String = "Sign in to continue your journey with us"
    @State private var loginButtonText: String = "Sign In"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Login Card",
                    subtitle: "Beautiful login card with oval top shape and call-to-action buttons"
                )
                
                // Quick Stats
                statsOverview
                
                // Live Demo Section
                liveDemoSection
                
                // Customization Section
                customizationSection
                
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
        .navigationTitle("Login Card")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Stats Overview
    private var statsOverview: some View {
        HStack(spacing: 16) {
            StatBadge(
                count: "6",
                label: "Properties",
                icon: "slider.horizontal.3"
            )
            
            StatBadge(
                count: "\(LoginCard.PreviewData.allCases.count)",
                label: "Variants",
                icon: "rectangle.stack"
            )
            
            StatBadge(
                count: "100%",
                label: "Customizable",
                icon: "paintbrush",
                style: .success
            )
        }
    }
    
    // MARK: - Live Demo Section
    private var liveDemoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Interactive Demo",
                subtitle: "See the login card in action with different configurations",
                icon: "play.circle.fill"
            )
            
            ZStack {
                // Background color to show the card contrast
                Color.blue
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Live Preview
                    LoginCard(
                        title: titleText,
                        subtitle: subtitleText,
                        loginText: loginButtonText,
                        onLoginTap: {
                            logAction("Login button tapped")
                        },
                        onRegisterTap: {
                            logAction("Register link tapped")
                        },
                        cardHeight: cardHeight
                    )
                    .frame(height: 400)
                    
                    // Action Log
                    if !actionLog.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Action Log")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(Array(actionLog.prefix(3)), id: \.self) { log in
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
                            
                            if actionLog.count > 0 {
                                Button("Clear Log") {
                                    actionLog.removeAll()
                                }
                                .font(.caption)
                                .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(height: 500)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(16)
        }
    }
    
    // MARK: - Customization Section
    private var customizationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Customization",
                subtitle: "Adjust the card properties in real-time",
                icon: "slider.horizontal.3"
            )
            
            VStack(spacing: 16) {
                // Title Customization
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    TextField("Enter title", text: $titleText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Subtitle Customization
                VStack(alignment: .leading, spacing: 8) {
                    Text("Subtitle")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    TextField("Enter subtitle", text: $subtitleText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Button Text Customization
                VStack(alignment: .leading, spacing: 8) {
                    Text("Login Button Text")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    TextField("Enter button text", text: $loginButtonText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Card Height Slider
                VStack(alignment: .leading, spacing: 8) {
                    Text("Card Height: \(Int(cardHeight))")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Slider(value: $cardHeight, in: 280...400, step: 20)
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
                title: "Card Variants",
                subtitle: "Different configurations for various use cases",
                icon: "rectangle.3.group"
            )
            
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                ForEach(LoginCard.PreviewData.allCases, id: \.self) { variant in
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
                subtitle: "Implementation patterns for authentication flows",
                icon: "doc.text.magnifyingglass"
            )
            
            VStack(spacing: 16) {
                UsageExampleLoginCard(
                    scenario: "Basic Login",
                    description: "Standard login card with welcome message",
                    code: """
                    LoginCard(
                        title: "Welcome Back!",
                        subtitle: "Sign in to access your account",
                        loginText: "Sign In",
                        onLoginTap: {
                            // Handle login logic
                            viewModel.login()
                        },
                        onRegisterTap: {
                            // Navigate to registration
                            navigateToRegistration()
                        }
                    )
                    """,
                    variant: .standard
                )
                
                UsageExampleLoginCard(
                    scenario: "Custom Height",
                    description: "Taller card for more prominent display",
                    code: """
                    LoginCard(
                        title: "Welcome to Our App",
                        subtitle: "Join thousands of happy users",
                        loginText: "Get Started",
                        onLoginTap: handleLogin,
                        onRegisterTap: showRegistration,
                        cardHeight: 360
                    )
                    """,
                    variant: .tall
                )
                
                UsageExampleLoginCard(
                    scenario: "Branded Messaging",
                    description: "Customized text for specific brands",
                    code: """
                    LoginCard(
                        title: "Welcome to FinancePro",
                        subtitle: "Manage your finances securely",
                        loginText: "Access My Account",
                        onLoginTap: authenticateUser,
                        onRegisterTap: openSignupFlow
                    )
                    """,
                    variant: .branded
                )
            }
        }
    }
    
    // MARK: - Properties Section
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Properties",
                subtitle: "Configuration options for LoginCard",
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
                    description: "Main title text",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "text.cursor",
                    title: "subtitle",
                    value: "String",
                    description: "Secondary description text",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "button.programmable",
                    title: "loginText",
                    value: "String",
                    description: "Login button text",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "play.circle",
                    title: "onLoginTap",
                    value: "() -> Void",
                    description: "Login button action",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "play.circle",
                    title: "onRegisterTap",
                    value: "() -> Void",
                    description: "Register link action",
                    isRequired: true
                )
                
                PropertyCard(
                    icon: "ruler",
                    title: "cardHeight",
                    value: "CGFloat",
                    description: "Height of the card component"
                )
            }
        }
    }
    
    // MARK: - Helper Methods
    private func variantCard(for variant: LoginCard.PreviewData) -> some View {
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
            
            ZStack {
                variant.backgroundColor
                    .ignoresSafeArea()
                
                variant.preview
                    .frame(height: 200)
            }
            .frame(height: 200)
            .cornerRadius(12)
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
extension LoginCard {
    enum PreviewData: String, CaseIterable {
        case standard = "Standard Login"
        case tall = "Tall Card"
        case short = "Compact Card"
        case branded = "Branded Messaging"
        case minimal = "Minimal Design"
        
        var title: String {
            return rawValue
        }
        
        var description: String {
            switch self {
            case .standard:
                return "Standard login card with balanced proportions"
            case .tall:
                return "Taller card for more prominent display"
            case .short:
                return "Compact card for limited space"
            case .branded:
                return "Custom messaging for specific brands"
            case .minimal:
                return "Clean design with minimal text"
            }
        }
        
        var icon: String {
            switch self {
            case .standard: return "rectangle.fill"
            case .tall: return "rectangle.portrait.fill"
            case .short: return "rectangle.fill.on.rectangle.fill"
            case .branded: return "paintbrush.fill"
            case .minimal: return "minus.circle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .standard: return .blue
            case .tall: return .green
            case .short: return .orange
            case .branded: return .purple
            case .minimal: return .gray
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .standard: return .blue.opacity(0.1)
            case .tall: return .green.opacity(0.1)
            case .short: return .orange.opacity(0.1)
            case .branded: return .purple.opacity(0.1)
            case .minimal: return .gray.opacity(0.1)
            }
        }
        
        var complexity: String {
            switch self {
            case .standard, .minimal: return "Simple"
            case .tall, .short, .branded: return "Medium"
            }
        }
        
        @ViewBuilder
        var preview: some View {
            switch self {
            case .standard:
                LoginCard(
                    title: "Welcome Back!",
                    subtitle: "Sign in to continue your journey",
                    loginText: "Sign In",
                    onLoginTap: {},
                    onRegisterTap: {},
                    cardHeight: 320
                )
            case .tall:
                LoginCard(
                    title: "Welcome to Our Platform",
                    subtitle: "Access exclusive features and content",
                    loginText: "Get Started",
                    onLoginTap: {},
                    onRegisterTap: {},
                    cardHeight: 360
                )
            case .short:
                LoginCard(
                    title: "Hello!",
                    subtitle: "Please sign in",
                    loginText: "Login",
                    onLoginTap: {},
                    onRegisterTap: {},
                    cardHeight: 280
                )
            case .branded:
                LoginCard(
                    title: "FinancePro",
                    subtitle: "Secure financial management",
                    loginText: "Access Account",
                    onLoginTap: {},
                    onRegisterTap: {},
                    cardHeight: 320
                )
            case .minimal:
                LoginCard(
                    title: "Login",
                    subtitle: "Continue to app",
                    loginText: "Continue",
                    onLoginTap: {},
                    onRegisterTap: {},
                    cardHeight: 300
                )
            }
        }
    }
}

// MARK: - Supporting Components
struct UsageExampleLoginCard: View {
    let scenario: String
    let description: String
    let code: String
    let variant: LoginCard.PreviewData
    
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
                .frame(height: 140)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Previews
#Preview("Login Card Molecule View") {
    NavigationView {
        LoginCardMoleculeView()
    }
}

#Preview("Login Card Variants") {
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
            ForEach(LoginCard.PreviewData.allCases, id: \.self) { variant in
                VStack(alignment: .leading, spacing: 12) {
                    Text(variant.title)
                        .font(.headline)
                    
                    ZStack {
                        variant.backgroundColor
                        
                        variant.preview
                            .frame(height: 180)
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
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
