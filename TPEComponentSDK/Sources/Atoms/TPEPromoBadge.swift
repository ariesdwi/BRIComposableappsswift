//
//  TPEPromoBadge.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEPromoBadge: View {
    let text: String
    let backgroundColor: Color
    
    public init(text: String, backgroundColor: Color = .orange) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .cornerRadius(6)
    }
}
