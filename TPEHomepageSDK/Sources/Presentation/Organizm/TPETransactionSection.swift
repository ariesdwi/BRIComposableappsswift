////
////  TPETransactionSection.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 15/10/25.
////



import SwiftUI
import TPEComponentSDK

public struct TpeTransactionSection: View {
    public let sectionHeader: TpeComponentSectionHeader?
    public let listTransaction: [TpeTransactionItemTw]?

    public init(
        sectionHeader: TpeComponentSectionHeader? = nil,
        listTransaction: [TpeTransactionItemTw]? = nil
    ) {
        self.sectionHeader = sectionHeader
        self.listTransaction = listTransaction
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let sectionHeader {
                sectionHeader
            }

            if let transactions = listTransaction, !transactions.isEmpty {
                TPETransactionList(listTransaction: transactions)
            } else {
                Text("Tidak ada transaksi")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
            }
        }
    }
}

