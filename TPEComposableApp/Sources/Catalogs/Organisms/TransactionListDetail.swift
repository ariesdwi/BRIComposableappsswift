//
//  TransactionListDetail.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 20/10/25.
//

import SwiftUI
import TPEHomepageSDK
import TPEComponentSDK

struct TPETransactionSectionDetailView: View {
    @State private var selectedVariant: TransactionVariant = .withHeader
    @State private var showHeader: Bool = true
    @State private var showTransactions: Bool = true
    @State private var transactionCount: Int = 3
    @State private var selectedTransactionStatus: TransactionStatus = .all
    @State private var selectedTransaction: String = ""
    @State private var headerTitle: String = "Aktivitas Terbaru"
    @State private var headerSubtitle: String = "Pantau aktivitas terbarumu di sini"
    
    // Sample transaction data matching your structure
    @State private var transactions: [TpeTransactionItemTw] = [
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
        ),
        TpeTransactionItemTw(
            isLoading: false,
            activityStatus: 2,
            activityTitle: "Electricity Bill",
            activityIcon: "https://example.com/icon-bolt.png",
            activityDate: "Oct 4, 2025",
            activityAmount: "-$89.75",
            activityText: "Monthly utility payment"
        ),
        TpeTransactionItemTw(
            isLoading: false,
            activityStatus: 1,
            activityTitle: "Freelance Payment",
            activityIcon: "https://example.com/icon-briefcase.png",
            activityDate: "Oct 3, 2025",
            activityAmount: "+$1,200.00",
            activityText: "Web design project"
        )
    ]
    
    enum TransactionVariant: String, CaseIterable, Identifiable {
        case withHeader = "With Header"
        case withoutHeader = "Without Header"
        case emptyState = "Empty State"
        case mixedStatus = "Mixed Status"
        case custom = "Custom"
        
        var id: String { rawValue }
        
        var description: String {
            switch self {
            case .withHeader: return "Section with header and transaction list"
            case .withoutHeader: return "Transactions without section header"
            case .emptyState: return "Empty state with no transactions"
            case .mixedStatus: return "Various transaction status types"
            case .custom: return "Customizable transaction section"
            }
        }
        
        var icon: String {
            switch self {
            case .withHeader: return "text.justify.left"
            case .withoutHeader: return "list.bullet"
            case .emptyState: return "rectangle.slash"
            case .mixedStatus: return "arrow.left.arrow.right"
            case .custom: return "slider.horizontal.3"
            }
        }
    }
    
    enum TransactionStatus: String, CaseIterable, Identifiable {
        case all = "All"
        case completed = "Completed"
        case pending = "Pending"
        case failed = "Failed"
        
        var id: String { rawValue }
        
        var statusCode: Int {
            switch self {
            case .all: return 0
            case .completed: return 1
            case .pending: return 2
            case .failed: return 3
            }
        }
    }
    
    var filteredTransactions: [TpeTransactionItemTw] {
        if selectedTransactionStatus == .all {
            return transactions
        } else {
            return transactions.filter { $0.activityStatus == selectedTransactionStatus.statusCode }
        }
    }
    
    var displayedTransactions: [TpeTransactionItemTw] {
        if !showTransactions {
            return []
        }
        return Array(filteredTransactions.prefix(transactionCount))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                HeaderView(
                    title: "Transaction Section",
                    subtitle: "Transaction lists with section headers and empty states"
                )
                
                // Variant Selector
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Section Variants")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(TransactionVariant.allCases.count) variants")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(TransactionVariant.allCases) { variant in
                                TransactionVariantCard(
                                    variant: variant,
                                    isSelected: selectedVariant == variant
                                ) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedVariant = variant
                                        updateVariantSettings(for: variant)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                    }
                }
                
                // Interactive Preview
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Interactive Preview")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("LIVE PREVIEW")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    
                    previewContainer
                }
                
                // Header Customization
                headerCustomizationPanel
                
                // Transaction Settings
                transactionSettingsPanel
                
                // Transaction Filter
                transactionFilterPanel
                
                // Selection Feedback
                if !selectedTransaction.isEmpty {
                    selectionFeedbackSection
                }
                
                // Code Integration
                codeIntegrationSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Transaction Section")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Preview Container
    private var previewContainer: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: selectedVariant.icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
                
                Text(selectedVariant.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("Real-time")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text(selectedVariant.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            // Transaction Section Preview
            TpeTransactionSection(
                sectionHeader: showHeader ? TpeComponentSectionHeader(
                    title: headerTitle,
                    subtitle: headerSubtitle,
                    onTap: {
                        print("Header tapped")
                        selectedTransaction = "Header tapped - \(Date().formatted(date: .omitted, time: .standard))"
                    }
                ) : nil,
                listTransaction: displayedTransactions.isEmpty ? nil : displayedTransactions
            )
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .padding(.vertical, 8)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Header Customization Panel
    private var headerCustomizationPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "text.justify.left")
                    .foregroundColor(.blue)
                
                Text("Header Settings")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle("Show Header", isOn: $showHeader)
                    .font(.system(size: 14))
            }
            
            if showHeader {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    CustomizationCard(
                        icon: "textformat",
                        title: "Header Content",
                        description: "Title and subtitle"
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            CustomTextField("Header Title", text: $headerTitle)
                            CustomTextField("Header Subtitle", text: $headerSubtitle)
                        }
                    }
                    
                    CustomizationCard(
                        icon: "info.circle",
                        title: "Header Info",
                        description: "Header configuration"
                    ) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("TpeComponentSectionHeader")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            Text("Includes tap action handler")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Transaction Settings Panel
    private var transactionSettingsPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "list.bullet")
                    .foregroundColor(.blue)
                
                Text("Transaction Settings")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle("Show Transactions", isOn: $showTransactions)
                    .font(.system(size: 14))
            }
            
            if showTransactions {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    CustomizationCard(
                        icon: "number",
                        title: "Display",
                        description: "Number of transactions"
                    ) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Showing: \(displayedTransactions.count) of \(filteredTransactions.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Stepper("Max Items: \(transactionCount)", value: $transactionCount, in: 1...10)
                        }
                    }
                    
                    CustomizationCard(
                        icon: "info.circle",
                        title: "Transaction Info",
                        description: "Transaction item structure"
                    ) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("TpeTransactionItemTw")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            Text("• activityStatus: Int")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                            
                            Text("• activityTitle: String")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                            
                            Text("• activityAmount: String")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Transaction Filter Panel
    private var transactionFilterPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.blue)
                
                Text("Transaction Filter")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(filteredTransactions.count) transactions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(6)
            }
            
            // Transaction Status Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(TransactionStatus.allCases) { status in
                        FilterChip(
                            title: status.rawValue,
                            count: countForTransactionStatus(status),
                            isSelected: selectedTransactionStatus == status
                        ) {
                            withAnimation {
                                selectedTransactionStatus = status
                            }
                        }
                    }
                }
            }
            
            // Transaction List Preview
            if showTransactions && !displayedTransactions.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Transaction Items Preview")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ForEach(Array(displayedTransactions.enumerated()), id: \.offset) { index, transaction in
                        TransactionPreviewRow(transaction: transaction)
                            .onTapGesture {
                                handleTransactionTap(transaction.activityTitle)
                            }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Selection Feedback Section
    private var selectionFeedbackSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                
                Text("Selection Feedback")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Clear") {
                    selectedTransaction = ""
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            Text("Last tapped: \(selectedTransaction)")
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Code Integration
    private var codeIntegrationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "curlybraces")
                    .foregroundColor(.blue)
                
                Text("Code Integration")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Copy") {
                    UIPasteboard.general.string = codeSnippet
                }
                .font(.caption)
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            
            CodeBlock(code: codeSnippet)
                .frame(height: 400)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private var codeSnippet: String {
        """
import SwiftUI
import TPEComponentSDK

struct ContentView: View {
    var body: some View {
        TpeTransactionSection(\(showHeader ? """
                sectionHeader: TpeComponentSectionHeader(
                    title: "\(headerTitle)",
                    subtitle: "\(headerSubtitle)",
                    onTap: {
                        print("Header tapped")
                    }
                ),
                """ : "")\(showTransactions ? """
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
                    )\(transactions.count > 2 ? ",\n                    // ... \(transactions.count - 2) more transactions" : "")
                ]
                """ : "listTransaction: nil")
        )
    }
}

// Status Codes:
// 1 = Completed
// 2 = Pending  
// 3 = Failed
"""
    }
    
    // MARK: - Helper Methods
    private func updateVariantSettings(for variant: TransactionVariant) {
        switch variant {
        case .withHeader:
            showHeader = true
            showTransactions = true
            transactionCount = 3
            selectedTransactionStatus = .all
            headerTitle = "Aktivitas Terbaru"
            headerSubtitle = "Pantau aktivitas terbarumu di sini"
        case .withoutHeader:
            showHeader = false
            showTransactions = true
            transactionCount = 4
            selectedTransactionStatus = .all
        case .emptyState:
            showHeader = true
            showTransactions = false
            transactionCount = 0
            selectedTransactionStatus = .all
        case .mixedStatus:
            showHeader = true
            showTransactions = true
            transactionCount = 5
            selectedTransactionStatus = .all
            // Ensure we have mixed status transactions
            if !transactions.contains(where: { $0.activityStatus == 2 }) {
                let pendingTransaction = TpeTransactionItemTw(
                    isLoading: false,
                    activityStatus: 2,
                    activityTitle: "Bank Transfer",
                    activityIcon: "https://example.com/icon-transfer.png",
                    activityDate: "Processing",
                    activityAmount: "-$100.00",
                    activityText: "Transfer to friend"
                )
                transactions.insert(pendingTransaction, at: 1)
            }
        case .custom:
            showHeader = true
            showTransactions = true
            transactionCount = 2
            selectedTransactionStatus = .completed
            headerTitle = "Custom Header"
            headerSubtitle = "Custom subtitle here"
        }
    }
    
    private func handleTransactionTap(_ title: String) {
        selectedTransaction = "\(title) - \(Date().formatted(date: .omitted, time: .standard))"
        print("Transaction tapped: \(title)")
    }
    
    private func countForTransactionStatus(_ status: TransactionStatus) -> Int {
        if status == .all {
            return transactions.count
        } else {
            return transactions.filter { $0.activityStatus == status.statusCode }.count
        }
    }
    
    private func statusDescription(for status: Int) -> String {
        switch status {
        case 1: return "Completed"
        case 2: return "Pending"
        case 3: return "Failed"
        default: return "Unknown"
        }
    }
    
    private func statusColor(for status: Int) -> Color {
        switch status {
        case 1: return .green
        case 2: return .orange
        case 3: return .red
        default: return .gray
        }
    }
}

