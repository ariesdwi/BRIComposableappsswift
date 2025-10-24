
//
//  HomePageTemplateCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK
import TPEHomepageSDK

struct HomepageTemplateCatalogView: View {
    @State private var selectedTemplate: HomepageTemplate = .default
    @State private var customization = HomepageCustomization()
    @State private var showLiveDemo: Bool = false
    
    enum HomepageTemplate: String, CaseIterable, Identifiable {
        case `default` = "Taiwan Style"
        
        var id: String { rawValue }
        
        var icon: String {
            switch self {
            case .default: return "house.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .default: return .blue
            }
        }
        
        var description: String {
            switch self {
            case .default: return "Curved design with gradient background"
            }
        }
    }
    
    struct HomepageCustomization {
        var showBackgroundImage: Bool = true
        var backgroundImageUrl: String? = ""
        var showHeader: Bool = true
        var showBalanceCard: Bool = true
        var showMenu: Bool = true
        var showTransactions: Bool = true
        var showPromotions: Bool = true
        var userName: String = "John Doe"
        var greeting: String = "Welcome back"
        var singleLineType: Bool = false
        var notificationCount: Int = 3
        var showLogo: Bool = true
        var logoUrl: String? = "https://example.com/logo.png"
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                // Header Section
                headerSection
                    .padding(.bottom, 32)
                
                // Live Preview
                previewSection
                    .padding(.bottom, 32)
                
