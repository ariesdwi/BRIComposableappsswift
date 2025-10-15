//
//  g.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPETransactionList: View {
    public let listTransaction: [TpeTransactionItemTw]?

    public init(listTransaction: [TpeTransactionItemTw]? = nil) {
        self.listTransaction = listTransaction
    }

    public var body: some View {
        Group {
            if let listTransaction, !listTransaction.isEmpty {
                VStack(spacing: 0) {
                    ForEach(Array(listTransaction.enumerated()), id: \.offset) { index, item in
                        VStack(spacing: 0) {
                            item
                                .padding(.horizontal, 16)

                            // Add divider except after last item
                            if index < listTransaction.count - 1 {
                                Divider()
                                    .background(Color.gray)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            } else {
                Text("No transactions available")
                    .foregroundColor(Color.blue.opacity(0.6)) // Similar to TPEColors.blue60
                    .font(.system(size: 14))
                    .padding(.horizontal, 16)
            }
        }
    }
}
