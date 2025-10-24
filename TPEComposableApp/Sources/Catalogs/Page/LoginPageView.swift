import SwiftUI
import TPEComponentSDK
import TPELoginSDK
import TPENetworkingCore

public struct LoginDemoView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    @State private var showLoginBottomSheet = false
    @State private var showErrorAlert = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // MARK: - Main Login Layout
            TPEOrganizmLoginTL(
                config: LoginConfig(
                    backgroundUrl: viewModel.showBackgroundImage ? viewModel.backgroundUrl : nil,
                    backgroundColorHex: viewModel.backgroundColorHex,
                    title: viewModel.title,
                    subtitle: viewModel.subtitle,
                    loginText: viewModel.loginButtonText
                ),
                cardHeight: viewModel.cardHeight,
                onLoginSuccess: {
                    await viewModel.handleLoginTapped()
                    showLoginBottomSheet = true
                },
                onRegisterSuccess: {
                    await viewModel.handleRegisterTapped()
                }
            )
            .ignoresSafeArea()
            
            // Loading overlay
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }
        .sheet(isPresented: $showLoginBottomSheet) {
            TPELoginBottomSheet(
                isPresented: $showLoginBottomSheet,
                loginType: .tl,
                onSaveSuccess: { data in
                    // Convert to synchronous closure and use Task for async work
                    Task {
                        await handleLoginSuccess(data: data)
                    }
                },
                onForgotPassword: {
                    viewModel.handleForgotPassword()
                },
                titleText: viewModel.bottomSheetTitle,
                forgotPasswordText: viewModel.forgotPasswordText
            )
        }
        .alert("Login Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.loginError ?? "Unknown error occurred")
        }
        .statusBar(hidden: true)
        .task {
            await viewModel.fetchLoginConfig()
        }
        .onChange(of: viewModel.loginError) { error in
            showErrorAlert = error != nil
        }
    }
    
    // MARK: - Handle Login Success
    private func handleLoginSuccess(data: Any) async {
        guard let credentials = data as? [String: String],
              let username = credentials["username"],
              let password = credentials["password"] else {
            viewModel.loginError = "Invalid login data"
            return
        }
        
        let success = await viewModel.login(username: username, password: password)
        
        if success {
            await MainActor.run {
                showLoginBottomSheet = false
                // Parent will automatically detect login state change and show homepage
            }
        }
    }
}
