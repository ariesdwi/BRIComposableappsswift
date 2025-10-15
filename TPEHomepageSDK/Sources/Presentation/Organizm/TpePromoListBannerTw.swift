//
//  f.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK


public struct TpePromoListBannerTw: View {
    let promos: [TPEPromoItem]
    let onPromoTap: ((TPEPromoItem) -> Void)?
    
    public init(
        promos: [TPEPromoItem] = [],
        onPromoTap: ((TPEPromoItem) -> Void)? = nil
    ) {
        self.promos = promos
        self.onPromoTap = onPromoTap
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(promos) { promo in
                    TPEPromoBannerCard(
                        promo: promo,
                        onTap: {
                            onPromoTap?(promo)
                        }
                    )
                }
            }
            .padding(.vertical, 8)
        }
        .frame(height: 180) // Fixed height for consistent layout
    }
}
