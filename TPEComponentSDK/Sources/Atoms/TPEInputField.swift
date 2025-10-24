
//
//  TPEInputField.swift
//  TPEComponentSDK
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct TPEInputField: View {
    // MARK: - Properties
    @Binding private var text: String
    @State private var isEditing: Bool = false
    
    private let title: String?
    private let placeholder: String
    private let variant: TPEInputFieldVariant
    private let size: TPEInputFieldSize
    private let state: TPEInputFieldState
    private let contentType: UITextContentType?
    private let isSecure: Bool
    private let icon: String?
    private let iconPosition: IconPosition
    private let showClearButton: Bool
    private let onCommit: (() -> Void)?
    private let onEditingChanged: ((Bool) -> Void)?
    
    // MARK: - Initializers
    public init(
        text: Binding<String>,
        title: String? = nil,
        placeholder: String = "",
        variant: TPEInputFieldVariant = .default,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        contentType: UITextContentType? = nil,
        isSecure: Bool = false,
        icon: String? = nil,
        iconPosition: IconPosition = .leading,
        showClearButton: Bool = true,
        onCommit: (() -> Void)? = nil,
        onEditingChanged: ((Bool) -> Void)? = nil
    ) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.variant = variant
        self.size = size
        self.state = state
        self.contentType = contentType
        self.isSecure = isSecure
        self.icon = icon
        self.iconPosition = iconPosition
        self.showClearButton = showClearButton
        self.onCommit = onCommit
        self.onEditingChanged = onEditingChanged
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(titleColor)
            }
            
            HStack {
                if let icon = icon, iconPosition == .leading {
                    iconView(icon)
                }
                
                inputField
                    .padding(.vertical, size.verticalPadding)
                
                if let icon = icon, iconPosition == .trailing {
                    iconView(icon)
                }
                
                if showClearButton && !text.isEmpty && state == .default && isEditing {
                    clearButton
                }
            }
            .padding(.horizontal, size.horizontalPadding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            
            if let message = state.message {
                Text(message)
                    .font(.caption2)
                    .foregroundColor(messageColor)
                    .padding(.horizontal, 4)
            }
        }
    }
    
    // MARK: - Private Views
    private var inputField: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
            } else {
                TextField(placeholder, text: $text, onEditingChanged: { editing in
                    isEditing = editing
                    onEditingChanged?(editing)
                }, onCommit: {
                    onCommit?()
                })
            }
        }
        .font(size.font)
        .foregroundColor(textColor)
        .textContentType(contentType)
        .disabled(state == .disabled)
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
    
    private func iconView(_ icon: String) -> some View {
        Image(systemName: icon)
            .font(size.iconFont)
            .foregroundColor(iconColor)
            .frame(width: size.iconSize, height: size.iconSize)
    }
    
    private var clearButton: some View {
        Button(action: {
            text = ""
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.caption)
                .foregroundColor(TPEColors.light60)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Computed Properties
    private var backgroundColor: Color {
        if state == .disabled {
            return TPEColors.light10
        }
        switch variant {
        case .filled:
            return TPEColors.light10
        case .outline, .default:
            return Color(.systemBackground)
        }
    }
    
    private var borderColor: Color {
        if state == .disabled {
            return TPEColors.light30
        }
        
        if isEditing {
            return TPEColors.primaryBlue
        }
        
        switch state {
        case .error:
            return TPEColors.red70
        case .warning:
            return TPEColors.orange70
        case .success:
            return TPEColors.green70
        default:
            return TPEColors.light40
        }
    }
    
    private var textColor: Color {
        state == .disabled ? TPEColors.light60 : TPEColors.black
    }
    
    private var titleColor: Color {
        state == .disabled ? TPEColors.light60 : TPEColors.dark30
    }
    
    private var iconColor: Color {
        switch state {
        case .error:
            return TPEColors.red70
        case .warning:
            return TPEColors.orange70
        case .success:
            return TPEColors.green70
        default:
            return TPEColors.light60
        }
    }
    
    private var messageColor: Color {
        switch state {
        case .error:
            return TPEColors.red70
        case .warning:
            return TPEColors.orange70
        case .success:
            return TPEColors.green70
        default:
            return TPEColors.light60
        }
    }
    
    private var borderWidth: CGFloat {
        isEditing ? 2 : 1
    }
    
    private var cornerRadius: CGFloat {
        switch variant {
        case .default:
            return 8
        case .outline:
            return 8
        case .filled:
            return 8
        }
    }
}

// MARK: - Supporting Enums

public enum TPEInputFieldVariant: CaseIterable {
    case `default`
    case outline
    case filled
    
    public var name: String {
        switch self {
        case .default: return "Default"
        case .outline: return "Outline"
        case .filled: return "Filled"
        }
    }
}

public enum TPEInputFieldSize: CaseIterable {
    case small
    case medium
    case large
    
    public var name: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        }
    }
    
    var font: Font {
        switch self {
        case .small: return .caption
        case .medium: return .body
        case .large: return .title3
        }
    }
    
    var iconFont: Font {
        switch self {
        case .small: return .caption
        case .medium: return .callout
        case .large: return .body
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 16
        case .medium: return 18
        case .large: return 20
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 16
        case .large: return 20
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }
}

