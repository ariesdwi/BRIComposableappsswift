//
//  TPEBottomSheetLogin.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

public struct TPELoginBottomSheet: View {
    @Binding var isPresented: Bool
    let loginType: LoginType
    let maximumInputChar: Int
    let minimumUsernameLength: Int
    let minimumPasswordLength: Int
    let onSaveSuccess: ([String: Any]) -> Void
    let onForgotPassword: (() -> Void)?
    let titleText: String
    let forgotPasswordText: String
    
    @StateObject private var viewModel: LoginBottomSheetViewModel
    
    public enum LoginType {
        case tw  // With ID card and checkbox
        case tl  // Simple login
        
        var showIdCardField: Bool {
            switch self {
            case .tw: return true
            case .tl: return false
            }
        }
        
        var showCheckbox: Bool {
            switch self {
            case .tw: return true
            case .tl: return false
            }
        }
        
        var isEnableEyePassword: Bool {
            switch self {
            case .tw: return true
            case .tl: return false
            }
        }
    }
    
    public init(
        isPresented: Binding<Bool>,
        loginType: LoginType,
        maximumInputChar: Int = 100,
        minimumUsernameLength: Int = 6,
        minimumPasswordLength: Int = 8,
        onSaveSuccess: @escaping ([String: Any]) -> Void,
        onForgotPassword: (() -> Void)? = nil,
        titleText: String? = nil,
        forgotPasswordText: String? = nil
    ) {
        self._isPresented = isPresented
        self.loginType = loginType
        self.maximumInputChar = maximumInputChar
        self.minimumUsernameLength = minimumUsernameLength
        self.minimumPasswordLength = minimumPasswordLength
        self.onSaveSuccess = onSaveSuccess
        self.onForgotPassword = onForgotPassword
        self.titleText = titleText ?? "Login"
        self.forgotPasswordText = forgotPasswordText ?? "Forgot Username/Password?"
        
        // Initialize ViewModel with parameters
        self._viewModel = StateObject(wrappedValue: LoginBottomSheetViewModel(
            minimumUsernameLength: minimumUsernameLength,
            minimumPasswordLength: minimumPasswordLength,
            maximumInputChar: maximumInputChar
        ))
    }
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Drag handle
                dragHandle
                
                // Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Title
                        TPEText(
                            text: titleText,
                            variant: .text16Bold,
                            color: .primary,
                            textAlignment: .center
                        )
                        .padding(.top, 8)
                        
                        // Form fields
                        formFields
                        
                        // CAPTCHA Component
                        captchaSection
                        
