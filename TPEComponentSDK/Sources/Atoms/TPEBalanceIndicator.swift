//
//  TPEBallanceIndicator.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

// Atoms/.swift
import SwiftUI

public struct TPEBalanceIndicator: View {
    let color: Color
    let itemCount: Int
    
    public init(
        color: Color = TPEColors.blue80,
        itemCount: Int = 5
    ) {
        self.color = color
        self.itemCount = itemCount
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<itemCount, id: \.self) { _ in
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
            }
        }
    }
}
