//
//  ScaleButtonStyle.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {
    let scaleEffect: CGFloat
    let animation: Animation
    
    public init(
        scaleEffect: CGFloat = 0.95,
        animation: Animation = .easeInOut(duration: 0.1)
    ) {
        self.scaleEffect = scaleEffect
        self.animation = animation
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleEffect : 1.0)
            .animation(animation, value: configuration.isPressed)
    }
}

// MARK: - Previews
public struct ScaleButtonStyle_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 20) {
            Button("Default Scale") {
                print("Button tapped")
            }
            .buttonStyle(ScaleButtonStyle())
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Custom Scale") {
                print("Button tapped")
            }
            .buttonStyle(ScaleButtonStyle(scaleEffect: 0.9, animation: .spring()))
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("No Scale") {
                print("Button tapped")
            }
            .buttonStyle(ScaleButtonStyle(scaleEffect: 1.0))
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
