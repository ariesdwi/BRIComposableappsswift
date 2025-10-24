//
//  HeaderComponentDetailView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//

// MARK: - Header Component Detail View
import SwiftUI
import TPEHomepageSDK
import TPEComponentSDK

struct TPEHeaderComponentDetailView: View {
    @State private var selectedVariant: HeaderVariant = .default
    @State private var userName: String = "John Doe"
    @State private var greeting: String = "Welcome"
    @State private var notificationCount: Int = 5
    @State private var singleLineType: Bool = true
    @State private var showLogo: Bool = true
    @State private var showNotification: Bool = true
    @State private var showRightButton: Bool = true
    
    // Customization properties
    @State private var backgroundColor: Color = .blue
    @State private var cornerRadius: CGFloat = 0
    @State private var shadowRadius: CGFloat = 0
    @State private var shadowColor: Color = .clear
    
    enum HeaderVariant: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case gradient = "Gradient"
        case minimal = "Minimal"
        case withNotification = "With Notification"
        case twoLine = "Two Line"
        case custom = "Custom"
        
        var id: String { rawValue }
        
        var description: String {
            switch self {
            case .default: return "Standard header with basic styling"
            case .gradient: return "Header with gradient background"
            case .minimal: return "Clean minimal design"
            case .withNotification: return "Header with notification badge"
            case .twoLine: return "Two-line greeting layout"
            case .custom: return "Fully customizable header"
            }
        }
        
        var icon: String {
            switch self {
            case .default: return "rectangle.fill"
            case .gradient: return "paintbrush.fill"
            case .minimal: return "minus"
            case .withNotification: return "bell.badge.fill"
            case .twoLine: return "text.line.first.and.arrowtriangle.forward"
            case .custom: return "slider.horizontal.3"
            }
        }
        
