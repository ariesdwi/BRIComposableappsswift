////
////  TPEBalanceCardTW.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 15/10/25.
////
//
//import SwiftUI
//import TPEComponentSDK
//
//public struct TPEBalanceCardTW: View {
//    let accountNumber: String
//    let currency: String
//    let currentBalance: Double
//    let isLoading: Bool
//    
//    // Customization properties
//    let accountNumberTextColor: Color?
//    let currencyTextColor: Color?
//    let currentBalanceTextColor: Color?
//    let balanceIndicatorColor: Color?
//    let toggleColor: Color?
//    let copyColor: Color?
//    let textBalanceLabelColor: Color?
//    let titleBalanceText: String?
//    let backgroundColor: Color
//    let backgroundImage: String?
//    let padding: EdgeInsets
//    let margin: EdgeInsets
//    let borderRadius: CGFloat
//    let showDivider: Bool
//    let onSeeAll: (() -> Void)?
//    
//    @State private var balanceVisible = false
//    
//    public init(
//        accountNumber: String,
//        currency: String,
//        currentBalance: Double,
//        isLoading: Bool = false,
//        accountNumberTextColor: Color? = nil,
//        currencyTextColor: Color? = nil,
//        currentBalanceTextColor: Color? = nil,
//        balanceIndicatorColor: Color? = nil,
//        toggleColor: Color? = nil,
//        copyColor: Color? = nil,
//        textBalanceLabelColor: Color? = nil,
//        titleBalanceText: String? = nil,
//        backgroundColor: Color = TPEColors.white,
//        backgroundImage: String? = nil,
//        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
//        margin: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
//        borderRadius: CGFloat = 16,
//        showDivider: Bool = true,
//        onSeeAll: (() -> Void)? = nil
//    ) {
//        self.accountNumber = accountNumber
//        self.currency = currency
//        self.currentBalance = currentBalance
//        self.isLoading = isLoading
//        self.accountNumberTextColor = accountNumberTextColor
//        self.currencyTextColor = currencyTextColor
//        self.currentBalanceTextColor = currentBalanceTextColor
//        self.balanceIndicatorColor = balanceIndicatorColor
//        self.toggleColor = toggleColor
//        self.copyColor = copyColor
//        self.textBalanceLabelColor = textBalanceLabelColor
//        self.titleBalanceText = titleBalanceText
//        self.backgroundColor = backgroundColor
//        self.backgroundImage = backgroundImage
//        self.padding = padding
//        self.margin = margin
//        self.borderRadius = borderRadius
//        self.showDivider = showDivider
//        self.onSeeAll = onSeeAll
//    }
//    
//    public var body: some View {
//        TPEBaseBalanceCard(
//            backgroundImage: backgroundImage ?? "assets/images/Taiwan_card_image_2.png",
//            backgroundColor: backgroundColor,
//            padding: padding,
//            margin: margin,
//            borderRadius: borderRadius
//        ) {
//            VStack(alignment: .leading, spacing: 0) {
//                // Account Number Row
//                HStack {
//                    Text(formatAccountNumber(accountNumber))
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(accountNumberTextColor ?? TPEColors.light80)
//                    
//                    Spacer()
//                    
//                    TPECopyButton(
//                        textColor: copyColor,
//                        textToCopy: accountNumber,
//                        copyText: "Salin",
//                        successMessage: "Nomor rekening disalin"
//                    )
//                }
//                
//                Spacer().frame(height: 8)
//                
//                // Divider
//                if showDivider {
//                    Divider()
//                        .background(TPEColors.light20)
//                        .frame(height: 1)
//                    
//                    Spacer().frame(height: 8)
//                }
//                
//                // Balance Label
//                if let titleBalanceText = titleBalanceText {
//                    Text(titleBalanceText)
//                        .font(.system(size: 12))
//                        .foregroundColor(textBalanceLabelColor ?? .gray)
//                } else {
//                    Text("Saldo Rekening Utama")
//                        .font(.system(size: 12))
//                        .foregroundColor(textBalanceLabelColor ?? .gray)
//                }
//                
//                Spacer().frame(height: 8)
//                
//                // Balance Row
//                HStack(spacing: 8) {
//                    Text(currency)
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(currencyTextColor ?? TPEColors.blue80)
//                    
//                    if balanceVisible {
//                        Text(formatBalance(currentBalance))
//                            .font(.system(size: 20, weight: .bold))
//                            .foregroundColor(currentBalanceTextColor ?? TPEColors.blue80)
//                    } else {
//                        TPEBalanceIndicator(
//                            color: balanceIndicatorColor ?? TPEColors.blue80
//                        )
//                    }
//                    
//                    Spacer()
//                    
//                    TPEEyeToggleButton(
//                        visible: balanceVisible,
//                        color: toggleColor ?? TPEColors.blue80
//                    ) {
//                        balanceVisible.toggle()
//                    }
//                }
//                
//                // See All Button
//                if let onSeeAll = onSeeAll {
//                    Spacer().frame(height: 8)
//                    
//                    Button(action: onSeeAll) {
//                        HStack {
//                            Text("See All")
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(.blue)
//                            
//                            Image(systemName: "chevron.right")
//                                .font(.system(size: 12, weight: .medium))
//                                .foregroundColor(.blue)
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    private func formatAccountNumber(_ accountNumber: String) -> String {
//        // Format: **** 1234
//        let cleaned = accountNumber.replacingOccurrences(of: " ", with: "")
//        if cleaned.count > 4 {
//            let lastFour = String(cleaned.suffix(4))
//            return "**** \(lastFour)"
//        }
//        return accountNumber
//    }
//    
//    private func formatBalance(_ balance: Double) -> String {
//        return String(format: "%.2f", balance)
//    }
//}


//
//  TPEBalanceCardTW.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

public struct TPEBalanceCardTW: View {
    // MARK: - Parameters
    let accountNumber: String
    let currency: String
    let currentBalance: Double
    let isLoading: Bool
    
    // Customization properties
    let accountNumberTextColor: Color?
    let currencyTextColor: Color?
    let currentBalanceTextColor: Color?
    let balanceIndicatorColor: Color?
    let toggleColor: Color?
    let copyColor: Color?
    let textBalanceLabelColor: Color?
    let titleBalanceText: String?
    let backgroundColor: Color
    let backgroundImage: String?
    let padding: EdgeInsets
    let margin: EdgeInsets
    let borderRadius: CGFloat
    let height: CGFloat?                // ✅ Added custom height
    let width: CGFloat?                 // ✅ Optional width support
    let showDivider: Bool
    let onSeeAll: (() -> Void)?
    
    @State private var balanceVisible = false
    
    // MARK: - Init
    public init(
        accountNumber: String,
        currency: String,
        currentBalance: Double,
        isLoading: Bool = false,
        accountNumberTextColor: Color? = nil,
        currencyTextColor: Color? = nil,
        currentBalanceTextColor: Color? = nil,
        balanceIndicatorColor: Color? = nil,
        toggleColor: Color? = nil,
        copyColor: Color? = nil,
        textBalanceLabelColor: Color? = nil,
        titleBalanceText: String? = nil,
        backgroundColor: Color = TPEColors.white,
        backgroundImage: String? = nil,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        margin: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        borderRadius: CGFloat = 16,
        height: CGFloat? = nil,              // ✅ Added
        width: CGFloat? = nil,               // ✅ Added
        showDivider: Bool = true,
        onSeeAll: (() -> Void)? = nil
    ) {
        self.accountNumber = accountNumber
        self.currency = currency
        self.currentBalance = currentBalance
        self.isLoading = isLoading
        self.accountNumberTextColor = accountNumberTextColor
        self.currencyTextColor = currencyTextColor
        self.currentBalanceTextColor = currentBalanceTextColor
        self.balanceIndicatorColor = balanceIndicatorColor
        self.toggleColor = toggleColor
        self.copyColor = copyColor
        self.textBalanceLabelColor = textBalanceLabelColor
        self.titleBalanceText = titleBalanceText
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.padding = padding
        self.margin = margin
        self.borderRadius = borderRadius
        self.height = height
        self.width = width
        self.showDivider = showDivider
        self.onSeeAll = onSeeAll
    }
    
    // MARK: - Body
    public var body: some View {
        TPEBaseBalanceCard(
            backgroundColor: backgroundColor,
            backgroundImage: backgroundImage ?? "assets/images/Taiwan_card_image_2.png",
            borderRadius: borderRadius,
            width: width,
            height: height,        // ✅ Custom height applied here
            padding: padding,
            margin: margin
        ) {
            VStack(alignment: .leading, spacing: 0) {
                // Account Number Row
                HStack {
                    Text(formatAccountNumber(accountNumber))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(accountNumberTextColor ?? TPEColors.light80)
                    
                    Spacer()
                    
                    TPECopyButton(
                        textColor: copyColor,
                        textToCopy: accountNumber,
                        copyText: "Salin",
                        successMessage: "Nomor rekening disalin"
                    )
                }
                
                Spacer().frame(height: 8)
                
                // Divider
                if showDivider {
                    Divider()
                        .background(TPEColors.light20)
                        .frame(height: 1)
                    Spacer().frame(height: 8)
                }
                
                // Balance Label
                Text(titleBalanceText ?? "Saldo Rekening Utama")
                    .font(.system(size: 12))
                    .foregroundColor(textBalanceLabelColor ?? .gray)
                
                Spacer().frame(height: 8)
                
                // Balance Row
                HStack(spacing: 8) {
                    Text(currency)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(currencyTextColor ?? TPEColors.blue80)
                    
                    if balanceVisible {
                        Text(formatBalance(currentBalance))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(currentBalanceTextColor ?? TPEColors.blue80)
                    } else {
                        TPEBalanceIndicator(
                            color: balanceIndicatorColor ?? TPEColors.blue80
                        )
                    }
                    
                    Spacer()
                    
                    TPEEyeToggleButton(
                        visible: balanceVisible,
                        color: toggleColor ?? TPEColors.blue80
                    ) {
                        balanceVisible.toggle()
                    }
                }
                
                // See All Button
                if let onSeeAll = onSeeAll {
                    Spacer().frame(height: 8)
                    Button(action: onSeeAll) {
                        HStack {
                            Text("See All")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func formatAccountNumber(_ accountNumber: String) -> String {
        let cleaned = accountNumber.replacingOccurrences(of: " ", with: "")
        if cleaned.count > 4 {
            let lastFour = String(cleaned.suffix(4))
            return "**** \(lastFour)"
        }
        return accountNumber
    }
    
    private func formatBalance(_ balance: Double) -> String {
        String(format: "%.2f", balance)
    }
}