                        // Buttons
                        actionButtons
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
            .navigationBarHidden(true)
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(viewModel.isLoading)
        .onChange(of: isPresented) { newValue in
            if !newValue {
                viewModel.resetForm()
            }
        }
    }
    
    // MARK: - Components
    
    private var dragHandle: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 4)
            .cornerRadius(2)
            .padding(.top, 8)
            .padding(.bottom, 12)
    }
    
    private var formFields: some View {
        VStack(spacing: 0) {
            // ID Card Field (only for .tw)
            if loginType.showIdCardField {
                FormFieldMolecule(
                    title: "ID Card",
                    placeholder: "Enter ID Card",
                    keyboardType: .numberPad,
                    text: $viewModel.idCard
                )
                .onChange(of: viewModel.idCard) { newValue in
                    // Limit ID card to numbers only and max length
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count <= maximumInputChar {
                        viewModel.idCard = filtered
                    } else {
                        viewModel.idCard = String(filtered.prefix(maximumInputChar))
                    }
                }
            }
            
            // Username Field
            FormFieldMolecule(
                title: "",
                placeholder: "Enter Username",
                showError: viewModel.shouldShowUsernameError,
                errorMessage: viewModel.usernameErrorMessage,
                text: $viewModel.username
            )
            .onChange(of: viewModel.username) { newValue in
                if newValue.count > maximumInputChar {
                    viewModel.username = String(newValue.prefix(maximumInputChar))
                }
                viewModel.validateForm()
            }
            
            // Password Field
            FormFieldMolecule(
                title: "",
                placeholder: "Enter Password",
                isSecure: true,
                showError: viewModel.shouldShowPasswordError,
                errorMessage: viewModel.passwordErrorMessage,
                trailingIcon: loginType.isEnableEyePassword ? (viewModel.showPassword ? "eye.slash" : "eye") : nil,
                onTrailingIconTap: {
                    if loginType.isEnableEyePassword {
                        viewModel.showPassword.toggle()
                    }
                },
                text: $viewModel.password
            )
            .onChange(of: viewModel.password) { newValue in
                if newValue.count > maximumInputChar {
                    viewModel.password = String(newValue.prefix(maximumInputChar))
                }
                viewModel.validateForm()
            }
            
            // Checkbox (only for .tw)
            if loginType.showCheckbox {
                Toggle("Show credential", isOn: $viewModel.showPassword)
                    .toggleStyle(TPECheckboxToggleStyle())
                    .foregroundColor(.primary)
                    .padding(.top, 8)
            }
        }
    }
    
    private var captchaSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            TPEText(
                text: "CAPTCHA",
                variant: .text14Regular,
                color: .primary,
                textAlignment: .leading
            )
            
            HStack(spacing: 12) {
                // CAPTCHA Image/Display
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 44)
                    
                    HStack {
                        // CAPTCHA Text - You can replace this with actual CAPTCHA generation
                        TPEText(
                            text: viewModel.captchaText,
                            variant: .text16Bold,
                            color: .primary,
                            textAlignment: .center
                        )
                        .padding(.horizontal, 12)
                        
                        Spacer()
                        
                        // Refresh button
                        Button(action: {
                            viewModel.generateNewCaptcha()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                                .padding(8)
                        }
                    }
                }
                
                // CAPTCHA Input Field
                TextField("Enter CAPTCHA", text: $viewModel.captchaInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
                    .onChange(of: viewModel.captchaInput) { newValue in
                        // Limit CAPTCHA input length
                        if newValue.count > 6 {
                            viewModel.captchaInput = String(newValue.prefix(6))
                        }
                        viewModel.validateCaptcha()
                    }
            }
            
            // CAPTCHA Error Message
            if viewModel.shouldShowCaptchaError {
                TPEText(
                    text: viewModel.captchaErrorMessage,
                    variant: .text12Regular,
                    color: .red,
                    textAlignment: .leading
                )
                .padding(.top, 4)
            }
        }
        .padding(.top, 8)
    }
    
    private var actionButtons: some View {
        VStack(spacing: 12) {
            // Login Button
            TPEButton(
                title: "Login",
                variant: .primary,
                size: .small,
                roundType: .rounded,
                isCentered: true,
                isEnabled: viewModel.isFormValid && viewModel.isCaptchaValid,
                isLoading: viewModel.isLoading,
                onPressed: handleLogin
            )
            
            TPELinkText(
                text: "Forgot Username/Password?",
                color: TPEColors.primaryBlue,
                onTap: onForgotPassword!
            )
        }
        .padding(.top, 8)
    }
    
    // MARK: - Actions
    
    private func handleLogin() {
        viewModel.validateForm()
        viewModel.validateCaptcha()
        
        guard viewModel.isFormValid && viewModel.isCaptchaValid else { return }
        
        viewModel.isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            viewModel.isLoading = false
            
            var data: [String: Any] = [
                "username": viewModel.username,
                "password": viewModel.password
            ]
            
            if loginType.showIdCardField {
                data["idCard"] = viewModel.idCard
            }
            
            if loginType.showCheckbox {
                data["rememberMe"] = viewModel.showPassword
            }
            
            onSaveSuccess(data)
            isPresented = false
        }
    }
}

// MARK: - ViewModel

class LoginBottomSheetViewModel: ObservableObject {
    @Published var idCard: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    @Published var isLoading: Bool = false
    @Published var hasAttemptedValidation: Bool = false
    
    // CAPTCHA Properties
    @Published var captchaText: String = ""
    @Published var captchaInput: String = ""
    @Published var isCaptchaValid: Bool = false
    @Published var hasAttemptedCaptchaValidation: Bool = false
    
    private let minimumUsernameLength: Int
    private let minimumPasswordLength: Int
    private let maximumInputChar: Int
    
