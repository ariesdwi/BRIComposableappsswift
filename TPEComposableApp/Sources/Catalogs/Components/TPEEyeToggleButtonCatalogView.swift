//
//  TPEEyeToggleButtonCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPEEyeToggleButtonCatalogView: View {
    @State private var eyeStates = EyeToggleStates()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPEEyeToggleButton",
                    subtitle: "Toggle button for showing/hiding sensitive content like passwords"
                )
                
                // Basic Usage
                ComponentSection(title: "Basic Usage", icon: "eye") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Password Field Example")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Password: ••••••••")
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEEyeToggleButton(
                                visible: eyeStates.basicVisible,
                                onTap: { eyeStates.basicVisible.toggle() }
                            )
                        }
                        .padding()
                        .background(TPEColors.light10)
                        .cornerRadius(8)
                    }
                }
                
                // Color Variants
                ComponentSection(title: "Color Variants", icon: "paintpalette") {
                    VStack(spacing: 16) {
                        HStack(spacing: 20) {
                            TPEEyeToggleButton(
                                visible: eyeStates.blueVisible,
                                color: TPEColors.blue70,
                                onTap: { eyeStates.blueVisible.toggle() }
                            )
                            
                            TPEEyeToggleButton(
                                visible: eyeStates.greenVisible,
                                color: TPEColors.green70,
                                onTap: { eyeStates.greenVisible.toggle() }
                            )
                            
                            TPEEyeToggleButton(
                                visible: eyeStates.redVisible,
                                color: TPEColors.red70,
                                onTap: { eyeStates.redVisible.toggle() }
                            )
                            
                            TPEEyeToggleButton(
                                visible: eyeStates.orangeVisible,
                                color: TPEColors.orange70,
                                onTap: { eyeStates.orangeVisible.toggle() }
                            )
                            
                            TPEEyeToggleButton(
                                visible: eyeStates.darkVisible,
                                color: TPEColors.dark30,
                                onTap: { eyeStates.darkVisible.toggle() }
                            )
                        }
                        
                        Text("Tap to toggle visibility state")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // States Demonstration
                ComponentSection(title: "States", icon: "circle.hexagonpath") {
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Visible State")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                HStack {
                                    TPEEyeToggleButton(
                                        visible: true,
                                        color: TPEColors.blue70,
                                        onTap: { print("Visible state tapped") }
                                    )
                                    
                                    Text("eye.slash icon")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Hidden State")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                HStack {
                                    TPEEyeToggleButton(
                                        visible: false,
                                        color: TPEColors.blue70,
                                        onTap: { print("Hidden state tapped") }
                                    )
                                    
                                    Text("eye icon")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                
                // Interactive Examples
                ComponentSection(title: "Interactive Examples", icon: "cursorarrow.motionlines") {
                    VStack(spacing: 20) {
                        // Login Form Example
                        VStack(spacing: 12) {
                            HStack {
                                Text("Login Form")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            VStack(spacing: 12) {
                                // Password Field
                                HStack {
                                    Text("Password")
                                        .foregroundColor(.secondary)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    SecureField("Enter password", text: $eyeStates.passwordText)
                                        .textFieldStyle(PlainTextFieldStyle())
                                    
                                    TPEEyeToggleButton(
                                        visible: eyeStates.loginVisible,
                                        color: TPEColors.blue70,
                                        onTap: { eyeStates.loginVisible.toggle() }
                                    )
                                }
                                .padding()
                                .background(TPEColors.light10)
                                .cornerRadius(8)
                                
                                // Confirm Password Field
                                HStack {
                                    Text("Confirm")
                                        .foregroundColor(.secondary)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    SecureField("Confirm password", text: $eyeStates.confirmPasswordText)
                                        .textFieldStyle(PlainTextFieldStyle())
                                    
                                    TPEEyeToggleButton(
                                        visible: eyeStates.confirmVisible,
                                        color: TPEColors.blue70,
                                        onTap: { eyeStates.confirmVisible.toggle() }
                                    )
                                }
                                .padding()
                                .background(TPEColors.light10)
                                .cornerRadius(8)
                            }
                        }
                        
                        // Settings Example
                        VStack(spacing: 12) {
                            HStack {
                                Text("Settings Panel")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Show Sensitive Data")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Text("Toggle visibility of private information")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                TPEEyeToggleButton(
                                    visible: eyeStates.settingsVisible,
                                    color: TPEColors.dark30,
                                    onTap: { eyeStates.settingsVisible.toggle() }
                                )
                            }
                            .padding()
                            .background(TPEColors.light10)
                            .cornerRadius(8)
                        }
                    }
                }
                
                // Integration with Input Fields
                ComponentSection(title: "With Input Fields", icon: "textbox") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Password Input Integration")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        
                        VStack(spacing: 12) {
                            // Custom Password Field
                            HStack {
                                if eyeStates.integrationVisible {
                                    TextField("Password", text: $eyeStates.integrationPassword)
                                        .textFieldStyle(PlainTextFieldStyle())
                                } else {
                                    SecureField("Password", text: $eyeStates.integrationPassword)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                
                                TPEEyeToggleButton(
                                    visible: eyeStates.integrationVisible,
                                    onTap: { eyeStates.integrationVisible.toggle() }
                                )
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(TPEColors.light10)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(TPEColors.light40, lineWidth: 1)
                            )
                            
                            Text("Current state: \(eyeStates.integrationVisible ? "Visible" : "Hidden")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Eye Toggle Button")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Supporting Structures

struct EyeToggleStates {
    var basicVisible = false
    var blueVisible = false
    var greenVisible = false
    var redVisible = false
    var orangeVisible = false
    var darkVisible = false
    var loginVisible = false
    var confirmVisible = false
    var settingsVisible = false
    var integrationVisible = false
    
    var passwordText = ""
    var confirmPasswordText = ""
    var integrationPassword = ""
}

// MARK: - Convenience Extensions

public extension TPEEyeToggleButton {
    /// Create an eye toggle button with default blue color
    static func standard(
        visible: Bool,
        onTap: @escaping () -> Void
    ) -> TPEEyeToggleButton {
        TPEEyeToggleButton(
            visible: visible,
            color: TPEColors.blue80,
            onTap: onTap
        )
    }
    
    /// Create an eye toggle button for password fields
    static func forPassword(
        visible: Bool,
        onTap: @escaping () -> Void
    ) -> TPEEyeToggleButton {
        TPEEyeToggleButton(
            visible: visible,
            color: TPEColors.dark30,
            onTap: onTap
        )
    }
}


#Preview("Eye Toggle Button Catalog") {
    NavigationView {
        TPEEyeToggleButtonCatalogView()
    }
}

#Preview("Basic Examples") {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            TPEEyeToggleButton(
                visible: false,
                onTap: { print("Eye button tapped") }
            )
            
            TPEEyeToggleButton(
                visible: true,
                color: TPEColors.green70,
                onTap: { print("Green eye button tapped") }
            )
            
            TPEEyeToggleButton(
                visible: false,
                color: TPEColors.red70,
                onTap: { print("Red eye button tapped") }
            )
        }
        
        // Integration example
        VStack(spacing: 12) {
            Text("Password Field Example")
                .font(.headline)
            
            HStack {
                if false {
                    TextField("Password", text: .constant("password123"))
                        .textFieldStyle(PlainTextFieldStyle())
                } else {
                    SecureField("Password", text: .constant("password123"))
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                TPEEyeToggleButton(
                    visible: false,
                    onTap: { print("Toggle visibility") }
                )
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(TPEColors.light10)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(TPEColors.light40, lineWidth: 1)
            )
        }
        .padding()
    }
}
