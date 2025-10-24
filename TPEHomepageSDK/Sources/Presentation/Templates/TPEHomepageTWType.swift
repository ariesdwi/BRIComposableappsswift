
//  TPEHomepageTWType.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//


import SwiftUI
import TPEComponentSDK

struct RefreshableScrollView<Content: View>: View {
    let onRefresh: () async -> Void
    let content: Content

    public init(
        onRefresh: @escaping () async -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.onRefresh = onRefresh
        self.content = content()
    }

    public var body: some View {
        if #available(iOS 16.0, *) {
            ScrollView(.vertical, showsIndicators: false) {
                content
            }
            .refreshable { await onRefresh() }
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                content
            }
        }
    }
}



public struct FlipRoundedTopShape: Shape {
    public enum Mood {
        case smile     // 😄 Curve downward
        case neutral   // 😐 Flat line
        case sad       // 🙁 Curve upward
    }
    
    public var mood: Mood
    
    public init(mood: Mood = .neutral) {
        self.mood = mood
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let curveStartY = rect.height * 0.3
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: curveStartY))
        
        switch mood {
        case .smile:
            // Curve dips downward (smile)
            path.addQuadCurve(
                to: CGPoint(x: rect.width, y: curveStartY),
                control: CGPoint(x: rect.width / 2, y: rect.height * 0.5)
            )
            
        case .neutral:
            // Straight line (neutral)
            path.addLine(to: CGPoint(x: rect.width, y: curveStartY))
            
        case .sad:
            // Curve goes upward (sad)
            path.addQuadCurve(
                to: CGPoint(x: rect.width, y: curveStartY),
                control: CGPoint(x: rect.width / 2, y: rect.height * -0.1)
            )
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}


public struct TPEHomepageTWType: View {
    let backgroundImageUrl: String?
    let header: TPEHeaderComponent?
    let balanceCard: TPEBalanceCardTW?
    let transactionSection: TpeTransactionSection?
    let promoSection: TPEPromoSection?
    let listMenu: TPEMenuListHorizontal?
    let onRefreshTap: () async -> Void

    public init(
        backgroundImageUrl: String? = nil,
        header: TPEHeaderComponent? = nil,
        balanceCard: TPEBalanceCardTW? = nil,
        listMenu: TPEMenuListHorizontal? = nil,
        transactionSection: TpeTransactionSection? = nil,
        promoSection: TPEPromoSection? = nil,
        onRefreshTap: @escaping () async -> Void
    ) {
        self.backgroundImageUrl = backgroundImageUrl
        self.header = header
        self.balanceCard = balanceCard
        self.transactionSection = transactionSection
        self.promoSection = promoSection
        self.listMenu = listMenu
        self.onRefreshTap = onRefreshTap
    }

    public var body: some View {
        ZStack(alignment: .top) {
            // Background (Top Half)
            GeometryReader { geometry in
                TPEHomepageBackgroundTw(
                    backgroundColor: TPEColors.primaryBlue
                )
                .frame(height: geometry.size.height * 0.5)
                .ignoresSafeArea()
            }

            VStack(spacing: 0) {
                // Header / App Bar - WITH CLEAR BACKGROUND
                if let header = header {
                    if #available(iOS 17.0, *) {
                        VStack {
                            // Add safe area padding for notch devices
                            Color.clear
                                .frame(height: 16)
                                .ignoresSafeArea()
                            
                            header
                                .padding(.leading, 16)
                                .padding(.trailing, 6)
                                .padding(.bottom, 16)
                                .padding(.top, 16)
                        }
                        .background(Color.clear) // CHANGED: Clear background
                    } else {
                        // Fallback on earlier versions
                        header
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                            .background(Color.clear) // CHANGED: Clear background
                    }
                } else {
                    Spacer().frame(height: 22)
                }

                // Scrollable Body
                RefreshableScrollView(onRefresh: onRefreshTap) {
                    VStack(spacing: 0) {
                        ZStack(alignment: .top) {
                            FlipRoundedTopShape(mood: .smile)
                                .fill(Color.white)
                                .frame(height: 250)
                                .shadow(radius: 5)
                                .padding(.top, 50)

                            VStack(alignment: .leading, spacing: 0) {
                                // Balance Card
                                if let balanceCard = balanceCard {
                                    balanceCard
                                }

                                // Main Content Area
                                VStack(spacing: 0) {
                                    if let listMenu = listMenu {
                                        listMenu
                                    }
                                    Divider()
                                        .frame(height: 14)
                                        .background(TPEColors.light10)

                                    if let transactionSection = transactionSection {
                                        transactionSection
                                    }

                                    Divider()
                                        .frame(height: 14)
                                        .background(TPEColors.light10)

                                    if let promoSection = promoSection {
                                        promoSection
//
                                    }

                                }
                                .background(Color.white)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.clear)
        .ignoresSafeArea()
    }
}
