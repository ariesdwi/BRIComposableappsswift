//
//  FormFieldMolecule.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct FormFieldMolecule: View {
    let title: String
    let subtitle: String?
    let placeholder: String
    let icon: String?
    let isSecure: Bool
    let showError: Bool
    let errorMessage: String?
    let isEnabled: Bool
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let autocapitalization: UITextAutocapitalizationType
    let trailingIcon: String?
    let onTrailingIconTap: (() -> Void)?
    
    @Binding var text: String
    @State private var isSecureTextVisible: Bool = false
    
    public init(
        title: String,
        subtitle: String? = nil,
        placeholder: String = "",
        icon: String? = nil,
        isSecure: Bool = false,
        showError: Bool = false,
        errorMessage: String? = nil,
        isEnabled: Bool = true,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        autocapitalization: UITextAutocapitalizationType = .sentences,
        trailingIcon: String? = nil,
        onTrailingIconTap: (() -> Void)? = nil,
        text: Binding<String> = .constant("")
    ) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        self.showError = showError
        self.errorMessage = errorMessage
        self.isEnabled = isEnabled
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.trailingIcon = trailingIcon
        self.onTrailingIconTap = onTrailingIconTap
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            headerView
            
            // Input Field
            inputField
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor)
                )
                .disabled(!isEnabled)
                .opacity(isEnabled ? 1.0 : 0.6)
            
            // Error Message
            if showError, let errorMessage = errorMessage {
                errorMessageView(errorMessage)
            }
        }
    }
    
    // MARK: - Components
    
    private var headerView: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                TPEText(
                    text: title,
                    variant: .text16Bold,
                    color: .primary,
                    textAlignment: .leading
                )
                
                if let subtitle = subtitle {
                    TPEText(
                        text: subtitle,
                        variant: .secondary,
                        color: .secondary,
                        textAlignment: .leading
                    )
                }
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var inputField: some View {
        HStack {
            if isSecure && !isSecureTextVisible {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .autocapitalization(autocapitalization)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .autocapitalization(autocapitalization)
            }
            
            // Trailing icon (eye for password, custom icons, etc.)
            if let trailingIcon = trailingIcon {
                Button(action: {
                    onTrailingIconTap?()
                }) {
                    Image(systemName: trailingIcon)
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
                .buttonStyle(PlainButtonStyle())
            } else if isSecure {
                // Default eye icon for secure fields
                Button(action: {
                    isSecureTextVisible.toggle()
                }) {
                    Image(systemName: isSecureTextVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
    }
    
    private func errorMessageView(_ message: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.system(size: 12))
            
            TPEText(
                text: message,
                variant: .secondary,
                color: .red,
                textAlignment: .leading
            )
            
            Spacer()
        }
        .padding(.top, 4)
    }
    
    // MARK: - Computed Properties
    
    private var borderColor: Color {
        if showError {
            return .red
        } else if isEnabled {
            return .gray.opacity(0.3)
        } else {
            return .gray.opacity(0.2)
        }
    }
    
    private var borderWidth: CGFloat {
        showError ? 1.5 : 1.0
    }
    
    private var backgroundColor: Color {
        isEnabled ? Color(.systemBackground) : Color(.systemGray6)
    }
}

// MARK: - Convenience Initializers

public extension FormFieldMolecule {
    /// Email field with email keyboard and validation
    static func email(
        title: String = "Email",
        subtitle: String? = nil,
        placeholder: String = "Enter your email",
        text: Binding<String> = .constant("")
    ) -> FormFieldMolecule {
        FormFieldMolecule(
            title: title,
            subtitle: subtitle,
            placeholder: placeholder,
            icon: "envelope.fill",
            keyboardType: .emailAddress,
            textContentType: .emailAddress,
            autocapitalization: .none,
            text: text
        )
    }
    
    /// Password field with secure entry
    static func password(
        title: String = "Password",
        placeholder: String = "Enter your password",
        text: Binding<String> = .constant("")
    ) -> FormFieldMolecule {
        FormFieldMolecule(
            title: title,
            placeholder: placeholder,
            icon: "lock.fill",
            isSecure: true,
            textContentType: .password,
            autocapitalization: .none,
            text: text
        )
    }
    
    /// Username field
    static func username(
        title: String = "Username",
        placeholder: String = "Enter your username",
        text: Binding<String> = .constant("")
    ) -> FormFieldMolecule {
        FormFieldMolecule(
            title: title,
            placeholder: placeholder,
            icon: "person.fill",
            autocapitalization: .none,
            text: text
        )
    }
    
    /// Phone number field
    static func phone(
        title: String = "Phone Number",
        placeholder: String = "Enter your phone number",
        text: Binding<String> = .constant("")
    ) -> FormFieldMolecule {
        FormFieldMolecule(
            title: title,
            placeholder: placeholder,
            icon: "phone.fill",
            keyboardType: .phonePad,
            textContentType: .telephoneNumber,
            text: text
        )
    }
}



