//
//  TPEBaseBalanceCard.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEBaseBalanceCard<Content: View>: View {
    let content: Content
    let backgroundColor: Color
    let backgroundImage: String?
    let borderRadius: CGFloat
    let width: CGFloat?
    let height: CGFloat?
    let padding: EdgeInsets
    let margin: EdgeInsets?
    let onTap: (() -> Void)?
    
    public init(
        backgroundColor: Color = .white,
        backgroundImage: String? = nil,
        borderRadius: CGFloat = 16,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        margin: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        onTap: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.borderRadius = borderRadius
        self.width = width
        self.height = height
        self.padding = padding
        self.margin = margin
        self.onTap = onTap
        self.content = content()
    }
    
    public var body: some View {
        Group {
            if let onTap = onTap {
                buttonWrapper(action: onTap)
            } else {
                cardBody
            }
        }
        .padding(margin ?? EdgeInsets())
    }
    
    @ViewBuilder
    private func buttonWrapper(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            cardBody
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var cardBody: some View {
        ZStack {
            backgroundColor
            
            if let image = backgroundImage {
                if image.starts(with: "http"), let url = URL(string: image) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let img):
                            img
                                .resizable()
                                .scaledToFill()
                        default:
                            Color.clear
                        }
                    }
                } else {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
            }
            
            content
                .padding(padding)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: borderRadius))
        .contentShape(RoundedRectangle(cornerRadius: borderRadius))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4) // ✅ Default shadow
    }
}



