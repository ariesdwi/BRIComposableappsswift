//
//  DesignSystemRootView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 21/10/25.
//


import SwiftUI
import TPELoginSDK
import TPEComponentSDK



struct DesignSystemRootView: View {
    @State private var selectedTab: AppTab = .designSystem

    public enum AppTab {
        case designSystem
        case loginDemo
    }

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
            DesignSystemBrowser()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Design System")
                }
                .tag(AppTab.designSystem)

            LoginTemplateCatalogView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Login")
                }
                .tag(AppTab.loginDemo)
        }
        .accentColor(.blue)
    }
}

