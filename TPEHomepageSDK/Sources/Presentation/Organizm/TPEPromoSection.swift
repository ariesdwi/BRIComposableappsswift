//
//  TPEPromoSection.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

public struct TPEPromoSection: View {
    let sectionHeaderPromo: TpeComponentSectionHeader?
    let promoBannerTw: TpePromoListBannerTw
    
    public init(
        sectionHeaderPromo: TpeComponentSectionHeader? = nil,
        promoBannerTw: TpePromoListBannerTw
    ) {
        self.sectionHeaderPromo = sectionHeaderPromo
        self.promoBannerTw = promoBannerTw
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let sectionHeaderPromo = sectionHeaderPromo {
                sectionHeaderPromo
                Spacer().frame(height: 16)
            }
            
            promoBannerTw
                .padding(.horizontal, 16)
        }
    }
}
