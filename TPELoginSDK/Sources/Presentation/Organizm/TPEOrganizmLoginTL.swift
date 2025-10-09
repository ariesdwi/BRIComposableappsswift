//
//  TPETemplateLoginTL.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI
import TPEComponentSDK

public struct TPEOrganizmLoginTL: View {
    @StateObject private var viewModel: LoginViewModel
    private let config: LoginConfig
    private let cardHeight: CGFloat
    private let onLoginSuccess: (() -> Void)?
    private let onRegisterSuccess: (() -> Void)?
    
    public init(
        config: LoginConfig,
        cardHeight: CGFloat = 320,
        onLoginSuccess: (() -> Void)? = nil,
        onRegisterSuccess: (() -> Void)? = nil
    ) {
        self.config = config
        self.cardHeight = cardHeight
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterSuccess = onRegisterSuccess
        _viewModel = StateObject(wrappedValue: LoginViewModel(
            loginUseCase: DefaultLoginUseCase(),
            config: config
        ))
    }
    
    public var body: some View {
        ZStack {
            // Background
            TPEColors.blue70
                .ignoresSafeArea()
            
            // Background Image
            backgroundImage
            
            // Login Card
            LoginCard(
                title: config.title,
                subtitle: config.subtitle,
                loginText: config.loginText,
                onLoginTap: handleLogin,
                onRegisterTap: handleRegister,
                cardHeight: cardHeight
            )
            
            // Loading Overlay
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
    
    @ViewBuilder
    private var backgroundImage: some View {
        if let backgroundUrl = config.backgroundUrl, let url = URL(string: backgroundUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 0)
                case .failure:
                    fallbackImage
                @unknown default:
                    fallbackImage
                }
            }
        } else {
            fallbackImage
        }
    }
    
    private var fallbackImage: some View {
        if let uiImage = UIImage(
            named: "background-timles",
            in: .tpeComposable,
            with: nil
        ) {
            AnyView(
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white.opacity(0.8))
//                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding(.bottom, 100)
            )
        } else {
            AnyView(
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white.opacity(0.3))
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding(.bottom, 100)
            )
        }
    }
    
    private func handleLogin() {
        viewModel.login()
        onLoginSuccess?()
    }
    
    private func handleRegister() {
        viewModel.register()
        onRegisterSuccess?()
    }
}

private class TPEBundleFinder {}
private extension Bundle {
    static var tpeComposable: Bundle {
        return Bundle(for: TPEBundleFinder.self)
    }
}
