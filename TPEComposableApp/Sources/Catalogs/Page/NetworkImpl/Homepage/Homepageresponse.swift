//
//  Homepageresponse.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 21/10/25.


import Foundation

public struct HomepageResponse: Decodable {
    public let status: Bool
    public let message: String
    public let data: HomepageData
}

public struct HomepageData: Decodable {
    public let projectId: String
    public let header: HomepageHeader?
    public let cardBalanced: CardBalance?
    public let menuItemHorizontal: MenuSection?
    public let menuItemVertical: VerticalMenuSection?
    public let bannerSection: BannerSection?
}

public struct HomepageHeader: Decodable {
    public let leftLogo: HomepageImage?
    public let rightLogo: HomepageImage?
    public let title: String?
    public let subtitle: String?
}

public struct CardBalance: Decodable {
    public let accountNumber: String?
    public let balance: String?
    public let balanceType: String?
    public let images: [HomepageImage]?
}

// MARK: - Menu Sections with Headers
public struct MenuSection: Decodable {
    public let sectionHeader: SectionHeaderHomePage
    public let items: [MenuItemHorizontal]
}

public struct VerticalMenuSection: Decodable {
    public let sectionHeader: SectionHeaderHomePage
    public let items: [TransactionItem]
}

public struct BannerSection: Decodable {
    public let sectionHeader: SectionHeaderHomePage
    public let images: [HomepageImage]
}

// MARK: - Section Header
public struct SectionHeaderHomePage: Decodable {
    public let title: String
    public let subtitle: String
    public let onTap: String
}

// MARK: - Transaction-style Menu Items
public struct TransactionItem: Decodable {
    public let isLoading: Bool
    public let activityStatus: Int
    public let activityTitle: String
    public let activityIcon: String
    public let activityDate: String
    public let activityAmount: String
    public let activityText: String
}

// MARK: - Existing Models (keep these)
public struct MenuItemHorizontal: Decodable {
    public let image: HomepageImage?
    public let title: String?
}

public struct MenuItemVertical: Decodable {
    public let header: MenuHeader?
    public let image: HomepageImage?
    public let title: String?
    public let subtitle1: String?
    public let subtitle2: String?
    public let statusLabel: String?
}

public struct MenuHeader: Decodable {
    public let title: String?
    public let subtitle: String?
    public let buttonIcon: String?
}

public struct HomepageImage: Decodable {
    public let url: String?
    public let alt: String?
}
