//
//  d.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TpeTransactionItemTw: View {
    public let isLoading: Bool
    public let activityStatus: Int
    public let activityTitle: String
    public let activityIcon: String
    public let activityDate: String
    public let activityAmount: String
    public let activityText: String
    public var onTap: (() -> Void)?

    public init(
        isLoading: Bool,
        activityStatus: Int,
        activityTitle: String,
        activityIcon: String,
        activityDate: String,
        activityAmount: String,
        activityText: String,
        onTap: (() -> Void)? = nil
    ) {
        self.isLoading = isLoading
        self.activityStatus = activityStatus
        self.activityTitle = activityTitle
        self.activityIcon = activityIcon
        self.activityDate = activityDate
        self.activityAmount = activityAmount
        self.activityText = activityText
        self.onTap = onTap
    }

    private var activityColor: [Int: Color] {
        [
            1: Color.green.opacity(0.1),
            2: Color.red.opacity(0.1),
            3: Color.orange.opacity(0.1),
        ]
    }

    private var activityStatusText: [Int: String] {
        [
            1: "Success",
            2: "Failed",
            3: "Pending",
        ]
    }

    private var activityStatusColor: [Int: Color] {
        [
            1: Color.green,
            2: Color.red,
            3: Color.orange,
        ]
    }

    public var body: some View {
        Button(action: { onTap?() }) {
            HStack(alignment: .top, spacing: 12) {
                // Leading Icon
                if isLoading {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .redacted(reason: .placeholder)
                } else {
                    TPEBaseIconUrl(iconUrl: activityIcon, size: 40)
                }

                VStack(alignment: .leading, spacing: 4) {
                    // Title + Status
                    HStack {
                        if isLoading {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 14)
                                .redacted(reason: .placeholder)
                        } else {
                            Text(activityTitle)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                        }

                        Spacer()

                        // Status badge
                        if isLoading {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 68, height: 26)
                                .redacted(reason: .placeholder)
                        } else {
                            Text(activityStatusText[activityStatus] ?? "")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(activityStatusColor[activityStatus])
                                .frame(width: 68, height: 26)
                                .background(activityColor[activityStatus])
                                .cornerRadius(4)
                        }
                    }

                    // Subtitle texts
                    Group {
                        if isLoading {
                            ForEach(0..<3, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 12)
                                    .cornerRadius(4)
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(activityText)
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)

                                Text(activityAmount)
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)

                                Text(activityDate)
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
