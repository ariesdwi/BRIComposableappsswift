//
//  TPEBalanceDisplay.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEBalanceDisplay: View {
    let currency: String
    let balance: String
    let isVisible: Bool
    
    public init(currency: String, balance: String, isVisible: Bool = true) {
        self.currency = currency
        self.balance = balance
        self.isVisible = isVisible
    }
    
    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(currency)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            
            Text(isVisible ? balance : "•••••")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