    init(minimumUsernameLength: Int, minimumPasswordLength: Int, maximumInputChar: Int) {
        self.minimumUsernameLength = minimumUsernameLength
        self.minimumPasswordLength = minimumPasswordLength
        self.maximumInputChar = maximumInputChar
        self.generateNewCaptcha()
    }
    
    var isUsernameValid: Bool {
        username.count >= minimumUsernameLength && username.count <= maximumInputChar
    }
    
    var isPasswordValid: Bool {
        password.count >= minimumPasswordLength && password.count <= maximumInputChar
    }
    
    var isFormValid: Bool {
        isUsernameValid && isPasswordValid
    }
    
    var shouldShowUsernameError: Bool {
        hasAttemptedValidation && !isUsernameValid && !username.isEmpty
    }
    
    var shouldShowPasswordError: Bool {
        hasAttemptedValidation && !isPasswordValid && !password.isEmpty
    }
    
    var shouldShowCaptchaError: Bool {
        hasAttemptedCaptchaValidation && !isCaptchaValid && !captchaInput.isEmpty
    }
    
    var usernameErrorMessage: String {
        if username.isEmpty {
            return "Username is required"
        } else if username.count < minimumUsernameLength {
            return "Username must be at least \(minimumUsernameLength) characters"
        } else if username.count > maximumInputChar {
            return "Username must be less than \(maximumInputChar) characters"
        }
        return ""
    }
    
    var passwordErrorMessage: String {
        if password.isEmpty {
            return "Password is required"
        } else if password.count < minimumPasswordLength {
            return "Password must be at least \(minimumPasswordLength) characters"
        } else if password.count > maximumInputChar {
            return "Password must be less than \(maximumInputChar) characters"
        }
        return ""
    }
    
    var captchaErrorMessage: String {
        if captchaInput.isEmpty {
            return "CAPTCHA is required"
        } else if !isCaptchaValid {
            return "CAPTCHA does not match"
        }
        return ""
    }
    
    func validateForm() {
        hasAttemptedValidation = true
    }
    
    func validateCaptcha() {
        hasAttemptedCaptchaValidation = true
        isCaptchaValid = captchaInput.lowercased() == captchaText.lowercased()
    }
    
    func generateNewCaptcha() {
        // Generate a simple random CAPTCHA string
        let characters = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
        captchaText = String((0..<5).map { _ in characters.randomElement()! })
        captchaInput = ""
        isCaptchaValid = false
        hasAttemptedCaptchaValidation = false
    }
    
    func resetForm() {
        idCard = ""
        username = ""
        password = ""
        showPassword = false
        isLoading = false
        hasAttemptedValidation = false
        generateNewCaptcha()
    }
}

// MARK: - Checkbox Toggle Style

struct TPECheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

// MARK: - Convenience Function

public extension View {
    func showTPELoginBottomSheet(
        isPresented: Binding<Bool>,
        loginType: TPELoginBottomSheet.LoginType,
        maximumInputChar: Int = 100,
        minimumUsernameLength: Int = 6,
        minimumPasswordLength: Int = 8,
        onSaveSuccess: @escaping ([String: Any]) -> Void,
        onForgotPassword: (() -> Void)? = nil,
        titleText: String? = nil,
        forgotPasswordText: String? = nil
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            TPELoginBottomSheet(
                isPresented: isPresented,
                loginType: loginType,
                maximumInputChar: maximumInputChar,
                minimumUsernameLength: minimumUsernameLength,
                minimumPasswordLength: minimumPasswordLength,
                onSaveSuccess: onSaveSuccess,
                onForgotPassword: onForgotPassword,
                titleText: titleText,
                forgotPasswordText: forgotPasswordText
            )
        }
    }
}

// MARK: - Preview

#Preview("TL Login with CAPTCHA") {
    struct PreviewWrapper: View {
        @State private var showSheet = true
        
        var body: some View {
            Color.clear
                .showTPELoginBottomSheet(
                    isPresented: $showSheet,
                    loginType: .tl,
                    onSaveSuccess: { data in
                        print("Login successful: \(data)")
                    }
                )
        }
    }
    return PreviewWrapper()
}