public enum TPEInputFieldState: String, CaseIterable, Hashable {
    case `default`
    case error
    case warning
    case success
    case disabled
    
    public var name: String {
        switch self {
        case .default: return "Default"
        case .error: return "Error"
        case .warning: return "Warning"
        case .success: return "Success"
        case .disabled: return "Disabled"
        }
    }
    
    public var message: String? {
        switch self {
        case .error: return "Please check this field"
        case .warning: return "This needs attention"
        case .success: return "Looks good!"
        default: return nil
        }
    }
    
    public var icon: String? {
        switch self {
        case .error: return "exclamationmark.triangle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .success: return "checkmark.circle.fill"
        default: return nil
        }
    }
}

public enum IconPosition {
    case leading
    case trailing
}

// MARK: - Convenience Extensions

public extension TPEInputField {
    /// Primary input field with default styling
    static func primary(
        _ placeholder: String,
        text: Binding<String>,
        title: String? = nil,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        onCommit: (() -> Void)? = nil
    ) -> TPEInputField {
        TPEInputField(
            text: text,
            title: title,
            placeholder: placeholder,
            variant: .default,
            size: size,
            state: state,
            onCommit: onCommit
        )
    }
    
    /// Input field with icon
    static func withIcon(
        _ placeholder: String,
        text: Binding<String>,
        icon: String,
        iconPosition: IconPosition = .leading,
        title: String? = nil,
        variant: TPEInputFieldVariant = .default,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        onCommit: (() -> Void)? = nil
    ) -> TPEInputField {
        TPEInputField(
            text: text,
            title: title,
            placeholder: placeholder,
            variant: variant,
            size: size,
            state: state,
            icon: icon,
            iconPosition: iconPosition,
            onCommit: onCommit
        )
    }
    
    /// Secure input field for passwords
    static func secure(
        _ placeholder: String,
        text: Binding<String>,
        title: String? = nil,
        variant: TPEInputFieldVariant = .default,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        onCommit: (() -> Void)? = nil
    ) -> TPEInputField {
        TPEInputField(
            text: text,
            title: title,
            placeholder: placeholder,
            variant: variant,
            size: size,
            state: state,
            contentType: .password,
            isSecure: true,
            onCommit: onCommit
        )
    }
    
    /// Email input field
    static func email(
        _ placeholder: String = "Enter email",
        text: Binding<String>,
        title: String? = nil,
        variant: TPEInputFieldVariant = .default,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        onCommit: (() -> Void)? = nil
    ) -> TPEInputField {
        TPEInputField(
            text: text,
            title: title,
            placeholder: placeholder,
            variant: variant,
            size: size,
            state: state,
            contentType: .emailAddress,
            icon: "envelope",
            onCommit: onCommit
        )
    }
    
    /// Phone input field
    static func phone(
        _ placeholder: String = "Enter phone number",
        text: Binding<String>,
        title: String? = nil,
        variant: TPEInputFieldVariant = .default,
        size: TPEInputFieldSize = .medium,
        state: TPEInputFieldState = .default,
        onCommit: (() -> Void)? = nil
    ) -> TPEInputField {
        TPEInputField(
            text: text,
            title: title,
            placeholder: placeholder,
            variant: variant,
            size: size,
            state: state,
            contentType: .telephoneNumber,
            icon: "phone",
            onCommit: onCommit
        )
    }
}
