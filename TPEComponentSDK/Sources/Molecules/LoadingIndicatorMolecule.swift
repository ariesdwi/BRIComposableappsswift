//
//  LoadingIndicator.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct LoadingIndicatorMolecule: View {
    let title: String?
    let subtitle: String?
    let showProgress: Bool
    let progress: Double?
    let size: LoadingSize
    let style: LoadingStyle
    let isLoading: Bool
    
    public enum LoadingSize {
        case small, medium, large
        
        var spinnerSize: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 30
            case .large: return 40
            }
        }
        
        var textSize: Font {
            switch self {
            case .small: return .caption
            case .medium: return .body
            case .large: return .title3
            }
        }
    }
    
    public enum LoadingStyle {
        case `default`, minimal, card, fullScreen
        
        var backgroundColor: Color {
            switch self {
            case .default, .minimal: return .clear
            case .card: return Color(.systemBackground)
            case .fullScreen: return Color.black.opacity(0.7)
            }
        }
        
        var showBackground: Bool {
            switch self {
            case .minimal: return false
            case .default, .card, .fullScreen: return true
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .default, .minimal: return 0
            case .card: return 12
            case .fullScreen: return 0
            }
        }
        
        var padding: EdgeInsets {
            switch self {
            case .minimal: return EdgeInsets()
            case .default: return EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            case .card: return EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
            case .fullScreen: return EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0)
            }
        }
    }
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        showProgress: Bool = false,
        progress: Double? = nil,
        size: LoadingSize = .medium,
        style: LoadingStyle = .default,
        isLoading: Bool = true
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showProgress = showProgress
        self.progress = progress
        self.size = size
        self.style = style
        self.isLoading = isLoading
    }
    
    public var body: some View {
        if isLoading {
            Group {
                if style == .fullScreen {
                    fullScreenContent
                } else {
                    regularContent
                }
            }
        } else {
            EmptyView()
        }
    }
    
    private var regularContent: some View {
        HStack(spacing: 16) {
            // Loading Indicator
            if showProgress, let progress = progress {
                ProgressView(value: progress)
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: size.spinnerSize, height: size.spinnerSize)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: size.spinnerSize, height: size.spinnerSize)
            }
            
            // Text Content
            if title != nil || subtitle != nil {
                VStack(alignment: .leading, spacing: 4) {
                    if let title = title {
                        Text(title)
                            .font(size.textSize)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding(style.padding)
        .background(style.showBackground ? style.backgroundColor : Color.clear)
        .cornerRadius(style.cornerRadius)
        .shadow(
            color: style == .card ? .black.opacity(0.1) : .clear,
            radius: style == .card ? 8 : 0,
            x: 0,
            y: style == .card ? 2 : 0
        )
    }
    
    private var fullScreenContent: some View {
        VStack(spacing: 20) {
            // Loading Indicator
            if showProgress, let progress = progress {
                ProgressView(value: progress)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: size.spinnerSize, height: size.spinnerSize)
                    .scaleEffect(1.5)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: size.spinnerSize, height: size.spinnerSize)
                    .scaleEffect(1.5)
            }
            
            // Text Content
            VStack(spacing: 8) {
                if let title = title {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(style.backgroundColor)
        .ignoresSafeArea()
    }
}

// MARK: - Convenience Initializers
public extension LoadingIndicatorMolecule {
    /// Minimal loading indicator with just a spinner
    static func minimal(size: LoadingSize = .medium, isLoading: Bool = true) -> LoadingIndicatorMolecule {
        LoadingIndicatorMolecule(size: size, style: .minimal, isLoading: isLoading)
    }
    
    /// Card style loading indicator
    static func card(title: String, subtitle: String? = nil, size: LoadingSize = .medium, isLoading: Bool = true) -> LoadingIndicatorMolecule {
        LoadingIndicatorMolecule(title: title, subtitle: subtitle, size: size, style: .card, isLoading: isLoading)
    }
    
    /// Full screen loading overlay
    static func fullScreen(title: String? = nil, subtitle: String? = nil, isLoading: Bool = true) -> LoadingIndicatorMolecule {
        LoadingIndicatorMolecule(title: title, subtitle: subtitle, size: .large, style: .fullScreen, isLoading: isLoading)
    }
    
    /// Progress loading with percentage
    static func progress(title: String, progress: Double, subtitle: String? = nil, isLoading: Bool = true) -> LoadingIndicatorMolecule {
        LoadingIndicatorMolecule(title: title, subtitle: subtitle, showProgress: true, progress: progress, size: .medium, style: .default, isLoading: isLoading)
    }
    
    /// Simple loading with just title
    static func simple(_ title: String, isLoading: Bool = true) -> LoadingIndicatorMolecule {
        LoadingIndicatorMolecule(title: title, isLoading: isLoading)
    }
}

// MARK: - Usage Examples
#Preview {
    VStack(spacing: 20) {
        // Minimal
        LoadingIndicatorMolecule.minimal()
        
        // Default with text
        LoadingIndicatorMolecule(
            title: "Loading...",
            subtitle: "Please wait a moment"
        )
        
        // Card style
        LoadingIndicatorMolecule.card(
            title: "Processing Payment",
            subtitle: "This may take a few seconds"
        )
        
        // With progress
        LoadingIndicatorMolecule.progress(
            title: "Downloading",
            progress: 0.65,
            subtitle: "65% completed"
        )
        
        // Different sizes
        HStack(spacing: 16) {
            LoadingIndicatorMolecule.minimal(size: .small)
            LoadingIndicatorMolecule.minimal(size: .medium)
            LoadingIndicatorMolecule.minimal(size: .large)
        }
        
        // Disabled state
        LoadingIndicatorMolecule.simple("Not Loading", isLoading: false)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
    .padding()
}

#Preview("Full Screen Loading") {
    LoadingIndicatorMolecule.fullScreen(
        title: "Authenticating",
        subtitle: "Please wait while we verify your credentials"
    )
}

#Preview("Interactive Demo") {
    struct InteractiveDemo: View {
        @State private var isLoading = true
        @State private var progress = 0.3
        
        var body: some View {
            VStack(spacing: 20) {
                LoadingIndicatorMolecule(
                    title: "Processing Data",
                    subtitle: "This may take a moment",
                    showProgress: true,
                    progress: progress,
                    isLoading: isLoading
                )
                
                Toggle("Show Loading", isOn: $isLoading)
                
                if isLoading {
                    VStack {
                        Text("Progress: \(Int(progress * 100))%")
                            .font(.caption)
                        Slider(value: $progress, in: 0...1)
                    }
                }
                
                Button("Simulate Load") {
                    isLoading = true
                    progress = 0.0
                    
                    // Simulate progress
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        progress += 0.1
                        if progress >= 1.0 {
                            timer.invalidate()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isLoading = false
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
    
    return InteractiveDemo()
}
