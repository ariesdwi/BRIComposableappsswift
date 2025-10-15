//
//  TPEBadge.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEBadge: View {
    let text: String
    let color: Color
    
    public init(text: String, color: Color = .red) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color)
            .cornerRadius(8)
    }
}