// MARK: - Supporting Views for Transaction Section

struct TransactionVariantCard: View {
    let variant: TPETransactionSectionDetailView.TransactionVariant
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: variant.icon)
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .blue)
                        .frame(width: 24)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(variant.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isSelected ? .white : .primary)
                        .lineLimit(1)
                    
                    Text(variant.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Feature indicators
                VStack(alignment: .leading, spacing: 4) {
                    FeatureIndicator(
                        icon: "text.justify.left",
                        isEnabled: variant == .withHeader || variant == .emptyState || variant == .mixedStatus || variant == .custom
                    )
                    FeatureIndicator(
                        icon: "list.bullet",
                        isEnabled: variant == .withHeader || variant == .withoutHeader || variant == .mixedStatus || variant == .custom
                    )
                    FeatureIndicator(
                        icon: "rectangle.slash",
                        isEnabled: variant == .emptyState
                    )
                }
            }
            .padding(16)
            .frame(width: 160, height: 160)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
    
    private var backgroundColor: Color {
        isSelected ? .blue : Color(.systemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .blue : Color.gray.opacity(0.2)
    }
}

struct TransactionPreviewRow: View {
    let transaction: TpeTransactionItemTw
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon placeholder
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: getSystemIcon(for: transaction.activityTitle))
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(transaction.activityTitle)
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                    
                    Text(transaction.activityAmount)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(transaction.activityAmount.hasPrefix("+") ? .green : .red)
                }
                
                HStack {
                    Text(transaction.activityText)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(transaction.activityDate)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                
                // Status badge
                HStack {
                    Circle()
                        .fill(statusColor(for: transaction.activityStatus))
                        .frame(width: 6, height: 6)
                    
                    Text(statusDescription(for: transaction.activityStatus))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(statusColor(for: transaction.activityStatus))
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func getSystemIcon(for title: String) -> String {
        let lowercased = title.lowercased()
        if lowercased.contains("grocery") || lowercased.contains("store") { return "cart" }
        if lowercased.contains("salary") || lowercased.contains("deposit") { return "dollarsign.circle" }
        if lowercased.contains("netflix") || lowercased.contains("subscription") { return "play.tv" }
        if lowercased.contains("electric") || lowercased.contains("bill") { return "bolt" }
        if lowercased.contains("transfer") { return "arrow.left.arrow.right" }
        return "creditcard"
    }
    
    private func statusDescription(for status: Int) -> String {
        switch status {
        case 1: return "Completed"
        case 2: return "Pending"
        case 3: return "Failed"
        default: return "Unknown"
        }
    }
    
    private func statusColor(for status: Int) -> Color {
        switch status {
        case 1: return .green
        case 2: return .orange
        case 3: return .red
        default: return .gray
        }
    }
}

struct FilterChip: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                
                Text("\(count)")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(isSelected ? Color.white.opacity(0.3) : Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(20)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
