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
    @State private var selectedLoginVariant: LoginVariant = .default
    @State private var showLiveDemo: Bool = false
    @State private var customizationSettings = LoginCustomizationSettings()
    @State private var isLoggedIn: Bool = false
    
    enum LoginVariant: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case withBackground = "With Background"
        case tallCard = "Tall Card"
        case compact = "Compact"
        case minimal = "Minimal"
        case branded = "Branded"
        
        var id: String { rawValue }
        
        var config: LoginConfig {
            switch self {
            case .default:
                return LoginConfig(
                    title: "Welcome to TPE",
                    subtitle: "Sign in to access your account and manage your profile",
                    loginText: "Sign In"
                )
            case .withBackground:
                return LoginConfig(
                    backgroundUrl: "https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=1374&q=80",
                    title: "Welcome Back",
                    subtitle: "Continue your journey with our platform",
                    loginText: "Continue"
                )
            case .tallCard:
                return LoginConfig(
                    title: "Get Started",
                    subtitle: "Join thousands of users already using our services to enhance their productivity",
                    loginText: "Create Account"
                )
            case .compact:
                return LoginConfig(
                    title: "Sign In",
                    subtitle: "Access your dashboard",
                    loginText: "Login"
                )
            case .minimal:
                return LoginConfig(
                    title: "TPE",
                    subtitle: "Enterprise Design System",
                    loginText: "Get Started"
                )
            case .branded:
                return LoginConfig(
                    backgroundUrl: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=1470&q=80",
                    title: "Enterprise Portal",
                    subtitle: "Secure access to your organization's resources",
                    loginText: "Access Portal"
                )
            }
        }
        
        var cardHeight: CGFloat {
            switch self {
            case .default: return 320
            case .withBackground: return 350
            case .tallCard: return 420
            case .compact: return 280
            case .minimal: return 240
            case .branded: return 380
            }
        }
        
        var icon: String {
            switch self {
            case .default: return "rectangle.fill"
            case .withBackground: return "photo.fill"
            case .tallCard: return "rectangle.portrait.fill"
            case .compact: return "rectangle.compress.vertical"
            case .minimal: return "minus"
            case .branded: return "building.2.fill"
            }
        }
        
        var description: String {
            switch self {
            case .default: return "Standard layout with balanced spacing"
            case .withBackground: return "Full background image with overlay card"
            case .tallCard: return "Extended height for more content space"
            case .compact: return "Minimal layout for quick authentication"
            case .minimal: return "Ultra clean and simple design"
            case .branded: return "Corporate branding with professional imagery"
            }
        }
        
        var complexity: String {
            switch self {
            case .default, .compact, .minimal: return "Simple"
            case .withBackground, .branded: return "Medium"
            case .tallCard: return "Complex"
            }
        }
    }
    
    struct LoginCustomizationSettings {
        var cardHeight: CGFloat = 320
        var showBackgroundImage: Bool = true
        var title: String = "Welcome to TPE"
        var subtitle: String = "Sign in to access your account"
        var buttonText: String = "Sign In"
        var backgroundColor: Color = TPEColors.blue70
        var showRegisterLink: Bool = true
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Login Organism",
                    subtitle: "Complete authentication templates built with Atomic Design principles"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Template Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(LoginVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(LoginVariant.allCases) { variant in
                                LoginVariantCard(
                                    variant: variant,
                                    isSelected: selectedLoginVariant == variant
                                ) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedLoginVariant = variant
                                        updateCustomizationSettings(for: variant)
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
                        
                        Button(action: { showLiveDemo = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "play.fill")
                                Text("Full Screen Demo")
                            }
                            .font(.system(size: 14, weight: .medium))
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                    }
                    
                    previewContainer
                }
                
                // Customization Panel
                customizationPanel
                
                // Usage Guidelines
                usageGuidelines
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Login Organism")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showLiveDemo) {
            LiveLoginDemo(
                variant: selectedLoginVariant,
                settings: customizationSettings
            )
        }
    }
    
    // MARK: - Preview Container
    private var previewContainer: some View {
        ZStack {
            // Preview with interactive overlay
            TPEOrganizmLoginTL(
                config: selectedLoginVariant.config,
                cardHeight: selectedLoginVariant.cardHeight,
                onLoginSuccess: {
                    withAnimation(.spring()) {
                        isLoggedIn = true
                    }
                    
                    // Reset after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.spring()) {
                            isLoggedIn = false
                        }
                    }
                },
                onRegisterSuccess: {
                    // Handle registration
                    print("Registration flow initiated")
                }
            )
            .frame(height: 500)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            
            // Success overlay
            if isLoggedIn {
                SuccessOverlay()
            }
            
            // Preview indicator
            VStack {
                HStack {
                    Text("LIVE PREVIEW")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .cornerRadius(4)
                    Spacer()
                }
                .padding(12)
                Spacer()
            }
        }
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
                        customizationSettings = LoginCustomizationSettings()
                        updateCustomizationSettings(for: selectedLoginVariant)
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
                        CustomTextField("Subtitle", text: $customizationSettings.subtitle)
                        CustomTextField("Button Text", text: $customizationSettings.buttonText)
                    }
                }
                
                CustomizationCard(
                    icon: "paintbrush",
                    title: "Appearance",
                    description: "Visual styling"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Background Image", isOn: $customizationSettings.showBackgroundImage)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Height: \(Int(customizationSettings.cardHeight))pt")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(
                                value: $customizationSettings.cardHeight,
                                in: 240...500,
                                step: 20
                            )
                        }
                        
                        Toggle("Show Register Link", isOn: $customizationSettings.showRegisterLink)
                    }
                }
            }
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
                    title: "Implementation",
                    description: "Import TPELoginSDK and use TPEOrganizmLoginTL"
                )
                
                GuidelineCard(
                    icon: "2.circle.fill",
                    title: "Customization",
                    description: "Modify LoginConfig for different variants"
                )
                
                GuidelineCard(
                    icon: "3.circle.fill",
                    title: "Handlers",
                    description: "Implement onLoginSuccess and onRegisterSuccess"
                )
                
                GuidelineCard(
                    icon: "4.circle.fill",
                    title: "Integration",
                    description: "Works with any SwiftUI navigation pattern"
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
                    // Copy code to clipboard
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
import TPELoginSDK

struct ContentView: View {
    @State private var showLogin = false
    
    var body: some View {
        Button("Show Login") {
            showLogin = true
        }
        .fullScreenCover(isPresented: $showLogin) {
            TPEOrganizmLoginTL(
                config: LoginConfig(
                    backgroundUrl: "\(selectedLoginVariant.config.backgroundUrl ?? "nil")",
                    title: "\(customizationSettings.title)",
                    subtitle: "\(customizationSettings.subtitle)",
                    loginText: "\(customizationSettings.buttonText)"
                ),
                cardHeight: \(Int(customizationSettings.cardHeight)),
                onLoginSuccess: {
                    // Handle successful login
                    showLogin = false
                },
                onRegisterSuccess: {
                    // Handle registration flow
                }
            )
        }
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func updateCustomizationSettings(for variant: LoginVariant) {
        customizationSettings.cardHeight = variant.cardHeight
        customizationSettings.title = variant.config.title
        customizationSettings.subtitle = variant.config.subtitle
        customizationSettings.buttonText = variant.config.loginText
        customizationSettings.showBackgroundImage = variant.config.backgroundUrl != nil
    }
}

// MARK: - Supporting Views

struct LoginVariantCard: View {
    let variant: OrganismCatalogView.LoginVariant
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
                
                HStack {
                    Text(variant.complexity)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(isSelected ? .white : .secondary)
                    
                    Spacer()
                    
                    Text("\(Int(variant.cardHeight))pt")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(isSelected ? .white : .blue)
                }
            }
            .padding(16)
            .frame(width: 160, height: 140)
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

struct SuccessOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.green)
                
                Text("Login Successful!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Redirecting to dashboard...")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .cornerRadius(16)
    }
}

