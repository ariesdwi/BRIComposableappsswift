//
//  Untitled.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//
import SwiftUI

public struct TPEHomepageBackgroundTw: View {
    public let show: Bool
    public let backgroundColor: Color
    public let imageName: String?

    public init(
        show: Bool = true,
        backgroundColor: Color = Color.blue, // Default same as TPEColors.primaryBlue
        imageName: String? = nil
    ) {
        self.show = show
        self.backgroundColor = backgroundColor
        self.imageName = imageName
    }

    public var body: some View {
        if show {
            ZStack(alignment: .top) {
                backgroundColor
                    .ignoresSafeArea()

                backgroundImage
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var backgroundImage: some View {
        if let imageName = imageName {
            // Custom image from assets
            if let uiImage = UIImage(
                named: imageName,
                in: .tpeComposable,
                with: nil
            ) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 100)
                    .alignmentGuide(.top) { _ in 0 }
                    .padding(.top, 50)
            } else {
                fallbackImage
            }
        } else {
            fallbackImage
        }
    }
    
    private var fallbackImage: some View {
        if let uiImage = UIImage(
            named: "BackgroundPatern",
            in: .tpeComposable,
            with: nil
        ) {
            AnyView(
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 100)
                    .alignmentGuide(.top) { _ in 0 }
                    .padding(.top, 50)
            )
        } else {
            AnyView(
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white.opacity(0.3))
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding(.bottom, 100)
                    .alignmentGuide(.top) { _ in 0 }
                    .padding(.top, 50)
            )
        }
    }
}
private class TPEBundleFinder {}
private extension Bundle {
    static var tpeComposable: Bundle {
        return Bundle(for: TPEBundleFinder.self)
    }
}
