//
//  ScaleButtonVIew.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//


import SwiftUI

/// A customizable button style that provides scale feedback with various animation options
public struct ScaleButtonStyle: ButtonStyle {
    let scale: CGFloat
    let duration: Double
    let animation: Animation
    let hapticFeedback: HapticFeedback?
    
    /// Initialize with custom parameters
    public init(
        scale: CGFloat = 0.95,
        duration: Double = 0.15,
        animation: Animation = .easeInOut(duration: 0.15),
        hapticFeedback: HapticFeedback? = .light
    ) {
        self.scale = scale
        self.duration = duration
        self.animation = animation
        self.hapticFeedback = hapticFeedback
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 17.0, *) {
            configuration.label
                .scaleEffect(configuration.isPressed ? scale : 1.0)
                .animation(animation, value: configuration.isPressed)
                .onChange(of: configuration.isPressed) { _, isPressed in
                    if isPressed {
                        hapticFeedback?.trigger()
                    }
                }
        } else {
            // Fallback on earlier versions
        }
    }
}

// MARK: - Haptic Feedback
public extension ScaleButtonStyle {
    /// Haptic feedback types for button interactions
    enum HapticFeedback {
        case light
        case medium
        case heavy
        case rigid
        case soft
        case selection
        case success
        case warning
        case error
        case custom(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle)
        
        func trigger() {
            switch self {
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            case .rigid:
                let generator = UIImpactFeedbackGenerator(style: .rigid)
                generator.impactOccurred()
            case .soft:
                let generator = UIImpactFeedbackGenerator(style: .soft)
                generator.impactOccurred()
            case .selection:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            case .custom(let style):
                let generator = UIImpactFeedbackGenerator(style: style)
                generator.impactOccurred()
            }
        }
    }
}

// MARK: - Predefined Style Variants
public extension ScaleButtonStyle {
    /// Subtle button style with light haptic feedback
    static var subtle: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.98, hapticFeedback: .light)
    }
    
    /// Standard button style with medium haptic feedback
    static var standard: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.95, hapticFeedback: .medium)
    }
    
    /// Prominent button style with heavy haptic feedback
    static var prominent: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.92, hapticFeedback: .heavy)
    }
    
    /// Bouncy button style with spring animation
    static var bouncy: ScaleButtonStyle {
        ScaleButtonStyle(
            scale: 0.9,
            animation: .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.2),
            hapticFeedback: .rigid
        )
    }
    
    /// Smooth button style with longer duration
    static var smooth: ScaleButtonStyle {
        ScaleButtonStyle(
            scale: 0.96,
            duration: 0.25,
            animation: .easeInOut(duration: 0.25),
            hapticFeedback: .soft
        )
    }
    
    /// Minimal button style without haptic feedback
    static var minimal: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.97, hapticFeedback: nil)
    }
    
    /// Success button style with success haptic
    static var success: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.94, hapticFeedback: .success)
    }
    
    /// Destructive button style with error haptic
    static var destructive: ScaleButtonStyle {
        ScaleButtonStyle(scale: 0.93, hapticFeedback: .error)
    }
}

// MARK: - Custom Modifiers
public extension Button {
    /// Applies a scale button style with custom parameters
    func scaleButtonStyle(
        scale: CGFloat = 0.95,
        duration: Double = 0.15,
        animation: Animation = .easeInOut(duration: 0.15),
        hapticFeedback: ScaleButtonStyle.HapticFeedback? = .light
    ) -> some View {
        self.buttonStyle(
            ScaleButtonStyle(
                scale: scale,
                duration: duration,
                animation: animation,
                hapticFeedback: hapticFeedback
            )
        )
    }
}

// MARK: - View Extension for Easy Application
public extension View {
    /// Applies a predefined scale button style
    func withScaleButtonStyle(_ style: ScaleButtonStyle = .standard) -> some View {
        self.buttonStyle(style)
    }
}