        var config: HeaderConfig {
            switch self {
            case .default:
                return HeaderConfig(
                    backgroundColor: .blue,
                    backgroundGradient: nil,
                    cornerRadius: 0,
                    shadowRadius: 0
                )
            case .gradient:
                return HeaderConfig(
                    backgroundColor: .clear,
                    backgroundGradient: LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    cornerRadius: 0,
                    shadowRadius: 4
                )
            case .minimal:
                return HeaderConfig(
                    backgroundColor: .clear,
                    backgroundGradient: nil,
                    cornerRadius: 0,
                    shadowRadius: 0
                )
            case .withNotification:
                return HeaderConfig(
                    backgroundColor: .indigo,
                    backgroundGradient: nil,
                    cornerRadius: 0,
                    shadowRadius: 2
                )
            case .twoLine:
                return HeaderConfig(
                    backgroundColor: .green,
                    backgroundGradient: nil,
                    cornerRadius: 0,
                    shadowRadius: 0
                )
            case .custom:
                return HeaderConfig(
                    backgroundColor: .orange,
                    backgroundGradient: nil,
                    cornerRadius: 12,
                    shadowRadius: 8
                )
            }
        }
    }
    
    struct HeaderConfig {
        let backgroundColor: Color
        let backgroundGradient: LinearGradient?
        let cornerRadius: CGFloat
        let shadowRadius: CGFloat
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Header Component",
                    subtitle: "Customizable header with user greeting and actions"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Header Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(HeaderVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(HeaderVariant.allCases) { variant in
                                HeaderVariantCard(
                                    variant: variant,
                                    isSelected: selectedVariant == variant
                                ) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedVariant = variant
                                        updateVariantSettings(for: variant)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                    }
                }
                
                // Interactive Preview
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Interactive Preview")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("LIVE PREVIEW")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    
                    previewContainer
                }
                
                // Content Customization
                contentCustomizationPanel
                
                // Appearance Customization
                if selectedVariant == .custom {
                    appearanceCustomizationPanel
                }
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Header Component")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Preview Container
    private var previewContainer: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.orange)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("Real-time")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text(selectedVariant.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Header Preview
            TPEHeaderComponent(
                userName: userName,
                greeting: greeting,
                singleLineType: selectedVariant == .twoLine ? false : singleLineType,
                notificationCount: showNotification ? notificationCount : nil,
                rightCircleButton: showRightButton ? TPECircleIconButton(
                    icon: "bell",
                    size: 44, iconColor: .white,
                    backgroundColor: .white.opacity(0.2),
                    onPressed: {
                        print("Notification button tapped")
                    }
                ) : nil,
                logoUrl: showLogo ? "https://via.placeholder.com/44" : nil,
                backgroundColor: selectedVariant.config.backgroundColor,
                backgroundGradient: selectedVariant.config.backgroundGradient,
                cornerRadius: selectedVariant == .custom ? cornerRadius : selectedVariant.config.cornerRadius,
                shadowColor: shadowColor,
                shadowRadius: selectedVariant == .custom ? shadowRadius : selectedVariant.config.shadowRadius
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Content Customization Panel
    private var contentCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "person.text.rectangle")
                    .foregroundColor(.orange)
                
                Text("Content Customization")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationCard(
                    icon: "person",
                    title: "User Info",
                    description: "User name and greeting"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        CustomTextField("User Name", text: $userName)
                        CustomTextField("Greeting", text: $greeting)
                        
                        if selectedVariant != .twoLine {
                            Toggle("Single Line", isOn: $singleLineType)
                        }
                    }
                }
                
                CustomizationCard(
                    icon: "bell",
                    title: "Features",
                    description: "Additional elements"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Show Logo", isOn: $showLogo)
                        Toggle("Show Right Button", isOn: $showRightButton)
                        
                        if showRightButton {
                            Toggle("Show Notification", isOn: $showNotification)
                            
                            if showNotification {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Notification Count: \(notificationCount)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Stepper("", value: $notificationCount, in: 0...99)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Appearance Customization Panel
    private var appearanceCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "paintbrush")
                    .foregroundColor(.orange)
                
                Text("Appearance Customization")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationCard(
                    icon: "paintpalette",
                    title: "Background",
                    description: "Colors and gradients"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        ColorPicker("Background Color", selection: $backgroundColor)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Corner Radius: \(Int(cornerRadius))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $cornerRadius, in: 0...20, step: 2)
                        }
                    }
                }
                
                CustomizationCard(
                    icon: "shadow",
                    title: "Shadow",
                    description: "Shadow effects"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        ColorPicker("Shadow Color", selection: $shadowColor)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Shadow Radius: \(Int(shadowRadius))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Slider(value: $shadowRadius, in: 0...20, step: 1)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Code Integration
    private var codeIntegrationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "curlybraces")
                    .foregroundColor(.orange)
                
                Text("Code Integration")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Copy") {
                    UIPasteboard.general.string = codeSnippet
                }
                .font(.caption)
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            
            CodeBlock(code: codeSnippet)
                .frame(height: 250)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private var codeSnippet: String {
        """
import SwiftUI
import TPEComponentSDK

struct ContentView: View {
    var body: some View {
        VStack {
            TPEHeaderComponent(
                userName: "\(userName)",
                greeting: "\(greeting)",\(selectedVariant == .twoLine ? "\n                singleLineType: false," : singleLineType ? "" : "\n                singleLineType: false,")\(showNotification ? "\n                notificationCount: \(notificationCount)," : "")\(showRightButton ? """
                rightCircleButton: TPECircleIconButton(
                    iconName: "bell",
                    iconColor: .white,
                    backgroundColor: .white.opacity(0.2),
                    size: 44,
                    onTap: {
                        print("Notification button tapped")
                    }
                ),
                """ : "")\(showLogo ? "\n                logoUrl: \"https://via.placeholder.com/44\"," : "")\(selectedVariant == .gradient ? """
                backgroundGradient: LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                """ : selectedVariant != .default && selectedVariant != .gradient ? "\n                backgroundColor: .\(selectedVariant == .withNotification ? "indigo" : selectedVariant == .twoLine ? "green" : "orange")," : "")\(selectedVariant == .custom ? "\n                backgroundColor: .orange," : "")\(selectedVariant == .custom && cornerRadius > 0 ? "\n                cornerRadius: \(Int(cornerRadius))," : "")\(selectedVariant == .custom && shadowRadius > 0 ? "\n                shadowRadius: \(Int(shadowRadius))," : "")
                shadowColor: \(shadowColor == .clear ? ".clear" : ".black.opacity(0.3)")
            )
            
            // Your content here
            Spacer()
        }
    }
}
"""
    }
    
    // MARK: - Helper Methods
    private func updateVariantSettings(for variant: HeaderVariant) {
        switch variant {
        case .default:
            userName = "John Doe"
            greeting = "Welcome"
            singleLineType = true
            showLogo = true
            showRightButton = true
            showNotification = true
            notificationCount = 5
        case .gradient:
            userName = "Sarah Smith"
            greeting = "Good morning"
            singleLineType = true
            showLogo = true
            showRightButton = true
            showNotification = false
        case .minimal:
            userName = "Alex Johnson"
            greeting = "Hi"
            singleLineType = true
            showLogo = false
            showRightButton = false
            showNotification = false
        case .withNotification:
            userName = "Mike Wilson"
            greeting = "Hello"
            singleLineType = true
            showLogo = true
            showRightButton = true
            showNotification = true
            notificationCount = 12
        case .twoLine:
            userName = "Emily Davis"
            greeting = "Good afternoon"
            singleLineType = false
            showLogo = true
            showRightButton = true
            showNotification = true
            notificationCount = 3
        case .custom:
            userName = "Custom User"
            greeting = "Custom Greeting"
            singleLineType = true
            showLogo = true
            showRightButton = true
            showNotification = true
            notificationCount = 7
            backgroundColor = .orange
            cornerRadius = 12
            shadowRadius = 8
            shadowColor = .black.opacity(0.3)
        }
    }
}

// MARK: - Supporting Views for Header Component

struct HeaderVariantCard: View {
    let variant: TPEHeaderComponentDetailView.HeaderVariant
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: variant.icon)
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .orange)
                        .frame(width: 24)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(variant.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .primary)
                        .lineLimit(1)
                    
                    Text(variant.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Feature indicators
                VStack(alignment: .leading, spacing: 4) {
                    FeatureIndicator(icon: "person", isEnabled: true)
                    FeatureIndicator(icon: "text.bubble", isEnabled: true)
                    
                    switch variant {
                    case .gradient:
                        FeatureIndicator(icon: "paintbrush", isEnabled: true)
                    case .minimal:
                        FeatureIndicator(icon: "minus", isEnabled: true)
                    case .withNotification:
                        FeatureIndicator(icon: "bell", isEnabled: true)
                    case .twoLine:
                        FeatureIndicator(icon: "text.justify", isEnabled: true)
                    case .custom:
                        FeatureIndicator(icon: "slider.horizontal.3", isEnabled: true)
                    default:
                        FeatureIndicator(icon: "star", isEnabled: true)
                    }
                }
            }
            .padding(16)
            .frame(width: 160, height: 160)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var backgroundColor: Color {
        isSelected ? .orange : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .orange : Color.gray.opacity(0.2)
    }
}

struct FeatureIndicator: View {
    let icon: String
    let isEnabled: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 8))
                .foregroundColor(isEnabled ? .green : .gray)
            
            Text(isEnabled ? "Enabled" : "Disabled")
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(isEnabled ? .green : .gray)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(isEnabled ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(4)
    }
}

