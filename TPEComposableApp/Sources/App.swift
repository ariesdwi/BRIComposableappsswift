//import SwiftUI
//import TPELoginSDK
//import TPEComponentSDK
//
//@main
//struct TPEComposableApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainAppView()
//        }
//    }
//}
//
//struct MainAppView: View {
//    @State private var selectedTab: AppTab = .designSystem
//    
//    enum AppTab {
//        case designSystem
//        case loginDemo
//    }
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            // Design System Browser Tab
//            DesignSystemBrowser()
//            .tabItem {
//                Image(systemName: "square.grid.2x2")
//                Text("Design System")
//            }
//            .tag(AppTab.designSystem)
//            
//            LoginTemplateCatalogView()
//            .tabItem {
//                Image(systemName: "person.crop.circle")
//                Text("Login")
//            }
//            .tag(AppTab.loginDemo)
//            
//        }
//        .accentColor(.blue)
//    }
//}

import SwiftUI
import TPELoginSDK
import TPEComponentSDK
import TPEHomepageSDK

@main
struct TPEComposableApp: App {
    var body: some Scene {
        WindowGroup {
            RootSelectorView()
        }
    }
}

// MARK: - Root Selector
struct RootSelectorView: View {
    private var isDemoApp: Bool {
        ProcessInfo.processInfo.environment["DEMO_APP"] == "YES"
    }
    private var isDesignSystem: Bool {
        ProcessInfo.processInfo.environment["DESIGN_SYSTEM"] == "YES"
    }

    var body: some View {
        Group {
            if isDemoApp {
                DemoAppRootView()
            } else if isDesignSystem {
                DesignSystemRootView()
            } else {
                VStack(spacing: 12) {
                    Text("⚠️ No active scheme detected.")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Text("Set DEMO_APP or DESIGN_SYSTEM in scheme.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding()
            }
        }
    }
}



