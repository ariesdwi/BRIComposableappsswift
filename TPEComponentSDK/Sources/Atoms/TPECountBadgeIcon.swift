//
//  TPEBadgeIcon.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPECountBadgeIcon: View {
    let badgeCount: Int
    let badgeSize: CGFloat
    let badgeColor: Color
    let badgeTextColor: Color
    
    public init(
        badgeCount: Int,
        badgeSize: CGFloat = 17,
        badgeColor: Color = .red,
        badgeTextColor: Color = .white
    ) {
        self.badgeCount = badgeCount
        self.badgeSize = badgeSize
        self.badgeColor = badgeColor
        self.badgeTextColor = badgeTextColor
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(badgeColor)
                .frame(width: badgeSize, height: badgeSize)
            
            Text(badgeText)
                .font(.system(size: badgeSize * 0.5, weight: .bold))
                .foregroundColor(badgeTextColor)
                .minimumScaleFactor(0.5)
        }
    }
    
    private var badgeText: String {
        if badgeCount > 99 {
            return "99+"
        } else {
            return "\(badgeCount)"
        }
    }
}
