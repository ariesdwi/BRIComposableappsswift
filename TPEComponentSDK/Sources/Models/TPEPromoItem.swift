//
//  d.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

// Models/TPEPromoItem.swift
import SwiftUI

public struct TPEPromoItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let imageUrl: String
    public let validity: String?
    public let badge: String?
    public let badgeColor: Color
    public let terms: String?
    
    public init(
        title: String,
        subtitle: String,
        imageUrl: String,
        validity: String? = nil,
        badge: String? = nil,
        badgeColor: Color = .orange,
        terms: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.validity = validity
        self.badge = badge
        self.badgeColor = badgeColor
        self.terms = terms
    }
}
