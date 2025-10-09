//
//  TPELinkText.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI

public struct TPELinkText: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    public init(text: String, color: Color, onTap action: @escaping () -> Void) {
        self.text = text
        self.color = color
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(color)
                .underline()
        }
    }
}
