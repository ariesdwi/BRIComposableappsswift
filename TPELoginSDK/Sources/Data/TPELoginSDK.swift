
import Foundation
import SwiftUI

public struct TPELoginSDK {
    public static let version = "1.0.0"
    
    public init() {}
}

// MARK: - Login Service
public class LoginService: ObservableObject {
    public static let shared = LoginService()
    
    @Published public var isLoggedIn: Bool = false
    
    private init() {
        // Load login state on init
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    public func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if !username.isEmpty && !password.isEmpty {
                if password.count >= 6 {
                    self.isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    completion(true, "Login successful! Welcome back, \(username)")
                } else {
                    completion(false, "Password must be at least 6 characters")
                }
            } else {
                completion(false, "Please enter both username and password")
            }
        }
    }
    
    public func logout() {
        isLoggedIn = false
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}

// MARK: - Login View
public struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var statusMessage: String = ""
    @StateObject private var loginService = LoginService.shared
    
    public var onLoginSuccess: (() -> Void)?
    
    public init(onLoginSuccess: (() -> Void)? = nil) {
        self.onLoginSuccess = onLoginSuccess
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 8) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Welcome to TPE")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Please sign in to continue")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 40)
            
            // Form
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            // Login Button
            Button(action: performLogin) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .disabled(isLoading || username.isEmpty || password.isEmpty)
            .opacity((isLoading || username.isEmpty || password.isEmpty) ? 0.6 : 1.0)
            
            // Status Message
            if !statusMessage.isEmpty {
                Text(statusMessage)
                    .font(.caption)
                    .foregroundColor(statusMessage.contains("successful") ? .green : .red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Demo Credentials Hint
            VStack(spacing: 4) {
                Text("Demo: any username + password (min 6 chars)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Button("Quick Fill Demo") {
                    username = "demo_user"
                    password = "123456"
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
            .padding(.top)
            
            Spacer()
            
            // Footer
            Text("TPE Login SDK v\(TPELoginSDK.version)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
        .padding()
    }
    
    private func performLogin() {
        isLoading = true
        statusMessage = "Signing in..."
        
        LoginService.shared.login(username: username, password: password) { success, message in
            isLoading = false
            statusMessage = message ?? ""
            
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    onLoginSuccess?()
                }
            }
        }
    }
}

// MARK: - User Profile View
public struct UserProfileView: View {
    @StateObject private var loginService = LoginService.shared
    let username: String
    
    public init(username: String) {
        self.username = username
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Welcome back!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(username)
                .font(.title3)
                .foregroundColor(.primary)
            
            Text("You have successfully signed in to TPE Composable App")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button("Sign Out") {
                loginService.logout()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Preview
public struct LoginView_Previews: PreviewProvider {
    public static var previews: some View {
        Group {
            LoginView()
                .previewDisplayName("Login Screen")
            
            UserProfileView(username: "demo_user")
                .previewDisplayName("Profile Screen")
        }
    }
}