                // Customization Options
                customizationSection
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Homepage Template")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showLiveDemo) {
            FullScreenHomepageDemo(
                template: selectedTemplate,
                customization: customization
            )
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Homepage Template")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Ready-to-use homepage screen built with TPE Design System")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    StatBadge(count: "1", label: "Template")
                    StatBadge(count: "100%", label: "SwiftUI")
                    StatBadge(count: "Atomic", label: "Design")
                }
            }
            
            // Quick Actions
            HStack(spacing: 12) {
                Button(action: { showLiveDemo = true }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                        Text("Full Screen Demo")
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Spacer()
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Preview Section
    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader(
                title: "Live Preview",
                subtitle: "Interactive template demonstration",
                icon: "play.rectangle.fill"
            )
            
            ZStack {
                // Template Preview
                TPEHomepageTWType(
                    backgroundImageUrl: customization.showBackgroundImage ? customization.backgroundImageUrl : nil,
                    header: customization.showHeader ? sampleHeader : nil,
                    balanceCard: customization.showBalanceCard ? sampleBalanceCard : nil,
                    listMenu: customization.showMenu ? sampleMenu : nil, transactionSection: customization.showTransactions ? sampleTransactionSection : nil,
                    promoSection: customization.showPromotions ? samplePromoSection : nil,
                    onRefreshTap: handleRefresh
                )
              
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // Preview Badge
                VStack {
                    HStack {
                        PreviewBadge()
                        Spacer()
                    }
                    .padding(16)
                    Spacer()
                }
            }
        }
    }
    
    // MARK: - Customization Section
    private var customizationSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader(
                title: "Customization",
                subtitle: "Adjust homepage components",
                icon: "slider.horizontal.3"
            )
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                CustomizationOption(
                    icon: "photo.fill",
                    title: "Appearance",
                    description: "Visual styling"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Background Image", isOn: $customization.showBackgroundImage)
                        
                        if customization.showBackgroundImage {
                            LabeledTextField("Background URL", text: Binding(
                                get: { customization.backgroundImageUrl ?? "" },
                                set: { customization.backgroundImageUrl = $0.isEmpty ? nil : $0 }
                            ))
                        }
                    }
                }
                
                CustomizationOption(
                    icon: "square.grid.2x2.fill",
                    title: "Components",
                    description: "Show/hide sections"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Header", isOn: $customization.showHeader)
                        Toggle("Balance Card", isOn: $customization.showBalanceCard)
                        Toggle("Menu", isOn: $customization.showMenu)
                        Toggle("Transactions", isOn: $customization.showTransactions)
                        Toggle("Promotions", isOn: $customization.showPromotions)
                    }
                }
                
                CustomizationOption(
                    icon: "person.circle.fill",
                    title: "Header Settings",
                    description: "Customize header content"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        LabeledTextField("User Name", text: $customization.userName)
                        LabeledTextField("Greeting", text: $customization.greeting)
                        
                        Stepper("Notification Count: \(customization.notificationCount)",
                               value: $customization.notificationCount, in: 0...99)
                        
                        Toggle("Single Line Type", isOn: $customization.singleLineType)
                        Toggle("Show Logo", isOn: $customization.showLogo)
                        
                        if customization.showLogo {
                            LabeledTextField("Logo URL", text: Binding(
                                get: { customization.logoUrl ?? "" },
                                set: { customization.logoUrl = $0.isEmpty ? nil : $0 }
                            ))
                        }
                    }
                }
                
                CustomizationOption(
                    icon: "bell.badge.fill",
                    title: "Notification Button",
                    description: "Customize circle button"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            CircleButtonPreview(
                                iconName: "bell",
                                badgeCount: customization.notificationCount,
                                showShadow: true
                            )
                            
                            CircleButtonPreview(
                                iconName: "person.circle",
                                badgeCount: 0,
                                showShadow: false
                            )
                            
                            CircleButtonPreview(
                                iconName: "gearshape",
                                badgeCount: 1,
                                showShadow: true
                            )
                        }
                        
                        Text("Tap buttons to test functionality")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    // MARK: - Sample Data
    private var sampleHeader: TPEHeaderComponent {
        TPEHeaderComponent(
            userName: customization.userName,
            greeting: customization.greeting,
            singleLineType: customization.singleLineType,
            notificationCount: customization.notificationCount,
            rightCircleButton: TPECircleIconButton(
                icon: "bell", // Fixed parameter name
                onPressed: { // Fixed parameter name
                    print("Notification button tapped with \(customization.notificationCount) notifications")
                }
            ),
            logoUrl: customization.showLogo ? customization.logoUrl : nil,
            backgroundColor: .clear
        )
    }
    
    private var sampleBalanceCard: TPEBalanceCardTW {
        TPEBalanceCardTW(
            accountNumber: "123456789012",
            currency: "USD",
            currentBalance: 50_000.0,
            isLoading: false,
            accountNumberTextColor: TPEColors.light80,
            currencyTextColor: TPEColors.blue80,
            currentBalanceTextColor: TPEColors.blue80,
            balanceIndicatorColor: TPEColors.blue80,
            toggleColor: TPEColors.blue80,
            copyColor: TPEColors.blue80,
            textBalanceLabelColor: .gray,
            titleBalanceText: "Saldo Rekening Utama",
            backgroundColor: .white,
            backgroundImage: nil, // Fixed: removed invalid image reference
            borderRadius: 20,
            height: 180,
            onSeeAll: {
                print("See all accounts tapped")
            }
        )
    }
    
    private var sampleTransactionSection: TpeTransactionSection {
        TpeTransactionSection(
            sectionHeader: TpeComponentSectionHeader(
                title: "Aktivitas Terbaru",
                subtitle: "Pantau aktivitas terbarumu di sini",
                onTap: { print("Header tapped") }
            ),
            listTransaction: [
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 1,
                    activityTitle: "Grocery Store",
                    activityIcon: "https://example.com/icon-cart.png",
                    activityDate: "Today, 10:30 AM",
                    activityAmount: "-$45.50",
                    activityText: "Purchase at SuperMart"
                ),
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 1,
                    activityTitle: "Salary Deposit",
                    activityIcon: "https://example.com/icon-money.png",
                    activityDate: "Yesterday",
                    activityAmount: "+$2,500.00",
                    activityText: "Monthly salary credited"
                ),
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 3,
                    activityTitle: "Netflix Subscription",
                    activityIcon: "https://example.com/icon-tv.png",
                    activityDate: "Oct 5, 2025",
                    activityAmount: "-$15.99",
                    activityText: "Pending auto-payment"
                )
            ]
        )
    }
    
    private var samplePromoSection: TPEPromoSection {
        TPEPromoSection(
            sectionHeaderPromo: TpeComponentSectionHeader(
                title: "Promo & Cashback",
                subtitle: "Penawaran khusus buat kamu",
                onTap: { print("Header tapped") }
            ),
            promoBannerTw: TpePromoListBannerTw(
                promos: [
                    TPEPromoItem(
                        title: "Cashback 10%",
                        subtitle: "All restaurants this month",
                        imageUrl: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                        validity: "Until Dec 31, 2024",
                        badge: "HOT"
                    ),
                    TPEPromoItem(
                        title: "Free Transfer",
                        subtitle: "Zero fees international",
                        imageUrl: "https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                        validity: "Limited time",
                        badge: "NEW"
                    )
                ]
            )
        )
    }
    
    private var sampleMenu: TPEMenuListHorizontal {
        let menuItems = [
            TPEMenuItemHorizontal(
                title: "Transfer",
                iconUrl: nil, // No URL for fallback
                iconSize: 40,
                isNew: false,
                onTap: {
                   print("")
                }
            ),
            TPEMenuItemHorizontal(
                title: "Pay Bills",
                iconUrl: nil,
                iconSize: 40,
                isNew: false,
                onTap: {
                    print("bills")
                }
            ),
            TPEMenuItemHorizontal(
                title: "Top Up",
                iconUrl: nil,
                iconSize: 40,
                isNew: true,
                onTap: {
                    print("topup")
                }
            ),
            TPEMenuItemHorizontal(
                title: "History",
                iconUrl: nil,
                iconSize: 40,
                isNew: false,
                onTap: {
                    print("history")
                }
            )
        ]
        
        return TPEMenuListHorizontal(
            menuItems: menuItems,
            show: true,
            spacing: 16,
            itemWidth: 100,
            horizontalPadding: 16,
            verticalPadding: 8
        )
    }
    
    // MARK: - Methods
    private func handleRefresh() async {
        // Simulate API call
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("Homepage data refreshed!")
    }
}

