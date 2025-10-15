//
//  f.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TpeComponentSectionHeader: View {
    public let title: String
    public let subtitle: String
    public let leadingIcon: TPEBaseIconUrl?
    public let trailingIcon: AnyView?
    public let onTap: (() -> Void)?

    public init(
        title: String,
        subtitle: String,
        leadingIcon: TPEBaseIconUrl? = nil,
        trailingIcon: AnyView? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: { onTap?() }) {
            HStack(alignment: .center, spacing: 0) {
                if let leadingIcon {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.89, green: 0.95, blue: 0.99)) // #E3F2FD
                                .frame(width: 36, height: 36)

                            leadingIcon
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.trailing, 12)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if let trailingIcon {
                    trailingIcon
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color(red: 0.89, green: 0.95, blue: 0.99)))
                        .clipShape(Circle())
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color(red: 0.89, green: 0.95, blue: 0.99)))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
