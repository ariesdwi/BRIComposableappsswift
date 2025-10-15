//
//  TPEIconButton.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEIconButton: View {
    let iconName: String
    let size: CGFloat
    let action: () -> Void
    
    public init(iconName: String, size: CGFloat = 44, action: @escaping () -> Void) {
        self.iconName = iconName
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: size * 0.5, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: size, height: size)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
