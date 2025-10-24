
//  TPEMenuListHorizontal.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

// MARK: - Menu Item Model (Updated for JSON)
public struct TPEMenuItemHorizontal {
    public let title: String
    public let iconUrl: String?
    public let iconSize: CGFloat
    public let isNew: Bool
    public let onTap: () -> Void

    public init(
        title: String,
        iconUrl: String? = nil,
        iconSize: CGFloat = 40,
        isNew: Bool = false,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.iconUrl = iconUrl
        self.iconSize = iconSize
        self.isNew = isNew
        self.onTap = onTap
    }
}

// MARK: - Menu List Horizontal with Horizontal Scrolling
public struct TPEMenuListHorizontal: View {
    let menuItems: [TPEMenuItemHorizontal]
    let show: Bool
    let spacing: CGFloat
    let itemWidth: CGFloat
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat

    public init(
        menuItems: [TPEMenuItemHorizontal],
        show: Bool = true,
        spacing: CGFloat = 16,
        itemWidth: CGFloat = 100,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 8
    ) {
        self.menuItems = menuItems
        self.show = show
        self.spacing = spacing
        self.itemWidth = itemWidth
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }

    public var body: some View {
        if show && !menuItems.isEmpty {
            VStack(alignment: .leading, spacing: 2) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: spacing) {
                        ForEach(Array(menuItems.enumerated()), id: \.offset) { index, item in
                            TPEHomeMenuItemVertical(
                                title: item.title,
                                iconUrl: item.iconUrl,
                                circleIcon: nil, // Use iconUrl instead of SF Symbols
                                iconSize: item.iconSize,
                                isNew: item.isNew,
                                onTap: item.onTap
                            )
                            .frame(width: itemWidth)
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                }
            }
            .padding(.vertical, verticalPadding)
        } else {
            EmptyView()
        }
    }
}


// MARK: - Configuration
public struct TPEMenuListConfig {
    public let spacing: CGFloat
    public let itemWidth: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    
    public static let `default` = TPEMenuListConfig(
        spacing: 16,
        itemWidth: 100,
        horizontalPadding: 16,
        verticalPadding: 8
    )
    
    public init(
        spacing: CGFloat = 16,
        itemWidth: CGFloat = 100,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 8
    ) {
        self.spacing = spacing
        self.itemWidth = itemWidth
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
}
