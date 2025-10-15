//
//  f.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

// Molecules/TPEPromoBannerCard.swift
import SwiftUI

public struct TPEPromoBannerCard: View {
    let promo: TPEPromoItem
    let onTap: () -> Void
    
    public init(promo: TPEPromoItem, onTap: @escaping () -> Void) {
        self.promo = promo
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Promo Image
                ZStack(alignment: .topLeading) {
                    AsyncImage(url: URL(string: promo.imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            RoundedRectangle(cornerRadius: 12)
                                .fill(TPEColors.light10)
                                .frame(width: 280, height: 120)
                                .overlay(
                                    ProgressView()
                                        .scaleEffect(1.2)
                                )
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 280, height: 120)
                                .clipped()
                        case .failure:
                            RoundedRectangle(cornerRadius: 12)
                                .fill(TPEColors.light10)
                                .frame(width: 280, height: 120)
                                .overlay(
                                    VStack(spacing: 8) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 24))
                                            .foregroundColor(.gray)
                                        Text("Promo Image")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .cornerRadius(12)
                    
                    // Badge
                    if let badge = promo.badge {
                        TPEPromoBadge(text: badge, backgroundColor: promo.badgeColor)
                            .padding(8)
                    }
                }
                .frame(width: 280, height: 120)
                
                // Promo Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(promo.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(promo.subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    if let validity = promo.validity {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 10))
                                .foregroundColor(.orange)
                            
                            Text(validity)
                                .font(.system(size: 10))
                                .foregroundColor(.orange)
                                .lineLimit(1)
                        }
                    }
                }
                .frame(width: 280, alignment: .leading)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
