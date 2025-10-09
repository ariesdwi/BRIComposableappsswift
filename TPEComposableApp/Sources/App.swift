import SwiftUI
import TPELoginSDK
import TPEComponentSDK

@main
struct TPEComposableApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
        }
    }
}

struct MainAppView: View {
    @State private var selectedTab: AppTab = .designSystem
    
    enum AppTab {
        case designSystem
        case loginDemo
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Design System Browser Tab
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
