
//
//  LoginTemplateCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI
import TPELoginSDK
import TPEComponentSDK

struct LoginTemplateCatalogView: View {
    @State private var selectedTemplate: LoginTemplate = .default
    @State private var showLiveDemo: Bool = false
    @State private var customization = LoginCustomization()
    @State private var isLoggedIn: Bool = false
    @State private var showLoginBottomSheet: Bool = false
    
    enum LoginTemplate: String, CaseIterable, Identifiable {
        case `default` = "Standard"
        
        var id: String { rawValue }
        
        var config: LoginConfig {
            switch self {
            case .default:
                return LoginConfig(
                    title: "Your Financial Partner On The Go!",
                    subtitle: "BRImo Timor-Leste is your go-to solution for hassle-free banking. Make your transaction always simple, always accessible.",
                    loginText: "Login"
                )
            }
        }
        
        var cardHeight: CGFloat {
            switch self {
            case .default: return 340
            }
        }
        
        var icon: String {
            switch self {
            case .default: return "rectangle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .default: return .blue
            }
        }
        
        var description: String {
            switch self {
            case .default: return "Clean and professional design"
            }
        }
    }
    
    struct LoginCustomization {
        var cardHeight: CGFloat = 340
        var showBackgroundImage: Bool = true
        var title: String = "Your Financial Partner On The Go!"
        var subtitle: String = "BRImo Timor-Leste is your go-to solution for hassle-free banking. Make your transaction always simple, always accessible."
        var buttonText: String = "Login"
        var showRegisterLink: Bool = true
        var backgroundColor: Color = TPEColors.primaryBlue
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                // Header Section
                headerSection
                    .padding(.bottom, 32)
                
                // Live Preview
                previewSection
                    .padding(.bottom, 32)
                
                // Customization Options
                customizationSection
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Login Template")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showLiveDemo) {
            FullScreenLoginDemo(
                template: selectedTemplate,
                customization: customization
            )
        }
        .sheet(isPresented: $showLoginBottomSheet) {
            TPELoginBottomSheet(
                isPresented: $showLoginBottomSheet,
                loginType: .tl,
                onSaveSuccess: { data in
                    // Handle successful login from bottom sheet
                    handleLoginSuccess(data)
                },
                onForgotPassword: {
                    // Handle forgot password
                    print("Forgot password tapped")
                },
                titleText: "Sign In",
                forgotPasswordText: "Forgot Username/Password?"
            )
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Login Template")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Ready-to-use authentication screen built with TPE Design System")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    StatBadge(count: "1", label: "Template")
                    StatBadge(count: "100%", label: "SwiftUI")
                    StatBadge(count: "Atomic", label: "Design")
                }
            }
            
            // Quick Actions
            HStack(spacing: 12) {
                Button(action: { showLiveDemo = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                        Text("Full Screen Demo")
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Button(action: { showLoginBottomSheet = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "rectangle.bottomhalf.inset.filled")
                        Text("Bottom Sheet Demo")
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                Spacer()
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Preview Section
    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader(
                title: "Live Preview",
                subtitle: "Interactive template demonstration",
                icon: "play.rectangle.fill"
            )
            
            ZStack {
                // Template Preview
                TPEOrganizmLoginTL(
                    config: customizedConfig,
                    cardHeight: customization.cardHeight,
                    onLoginSuccess: {
                        // When login button is tapped in preview, show bottom sheet
                        showLoginBottomSheet = true
                    },
                    onRegisterSuccess: handleRegisterSuccess
                )
                .frame(height: 500)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // Success Overlay
                if isLoggedIn {
                    LoginSuccessOverlay()
                }
                
                // Preview Badge
                VStack {
                    HStack {
                        PreviewBadge()
                        Spacer()
                    }
                    .padding(16)
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Customization Section
    private var customizationSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader(
                title: "Customization",
                subtitle: "Adjust template appearance and content",
                icon: "slider.horizontal.3"
            )
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationOption(
                    icon: "textformat",
                    title: "Content",
                    description: "Text and labels"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        LabeledTextField("Title", text: $customization.title)
                        LabeledTextField("Subtitle", text: $customization.subtitle)
                        LabeledTextField("Button Text", text: $customization.buttonText)
                    }
                }
                
                CustomizationOption(
                    icon: "paintbrush.fill",
                    title: "Appearance",
                    description: "Visual styling"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Background Image", isOn: $customization.showBackgroundImage)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Card Height")
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                                Text("\(Int(customization.cardHeight))pt")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.blue)
                            }
                            
                            Slider(
                                value: $customization.cardHeight,
                                in: 240...500,
                                step: 20
                            )
                        }
                        
                        Toggle("Register Link", isOn: $customization.showRegisterLink)
                    }
                }
            }
        }
    }
    
    // MARK: - Computed Properties
    private var customizedConfig: LoginConfig {
        LoginConfig(
            backgroundUrl: customization.showBackgroundImage ? selectedTemplate.config.backgroundUrl : nil,
            title: customization.title,
            subtitle: customization.subtitle,
            loginText: customization.buttonText
        )
    }
    
    // MARK: - Methods
    private func handleLoginSuccess(_ data: [String: Any]) {
        withAnimation(.spring()) {
            isLoggedIn = true
        }
        
        print("Login successful with data: \(data)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()) {
                isLoggedIn = false
            }
        }
    }
    
    private func handleRegisterSuccess() {
        print("Registration flow initiated")
    }
}



struct SectionHeader: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 24)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            Text(subtitle)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PreviewBadge: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "play.fill")
                .font(.system(size: 10, weight: .bold))
            
            Text("LIVE PREVIEW")
                .font(.system(size: 10, weight: .bold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.green)
        .cornerRadius(12)
    }
}

struct LoginSuccessOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                VStack(spacing: 8) {
                    Text("Authentication Successful")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Welcome back! Redirecting to your dashboard...")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(40)
            .background(Color(.systemBackground).opacity(0.1))
            .cornerRadius(20)
        }
        .cornerRadius(20)
    }
}

struct CustomizationOption<Content: View>: View {
    let icon: String
    let title: String
    let description: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
            }
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            content()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct LabeledTextField: View {
    let label: String
    @Binding var text: String
    
    init(_ label: String, text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            
            TextField(label, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 16))
        }
    }
}

// MARK: - Full Screen Demo
struct FullScreenLoginDemo: View {
    let template: LoginTemplateCatalogView.LoginTemplate
    let customization: LoginTemplateCatalogView.LoginCustomization
    @Environment(\.dismiss) private var dismiss
    @State private var showLoginBottomSheet = false
    
    var body: some View {
        ZStack {
            TPEOrganizmLoginTL(
                config: LoginConfig(
                    backgroundUrl: customization.showBackgroundImage ? template.config.backgroundUrl : nil,
                    title: customization.title,
                    subtitle: customization.subtitle,
                    loginText: customization.buttonText
                ),
                cardHeight: customization.cardHeight,
                onLoginSuccess: {
                    // Show bottom sheet when login button is tapped
                    showLoginBottomSheet = true
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
        .sheet(isPresented: $showLoginBottomSheet) {
            TPELoginBottomSheet(
                isPresented: $showLoginBottomSheet,
                loginType: .tl,
                onSaveSuccess: { data in
                    // Handle successful login and dismiss both sheets
                    showLoginBottomSheet = false
                    dismiss()
                    print("Full screen demo login successful: \(data)")
                },
                onForgotPassword: {
                    print("Forgot password tapped")
                },
                titleText: "Sign In",
                forgotPasswordText: "Forgot Username/Password?"
            )
        }
        .statusBar(hidden: true)
    }
}
