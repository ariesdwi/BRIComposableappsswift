//
//  LoginPageTemplate.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

public struct LoginPageTemplate: View {
    @State private var isLoggedIn = false
    @State private var showLoginModal = false
    @State private var showFullScreenLogin = false
    
    private let appName: String
    private let appIcon: String
    private let onLoginSuccess: (() -> Void)?
    private let onRegisterSuccess: (() -> Void)?
    
    public init(
        appName: String = "MyApp",
        appIcon: String = "person.crop.circle.fill.badge.checkmark",
        onLoginSuccess: (() -> Void)? = nil,
        onRegisterSuccess: (() -> Void)? = nil
    ) {
        self.appName = appName
        self.appIcon = appIcon
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterSuccess = onRegisterSuccess
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Header Section
                    headerSection
                    
                    // Login Options
                    loginOptionsSection
                    
                    // Quick Preview
                    previewSection
                    
                    // Action Buttons
                    actionButtonsSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showLoginModal) {
                ModalLoginTemplate(
                    appName: appName,
                    onLoginSuccess: handleLoginSuccess,
                    onRegisterSuccess: onRegisterSuccess
                )
            }
            .fullScreenCover(isPresented: $showFullScreenLogin) {
                FullScreenLoginTemplate(
                    appName: appName,
                    onLoginSuccess: handleLoginSuccess,
                    onRegisterSuccess: onRegisterSuccess
                )
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: appIcon)
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Welcome to \(appName)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Sign in to access your account and all features")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Login Options Section
    private var loginOptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Get Started")
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                LoginOptionCard(
                    icon: "rectangle.fill",
                    title: "Standard Login",
                    description: "In-page authentication",
                    color: .blue
                ) {
                    // Standard login happens in the preview section
                }
                
                LoginOptionCard(
                    icon: "square.stack.3d.up.fill",
                    title: "Modal Login",
                    description: "Pop-up authentication",
                    color: .green
                ) {
                    showLoginModal = true
                }
                
                LoginOptionCard(
                    icon: "rectangle.fill.on.rectangle.fill",
                    title: "Full Screen",
                    description: "Immersive experience",
                    color: .purple
                ) {
                    showFullScreenLogin = true
                }
                
                LoginOptionCard(
                    icon: "person.badge.plus",
                    title: "Create Account",
                    description: "New user registration",
                    color: .orange
                ) {
                    onRegisterSuccess?()
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Preview Section
    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Preview")
                .font(.headline)
                .foregroundColor(.primary)
            
            ZStack {
                // Using the TPEOrganizmLoginTL organism
                TPEOrganizmLoginTL(
                    config: LoginConfig(
                        title: "Welcome to \(appName)",
                        subtitle: "Sign in to access your account",
                        loginText: "Sign In"
                    ),
                    cardHeight: 300,
                    onLoginSuccess: handleLoginSuccess,
                    onRegisterSuccess: onRegisterSuccess
                )
                .frame(height: 380)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
                // Preview badge
                VStack {
                    HStack {
                        Text("LIVE PREVIEW")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(4)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(12)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Action Buttons Section
    private var actionButtonsSection: some View {
        VStack(spacing: 16) {
            if isLoggedIn {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                    
                    Text("Successfully Signed In!")
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    Text("Welcome back to \(appName)")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
            } else {
                Text("Choose a login option above to get started")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Methods
    private func handleLoginSuccess() {
        withAnimation(.spring()) {
            isLoggedIn = true
        }
        onLoginSuccess?()
    }
}

// MARK: - Supporting Views
struct LoginOptionCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(color)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(description)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding(16)
            .frame(height: 120)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Modal Login Template
public struct ModalLoginTemplate: View {
    @Environment(\.dismiss) private var dismiss
    
    private let appName: String
    private let onLoginSuccess: (() -> Void)?
    private let onRegisterSuccess: (() -> Void)?
    
    public init(
        appName: String = "MyApp",
        onLoginSuccess: (() -> Void)? = nil,
        onRegisterSuccess: (() -> Void)? = nil
    ) {
        self.appName = appName
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterSuccess = onRegisterSuccess
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 16) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Text("Secure Login")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 32)
                    
                    // Using the TPEOrganizmLoginTL organism
                    TPEOrganizmLoginTL(
                        config: LoginConfig(
                            title: "Welcome to \(appName)",
                            subtitle: "Sign in to continue to your account",
                            loginText: "Continue"
                        ),
                        cardHeight: 320,
                        onLoginSuccess: {
                            onLoginSuccess?()
                            dismiss()
                        },
                        onRegisterSuccess: onRegisterSuccess
                    )
                    .frame(height: 400)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Footer
                    Text("By continuing, you agree to our Terms of Service and Privacy Policy")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Full Screen Login Template
public struct FullScreenLoginTemplate: View {
    @Environment(\.dismiss) private var dismiss
    
    private let appName: String
    private let onLoginSuccess: (() -> Void)?
    private let onRegisterSuccess: (() -> Void)?
    
    public init(
        appName: String = "MyApp",
        onLoginSuccess: (() -> Void)? = nil,
        onRegisterSuccess: (() -> Void)? = nil
    ) {
        self.appName = appName
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterSuccess = onRegisterSuccess
    }
    
    public var body: some View {
        ZStack {
            // Using the TPEOrganizmLoginTL organism in full screen
            TPEOrganizmLoginTL(
                config: LoginConfig(
                    backgroundUrl: "https://images.unsplash.com/photo-1556761175-b413da4baf72?ixlib=rb-4.0.3&auto=format&fit=crop&w=1374&q=80",
                    title: "Welcome to \(appName)",
                    subtitle: "Access your personalized workspace",
                    loginText: "Get Started"
                ),
                cardHeight: 380,
                onLoginSuccess: {
                    onLoginSuccess?()
                    dismiss()
                },
                onRegisterSuccess: onRegisterSuccess
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

// MARK: - Previews
public struct LoginPageTemplate_Previews: PreviewProvider {
    public static var previews: some View {
        Group {
            LoginPageTemplate(
                appName: "MyApp",
                onLoginSuccess: {
                    print("Login successful!")
                },
                onRegisterSuccess: {
                    print("Registration started")
                }
            )
            .previewDisplayName("Main Template")
            
            ModalLoginTemplate(
                appName: "MyApp"
            )
            .previewDisplayName("Modal Template")
            
            FullScreenLoginTemplate(
                appName: "MyApp"
            )
            .previewDisplayName("Full Screen Template")
        }
    }
}
