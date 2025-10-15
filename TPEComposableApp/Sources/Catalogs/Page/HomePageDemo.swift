////
////  HomePageDemo.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 15/10/25.
////
//
//
//import SwiftUI
//import TPEComponentSDK
//import TPEHomepageSDK
//
//struct FullScreenHomepageDemo: View {
//    let template: HomepageTemplateCatalogView.HomepageTemplate
//    let customization: HomepageTemplateCatalogView.HomepageCustomization
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        TPEHomepageTWType(
//            backgroundImageUrl: customization.showBackgroundImage ? customization.backgroundImageUrl : nil,
//            header: customization.showHeader ? sampleHeader : nil,
//            balanceCard: customization.showBalanceCard ? sampleBalanceCard : nil,
//            transactionSection: customization.showTransactions ? sampleTransactionSection : nil,
//            promoSection: customization.showPromotions ? samplePromoSection : nil,
//            listMenu: customization.showMenu ? sampleMenu : nil,
//            onRefreshTap: handleRefresh
//        )
//        .overlay(
//            // Close button
//            VStack {
//                HStack {
//                    Spacer()
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.system(size: 30))
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.3))
//                            .cornerRadius(20)
//                    }
//                    .padding(.top, 60)
//                    .padding(.trailing, 20)
//                }
//                Spacer()
//            }
//        )
//        .statusBar(hidden: true)
//    }
//    
//    private var sampleHeader: TPEHeaderComponent {
//        TPEHeaderComponent(
//            title: "My Bank",
//            subtitle: "Welcome back!",
//            trailingIcons: ["bell", "person.circle"]
//        )
//    }
//    
//    private var sampleBalanceCard: TPEBalanceCardTW {
//        TPEBalanceCardTW(
//            balance: "75,230",
//            currency: "USD",
//            accountNumber: "**** 5678"
//        )
//    }
//    
//    private var sampleTransactionSection: TPETransactionSection {
//        TPETransactionSection(
//            transactions: [
//                TPETransaction(
//                    title: "Coffee Shop",
//                    subtitle: "Today, 08:15 AM",
//                    amount: "-$5.75",
//                    icon: "cup.and.saucer",
//                    color: .brown,
//                    amountColor: .red
//                )
//            ]
//        )
//    }
//    
//    private var samplePromoSection: TPEPromoSection {
//        TPEPromoSection(
//            sectionHeaderPromo: TPEComponentSectionHeader(
//                title: "Latest Promotions",
//                actionText: "View All"
//            ),
//            promoBannerTw: TpePromoListBannerTw(
//                promos: [
//                    TPEPromoItem(
//                        title: "Weekend Special",
//                        subtitle: "Extra rewards points",
//                        imageUrl: "https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
//                        validity: "Every weekend",
//                        badge: "POPULAR"
//                    )
//                ]
//            )
//        )
//    }
//    
//    private var sampleMenu: TPEMenuListVertical {
//        TPEMenuListVertical(
//            menuItems: [
//                TPEMenuItem(title: "Quick Transfer", icon: "bolt.horizontal", color: .blue),
//                TPEMenuItem(title: "Bill Payment", icon: "creditcard", color: .green),
//                TPEMenuItem(title: "Mobile Topup", icon: "iphone", color: .orange),
//                TPEMenuItem(title: "Transaction History", icon: "list.bullet", color: .purple)
//            ]
//        )
//    }
//    
//    private func handleRefresh() async {
//        // Simulate refresh
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        print("Full screen demo refreshed!")
//    }
//}
