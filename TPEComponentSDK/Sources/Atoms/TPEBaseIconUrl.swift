//
//  e.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEBaseIconUrl: View {
    public let iconUrl: String
    public let size: CGFloat

    @State private var isLoading: Bool = true
    @State private var isError: Bool = false

    public init(iconUrl: String, size: CGFloat = 20) {
        self.iconUrl = iconUrl
        self.size = size
    }

    public var body: some View {
        Group {
            if iconUrl.starts(with: "https") {
                AsyncImage(url: URL(string: iconUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: size, height: size)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)

                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 16, height: 16)
                            .frame(width: size, height: size)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image("TRANSFER_NEW", bundle: .main)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        }
    }
}
