
//
//  DemoLoginFlow.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK
import TPELoginSDK

public struct DemoLoginFlow: View {
    @State private var currentScreen: LoginScreen = .welcome
    @State private var showLoginBottomSheet = false
    @State private var loginData: [String: Any] = [:]
    
    enum LoginScreen {
        case welcome
        case fullScreenLogin
        case bottomSheetLogin
        case dashboard
    }
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                // Main content based on current screen
                Group {
                    switch currentScreen {
                    case .welcome:
                        welcomeView
                    case .fullScreenLogin:
                        TPEOrganizmLoginTL(
                            config: LoginConfig(
                                title: "Welcome Back",
                                subtitle: "Sign in to your account",
                                loginText: "Sign In",
                            ),
                            onLoginSuccess: {
                                // When login button is tapped in full screen, show bottom sheet
                                showLoginBottomSheet = true
                            },
                            onRegisterSuccess: {
                                // Handle register if needed
                                print("Register tapped")
                            }
                        )
                    case .bottomSheetLogin:
                        Color.clear // Handled by sheet
                    case .dashboard:
                        dashboardView
                    }
                }
                
                // Bottom sheet overlay
                if showLoginBottomSheet {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showLoginBottomSheet = false
                        }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showLoginBottomSheet) {
            TPELoginBottomSheet(
                isPresented: $showLoginBottomSheet,
                loginType: .tl,
                onSaveSuccess: { data in
                    // Handle successful login from bottom sheet
                    self.loginData = data
                    self.showLoginBottomSheet = false
                    self.currentScreen = .dashboard
                    print("Login successful with data: \(data)")
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
    
    // MARK: - Welcome Screen
    private var welcomeView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // App Icon/Logo
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            // Welcome Text
            VStack(spacing: 16) {
                Text("Welcome to Demo App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Please sign in to continue to your account")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // Login Button
            VStack(spacing: 16) {
                TPEButton(
                    title: "Sign In",
                    variant: .primary,
                    size: .large,
                    roundType: .rounded,
                    isCentered: true,
                    onPressed: {
                        // Navigate to full screen login
                        currentScreen = .fullScreenLogin
                    }
                )
                
                // Alternative: Direct to bottom sheet
                Button("Quick Sign In") {
                    showLoginBottomSheet = true
                }
                .foregroundColor(.blue)
                .font(.body)
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Dashboard Screen
    private var dashboardView: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                
                Text("Welcome to Dashboard!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("You have successfully signed in")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 60)
            
            // Login Data Display
            if !loginData.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Login Information:")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    ForEach(Array(loginData.keys.sorted()), id: \.self) { key in
                        if let value = loginData[key] {
                            HStack {
                                Text("\(key):")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("\(String(describing: value))")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: 12) {
                TPEButton(
                    title: "Sign Out",
                    variant: .secondary,
                    size: .medium,
                    roundType: .rounded,
                    isCentered: true,
                    onPressed: {
                        // Reset to welcome screen
                        currentScreen = .welcome
                        loginData = [:]
                    }
                )
                
                Button("Back to Welcome") {
                    currentScreen = .welcome
                }
                .foregroundColor(.blue)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color(.systemBackground))
    }
}

