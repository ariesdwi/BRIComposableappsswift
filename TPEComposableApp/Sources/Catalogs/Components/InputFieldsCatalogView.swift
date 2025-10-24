//
//  TPEInputFieldCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPEInputFieldCatalogView: View {
    @State private var fieldStates = InputFieldStates()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPEInputField",
                    subtitle: "Interactive input field components with multiple variants and states"
                )
                
                // Field Variants
                ComponentSection(title: "Field Variants", icon: "square.on.square") {
                    VStack(spacing: 16) {
                        ForEach(TPEInputFieldVariant.allCases, id: \.self) { variant in
                            TPEInputField(
                                text: .constant(""),
                                placeholder: "\(variant.name) variant...",
                                variant: variant,
                                size: .medium,
                                state: .default
                            )
                        }
                    }
                }
                
                // Field Sizes
                ComponentSection(title: "Field Sizes", icon: "textformat.size") {
                    VStack(spacing: 16) {
                        ForEach(TPEInputFieldSize.allCases, id: \.self) { size in
                            TPEInputField(
                                text: .constant(""),
                                placeholder: "\(size.name) size...",
                                variant: .default,
                                size: size,
                                state: .default
                            )
                        }
                    }
                }
                
                // Field States
                ComponentSection(title: "Field States", icon: "circle.hexagonpath") {
                    VStack(spacing: 16) {
                        ForEach(TPEInputFieldState.allCases, id: \.self) { state in
                            TPEInputField(
                                text: .constant(state.name),
                                placeholder: "\(state.name) state...",
                                variant: .default,
                                size: .medium,
                                state: state
                            )
                        }
                    }
                }
                
                // Fields with Icons
                ComponentSection(title: "Fields with Icons", icon: "plus.circle") {
                    VStack(spacing: 16) {
                        TPEInputField.withIcon(
                            "Search...",
                            text: $fieldStates.searchText,
                            icon: "magnifyingglass",
                            iconPosition: .leading
                        )
                        
                        TPEInputField.withIcon(
                            "With trailing icon",
                            text: $fieldStates.trailingIconText,
                            icon: "checkmark",
                            iconPosition: .trailing
                        )
                        
                        TPEInputField.email(
                            text: $fieldStates.emailText
                        )
                        
                        TPEInputField.phone(
                            text: $fieldStates.phoneText
                        )
                    }
                }
                
                // Specialized Fields
                ComponentSection(title: "Specialized Fields", icon: "key") {
                    VStack(spacing: 16) {
                        TPEInputField.secure(
                            "Enter password...",
                            text: $fieldStates.passwordText
                        )
                        
                        TPEInputField(
                            text: $fieldStates.disabledSecureText,
                            placeholder: "Disabled secure field...",
                            variant: .default,
                            size: .medium,
                            state: .disabled
                        )
                    }
                }
                
                // Interactive Examples
                ComponentSection(title: "Interactive Examples", icon: "cursorarrow.motionlines") {
                    VStack(spacing: 16) {
                        TPEInputField(
                            text: $fieldStates.interactiveText,
                            title: "Username",
                            placeholder: "Enter your username...",
                            variant: .outline,
                            state: fieldStates.interactiveText.isEmpty ? .default : .success
                        )
                        
                        TPEInputField(
                            text: $fieldStates.validationText,
                            title: "Email Validation",
                            placeholder: "Enter email address...",
                            variant: .filled,
                            state: fieldStates.getEmailValidationState()
                        )
                    }
                }
                
                // Combined Examples
                ComponentSection(title: "Combined Examples", icon: "square.grid.2x2") {
                    VStack(spacing: 16) {
                        Text("Login Form Example")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TPEInputField.email(
                            text: $fieldStates.loginEmail
                        )
                        
                        TPEInputField.secure(
                            "Password",
                            text: $fieldStates.loginPassword
                        )
                        
                        Text("Profile Form Example")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.top, 8)
                        
                        TPEInputField(
                            text: $fieldStates.fullName,
                            title: "Full Name",
                            placeholder: "Enter your full name...",
                            variant: .filled,
                            size: .medium,
                            state: .default
                        )
                        
                        TPEInputField.phone(
                            text: $fieldStates.profilePhone
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("TPEInputField")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Supporting Structures

struct InputFieldStates {
    var searchText = ""
    var trailingIconText = ""
    var emailText = ""
    var phoneText = ""
    var passwordText = ""
    var disabledSecureText = "Cannot edit this"
    var interactiveText = ""
    var validationText = ""
    var loginEmail = ""
    var loginPassword = ""
    var fullName = ""
    var profilePhone = ""
    
    func getEmailValidationState() -> TPEInputFieldState {
        if validationText.isEmpty {
            return .default
        } else if validationText.isValidEmail {
            return .success
        } else {
            return .error
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

// MARK: - Previews

#Preview("Input Field Catalog") {
    NavigationView {
        TPEInputFieldCatalogView()
    }
}

#Preview("Field Variants") {
    VStack(spacing: 16) {
        ForEach(TPEInputFieldVariant.allCases, id: \.self) { variant in
            TPEInputField(
                text: .constant(""),
                placeholder: "\(variant.name) variant...",
                variant: variant,
                size: .medium,
                state: .default
            )
        }
    }
    .padding()
}

#Preview("Field States") {
    VStack(spacing: 16) {
        ForEach(TPEInputFieldState.allCases, id: \.self) { state in
            TPEInputField(
                text: .constant(state.name),
                placeholder: "\(state.name) state...",
                variant: .default,
                size: .medium,
                state: state
            )
        }
    }
    .padding()
}
