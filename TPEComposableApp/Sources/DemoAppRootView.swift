import SwiftUI
import TPELoginSDK
import TPEHomepageSDK

struct DemoAppRootView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if loginViewModel.isUserLoggedIn() {
                    // ✅ Show homepage when logged in
                    BasicHomepageView()
                        .environmentObject(loginViewModel) // Pass viewModel for logout functionality
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                } else {
                    // ✅ Show login page when not logged in
                    LoginDemoView()
                        .environmentObject(loginViewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                }
            }
            .animation(.easeInOut(duration: 0.4), value: loginViewModel.isUserLoggedIn())
        }
    }
}