// MARK: - Supporting Views
struct CircleButtonPreview: View {
    let iconName: String // Fixed parameter name
    let badgeCount: Int
    let showShadow: Bool
    
    var body: some View {
        TPECircleIconButton(
            icon: iconName, // Fixed parameter name
            onPressed: { // Fixed parameter name
                print("\(iconName) button tapped")
            }
        )
    }
}

struct FullScreenHomepageDemo: View {
    let template: HomepageTemplateCatalogView.HomepageTemplate
    let customization: HomepageTemplateCatalogView.HomepageCustomization
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        TPEHomepageTWType(
            backgroundImageUrl: customization.showBackgroundImage ? customization.backgroundImageUrl : nil,
            header: customization.showHeader ? sampleHeader : nil,
            balanceCard: customization.showBalanceCard ? sampleBalanceCard : nil,
            listMenu: customization.showMenu ? sampleMenu : nil,
            transactionSection: customization.showTransactions ? sampleTransactionSection : nil,
            promoSection: customization.showPromotions ? samplePromoSection : nil,
            onRefreshTap: handleRefresh
        )
        .overlay(
            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(20)
                    }
                    .padding(.top, 60)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
        )
        .statusBar(hidden: true)
    }
    
    private var sampleHeader: TPEHeaderComponent {
        TPEHeaderComponent(
            userName: customization.userName,
            greeting: customization.greeting,
            singleLineType: customization.singleLineType,
            notificationCount: customization.notificationCount,
            rightCircleButton: TPECircleIconButton(
                
                icon: "bell", // Fixed parameter name
                backgroundColor: TPEColors.blue80, onPressed: { // Fixed parameter name
                    print("Notification button tapped with \(customization.notificationCount) notifications")
                }
            ),
            logoUrl: customization.showLogo ? customization.logoUrl : nil,
            backgroundColor: .clear
        )
    }
    
    private var sampleBalanceCard: TPEBalanceCardTW {
        TPEBalanceCardTW(
            accountNumber: "123456789012",
            currency: "USD",
            currentBalance: 50_000.0,
            isLoading: false,
            accountNumberTextColor: TPEColors.light80,
            currencyTextColor: TPEColors.blue80,
            currentBalanceTextColor: TPEColors.blue80,
            balanceIndicatorColor: TPEColors.blue80,
            toggleColor: TPEColors.blue80,
            copyColor: TPEColors.blue80,
            textBalanceLabelColor: .gray,
            titleBalanceText: "Saldo Rekening Utama",
            backgroundColor: .white,
            backgroundImage: nil,
            borderRadius: 20,
            height: 180,
            onSeeAll: {
                print("See all accounts tapped")
            }
        )
    }

    private var sampleTransactionSection: TpeTransactionSection {
        TpeTransactionSection(
            sectionHeader: TpeComponentSectionHeader(
                title: "Aktivitas Terbaru",
                subtitle: "Pantau aktivitas terbarumu di sini",
                onTap: { print("Header tapped") }
            ),
            listTransaction: [
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 1,
                    activityTitle: "Grocery Store",
                    activityIcon: "https://example.com/icon-cart.png",
                    activityDate: "Today, 10:30 AM",
                    activityAmount: "-$45.50",
                    activityText: "Purchase at SuperMart"
                ),
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 1,
                    activityTitle: "Salary Deposit",
                    activityIcon: "https://example.com/icon-money.png",
                    activityDate: "Yesterday",
                    activityAmount: "+$2,500.00",
                    activityText: "Monthly salary credited"
                ),
                TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 3,
                    activityTitle: "Netflix Subscription",
                    activityIcon: "https://example.com/icon-tv.png",
                    activityDate: "Oct 5, 2025",
                    activityAmount: "-$15.99",
                    activityText: "Pending auto-payment"
                )
            ]
        )
    }
    
    private var samplePromoSection: TPEPromoSection {
        TPEPromoSection(
            sectionHeaderPromo: TpeComponentSectionHeader(
                title: "Promo & Cashback",
                subtitle: "Penawaran khusus buat kamu",
                onTap: { print("Header tapped") }
            ),
            promoBannerTw: TpePromoListBannerTw(
                promos: [
                    TPEPromoItem(
                        title: "Weekend Special",
                        subtitle: "Extra rewards points",
                        imageUrl: "https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                        validity: "Every weekend",
                        badge: "POPULAR"
                    ),
                    TPEPromoItem(
                        title: "Free Transfer",
                        subtitle: "Zero fees international",
                        imageUrl: "https://images.unsplash.com/photo-1554224155-6726b3ff858f?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
                        validity: "Limited time",
                        badge: "NEW"
                    )
                ]
            )
        )
    }
    
    private var sampleMenu: TPEMenuListHorizontal {
        let menuItems = [
            TPEMenuItemHorizontal(
                title: "Transfer",
                iconUrl: nil, // No URL for fallback
                iconSize: 40,
                isNew: false,
                onTap: {
                   print("")
                }
            ),
            TPEMenuItemHorizontal(
                title: "Pay Bills",
                iconUrl: nil,
                iconSize: 40,
                isNew: false,
                onTap: {
                    print("bills")
                }
            ),
            TPEMenuItemHorizontal(
                title: "Top Up",
                iconUrl: nil,
                iconSize: 40,
                isNew: true,
                onTap: {
                    print("topup")
                }
            ),
            TPEMenuItemHorizontal(
                title: "History",
                iconUrl: nil,
                iconSize: 40,
                isNew: false,
                onTap: {
                    print("history")
                }
            )
        ]
        
        return TPEMenuListHorizontal(
            menuItems: menuItems,
            show: true,
            spacing: 16,
            itemWidth: 100,
            horizontalPadding: 16,
            verticalPadding: 8
        )
    }
    
    private func handleRefresh() async {
        // Simulate refresh
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("Full screen demo refreshed!")
    }
}
