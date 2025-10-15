//
//  TPEMenuListVertical.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

// MARK: - Menu Item Model
public struct TPEMenuItemVertical {
    public let title: String
    public let iconName: String
    public let iconSize: CGFloat
    public let isNew: Bool
    public let onTap: () -> Void

    public init(
        title: String,
        iconName: String,
        iconSize: CGFloat = 40,
        isNew: Bool = false,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.iconName = iconName
        self.iconSize = iconSize
        self.isNew = isNew
        self.onTap = onTap
    }
}

// MARK: - Menu List Vertical with Horizontal Scrolling
public struct TPEMenuListVertical: View {
    let menuItems: [TPEMenuItemVertical]
    let show: Bool
    let spacing: CGFloat
    let itemWidth: CGFloat

    public init(
        menuItems: [TPEMenuItemVertical],
        show: Bool = true,
        spacing: CGFloat = 16,
        itemWidth: CGFloat = 100
    ) {
        self.menuItems = menuItems
        self.show = show
        self.spacing = spacing
        self.itemWidth = itemWidth
    }

    public var body: some View {
        if show {
            VStack(alignment: .leading, spacing: 2) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: spacing) {
                        ForEach(Array(menuItems.enumerated()), id: \.offset) { _, item in
                            TPEHomeMenuItemVertical(
                                title: item.title,
                                iconUrl: nil,
                                circleIcon: AnyView(
                                    Image(systemName: item.iconName)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                ),
                                iconSize: item.iconSize,
                                isNew: item.isNew,
                                onTap: item.onTap
                            )
                            .frame(width: itemWidth)
                        }
                    }
                    .padding(.horizontal, 16)
                }
               
            }
            .padding(.vertical, 8)
        } else {
            EmptyView()
        }
    }
}
