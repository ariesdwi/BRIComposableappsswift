import SwiftUI
import TPEComponentSDK

public struct TPEOrganizmLoginTL: View {
    @StateObject private var viewModel: LoginOrganizmViewModel
    private let config: LoginConfig
    private let cardHeight: CGFloat
    private let onLoginSuccess: (() async -> Void)?
    private let onRegisterSuccess: (() async -> Void)?
    
    public init(
        config: LoginConfig,
        cardHeight: CGFloat = 320,
        onLoginSuccess: (() async -> Void)? = nil,
        onRegisterSuccess: (() async -> Void)? = nil
    ) {
        self.config = config
        self.cardHeight = cardHeight
        self.onLoginSuccess = onLoginSuccess
        self.onRegisterSuccess = onRegisterSuccess
        _viewModel = StateObject(
            wrappedValue: LoginOrganizmViewModel(
                loginUseCase: DefaultLoginUseCase(),
                config: config
            )
        )
    }
    
    public var body: some View {
        ZStack {
            // ✅ Dynamic Background Color
            backgroundColor
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
}

// MARK: - Background Color Logic
private extension TPEOrganizmLoginTL {
    /// Returns dynamic background color from config (if provided), else fallback
    var backgroundColor: Color {
        if let hex = config.backgroundColorHex, let color = Color(hex: hex) {
            return color
        } else {
            return TPEColors.black
        }
    }
}

// MARK: - Background Image
private extension TPEOrganizmLoginTL {
    @ViewBuilder
    var backgroundImage: some View {
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
    
    var fallbackImage: some View {
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
}

// MARK: - Actions
private extension TPEOrganizmLoginTL {
    func handleLogin() {
        Task {
            await viewModel.login()
            await onLoginSuccess?()
        }
    }
    
    func handleRegister() {
        Task {
            await viewModel.register()
            await onRegisterSuccess?()
        }
    }
}


// MARK: - Bundle Helper
private class TPEBundleFinder {}
private extension Bundle {
    static var tpeComposable: Bundle {
        return Bundle(for: TPEBundleFinder.self)
    }
}

