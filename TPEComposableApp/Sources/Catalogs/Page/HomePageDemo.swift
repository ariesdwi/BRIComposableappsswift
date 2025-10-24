//
//  BasicHomepageView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK
import TPEHomepageSDK

public struct BasicHomepageView: View {
    @StateObject private var viewModel = HomepageViewModel(useLocalJSON: true)
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    public init() {}
    
    public var body: some View {
        ZStack {
            TPEHomepageTWType(
                backgroundImageUrl: nil,
                header: viewModel.showHeader ? sampleHeader : nil,
                balanceCard: viewModel.showBalanceCard ? sampleBalanceCard : nil,
                listMenu: viewModel.showMenu ? sampleMenu : nil,
                transactionSection: viewModel.showTransaction ? sampleTransactionSection : nil,
                promoSection: viewModel.showPromotions ? samplePromoSection : nil,
                onRefreshTap: {
                    await viewModel.handleRefresh()
                }
            )
            .navigationBarHidden(true)
            
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }
        .task {
            await viewModel.fetchHomepageData()
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "Unknown error occurred")
        }
    }
    
    // MARK: - Dynamic Components from API
    
    private var sampleHeader: TPEHeaderComponent {
        TPEHeaderComponent(
            userName: viewModel.headerTitle,
            greeting: viewModel.headerSubtitle,
            singleLineType: false,
            notificationCount: 0,
            rightCircleButton: TPECircleIconButton(
                icon: "bell",
                backgroundColor: TPEColors.blue80,
                onPressed: {
                    loginViewModel.logout()
                }
            ),
            logoUrl: viewModel.leftLogoUrl,
            backgroundColor: .clear
        )
    }
    
    private var sampleBalanceCard: TPEBalanceCardTW {
        TPEBalanceCardTW(
            accountNumber: viewModel.accountNumber,
            currency: viewModel.balanceType,
            currentBalance: Double(viewModel.currentBalance.replacingOccurrences(of: ",", with: "")) ?? 12321.0,
            isLoading: false,
            accountNumberTextColor: TPEColors.light80,
            currencyTextColor: TPEColors.blue80,
            currentBalanceTextColor: TPEColors.blue80,
            balanceIndicatorColor: TPEColors.blue80,
            toggleColor: TPEColors.blue80,
            copyColor: TPEColors.blue80,
            textBalanceLabelColor: .gray,
            titleBalanceText: "Saldo Rekening Utama",
            backgroundColorHex: viewModel.balanceCardColor, 
            backgroundImage: "viewModel.balanceCardImageUrl",
            borderRadius: 20,
            height: 180,
            onSeeAll: {
                viewModel.handleMenuTap("showAllAccounts")
            }
        )
    }
    
    // MARK: - Horizontal Menu (Quick Actions)
    private var sampleMenu: TPEMenuListHorizontal? {
        guard !viewModel.horizontalMenuItems.isEmpty else { return nil }
        
        let menuItems = viewModel.horizontalMenuItems.map { item in
            TPEMenuItemHorizontal(
                title: item.title ?? "",
                iconUrl: viewModel.convertToFullUrl(item.image?.url),
                iconSize: 40,
                isNew: false,
                onTap: {
                    viewModel.handleMenuTap(item.title?.lowercased() ?? "")
                }
            )
        }
        
        return TPEMenuListHorizontal(
            menuItems: menuItems,
            show: true,
            spacing: 2,
            itemWidth: 100,
            horizontalPadding: 6,
            verticalPadding: 8
        )
    }
    
    
    private var sampleTransactionSection: TpeTransactionSection? {
        guard !viewModel.verticalTransactionItems.isEmpty else { return nil }
        
        let transactionItems = viewModel.verticalTransactionItems.prefix(5).map { item in
            TpeTransactionItemTw(
                isLoading: item.isLoading,
                activityStatus: item.activityStatus,
                activityTitle: item.activityTitle,
                activityIcon: viewModel.convertToFullUrl(item.activityIcon) ?? "",
                activityDate: item.activityDate,
                activityAmount: item.activityAmount,
                activityText: item.activityText
            )
        }
        
        return TpeTransactionSection(
            sectionHeader: TpeComponentSectionHeader(
                title: viewModel.verticalMenuHeader?.title ?? "All Services",
                subtitle: viewModel.verticalMenuHeader?.subtitle ?? "Complete list of banking services",
                onTap: {
                    viewModel.showAllServices()
                }
            ),
            listTransaction: transactionItems
        )
    }
    
    // MARK: - Banner Section (Special Promotions) - UPDATED to match JSON structure
    private var samplePromoSection: TPEPromoSection? {
        guard !viewModel.bannerImages.isEmpty else { return nil }
        
        let promoItems = viewModel.bannerImages.prefix(3).enumerated().map { index, image in
            TPEPromoItem(
                title: "",
                subtitle:  "",
                imageUrl: viewModel.convertToFullUrl(image.url) ?? "",
                validity: "",
                badge: index == 0 ? "NEW" : "HOT"
            )
        }
        
        return TPEPromoSection(
            sectionHeaderPromo: TpeComponentSectionHeader(
                title: viewModel.bannerHeader?.title ?? "Special Promotions",
                subtitle: viewModel.bannerHeader?.subtitle ?? "Exclusive offers for you",
                onTap: {
                    viewModel.handleMenuTap(viewModel.bannerHeader?.onTap ?? "showAllPromotions")
                }
            ),
            promoBannerTw: TpePromoListBannerTw(promos: Array(promoItems))
        )
    }
}
