
import Foundation
import TPENetworkingCore
import SwiftUI

// MARK: - ViewModel
@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: - UI Config
    @Published var showBackgroundImage: Bool = false
    @Published var title: String = ""
    @Published var subtitle: String = ""
    @Published var backgroundColorHex: String?
    @Published var loginButtonText: String = "Login"
    @Published var cardHeight: CGFloat = 320
    @Published var backgroundUrl: String?
    
    // MARK: - Bottom Sheet
    @Published var bottomSheetTitle: String = ""
    @Published var forgotPasswordText: String = ""
    
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var loginError: String?
    
    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Constants
    private enum Constants {
        static let mockUsername = "admin123"
        static let mockPassword = "123456Ab"
        static let loginKey = "isLogin"
    }
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Fetch Config
    func fetchLoginConfig() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response: LoginConfigResponse = try await networkService.request(
                LoginEndpoint.project(id: "BRIMO_ID"),
                expecting: LoginConfigResponse.self
            )
            applyConfig(response.data)
            print("✅ Login config fetched successfully.")
        } catch {
            loginError = error.localizedDescription
            print("❌ Failed to load config:", error.localizedDescription)
        }
    }
    
    // MARK: - Apply Config to UI
    private func applyConfig(_ data: LoginConfigData) {
        showBackgroundImage = data.background?.show ?? false
        backgroundUrl = data.background?.image?.url
        backgroundColorHex = data.background?.color
        
        title = data.card?.title ?? "Welcome"
        subtitle = data.card?.subtitle ?? "Please log in"
        loginButtonText = data.card?.button?.text ?? "Login"
        
        bottomSheetTitle = data.bottomSheet?.title ?? "Login"
        if let forgotBtn = data.bottomSheet?.buttons.first(where: { $0.text.localizedCaseInsensitiveContains("Forgot") }) {
            forgotPasswordText = forgotBtn.text
        } else {
            forgotPasswordText = "Forgot Password?"
        }
    }
    
    // MARK: - Actions
    func handleLoginTapped() async {
        print("🔹 Login button tapped")
    }
    
    func handleRegisterTapped() async {
        print("🔹 Register button tapped")
    }
    
    func handleForgotPassword() {
        print("🔹 Forgot password tapped")
    }
    
    // MARK: - Login Action
    func login(username: String, password: String) async -> Bool {
        isLoading = true
        loginError = nil
        defer { isLoading = false }
        
        // Simulate API delay
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            print("❌ Task sleep error: \(error)")
            return false
        }
        
        // Mock validation
        if username == Constants.mockUsername && password == Constants.mockPassword {
            print("✅ Login success for user: \(username)")
            userDefaults.set(true, forKey: Constants.loginKey)
            objectWillChange.send() // Force UI update
            return true
        } else {
            print("❌ Invalid username or password")
            loginError = "Invalid username or password"
            return false
        }
    }
    
    // MARK: - Check Login Status
    func isUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: Constants.loginKey)
    }
    
    // MARK: - Logout
    func logout() {
        userDefaults.set(false, forKey: Constants.loginKey)
        loginError = nil
        objectWillChange.send() // Force UI update
        print("👋 User logged out")
    }
}