struct CustomizationCard<Content: View>: View {
    let icon: String
    let title: String
    let description: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 14))
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
            }
            
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            
            content()
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 14))
        }
    }
}

struct GuidelineCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
            }
            
            Text(description)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct CodeBlock: View {
    let code: String
    
    var body: some View {
        ScrollView {
            Text(code)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.primary)
                .padding()
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// MARK: - Live Demo View
struct LiveLoginDemo: View {
    let variant: OrganismCatalogView.LoginVariant
    let settings: OrganismCatalogView.LoginCustomizationSettings
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            TPEOrganizmLoginTL(
                config: LoginConfig(
                    backgroundUrl: settings.showBackgroundImage ? variant.config.backgroundUrl : nil,
                    title: settings.title,
                    subtitle: settings.subtitle,
                    loginText: settings.buttonText
                ),
                cardHeight: settings.cardHeight,
                onLoginSuccess: {
                    dismiss()
                },
                onRegisterSuccess: {
                    // Handle registration
                }
            )
            .ignoresSafeArea()
            
            // Close button
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .padding(.top, 60)
                    .padding(.trailing, 20)
                }
                
                Spacer()
            }
        }
        .statusBar(hidden: true)
    }
}

//// MARK: - Previews
//#Preview("Organism Catalog") {
//    NavigationView {
//        OrganismCatalogView()
//    }
//}

