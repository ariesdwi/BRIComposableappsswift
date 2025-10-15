//
//  TPEEyeToggleButton.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

// Atoms/TPEEyeToggleButton.swift
import SwiftUI

public struct TPEEyeToggleButton: View {
    let visible: Bool
    let color: Color
    let onTap: () -> Void
    
    public init(
        visible: Bool,
        color: Color = TPEColors.blue80,
        onTap: @escaping () -> Void
    ) {
        self.visible = visible
        self.color = color
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap) {
            Image(systemName: visible ? "eye.slash" : "eye")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(color)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
