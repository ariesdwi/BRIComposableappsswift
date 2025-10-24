import Foundation
import TPENetworkingCore
import SwiftUI

// MARK: - ViewModel
@MainActor
final class HomepageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Header
    @Published var headerTitle: String = ""
    @Published var headerSubtitle: String = ""
    @Published var leftLogoUrl: String?
    @Published var rightLogoUrl: String?
    @Published var showHeader: Bool = false
    
    // Balance Card
    @Published var accountNumber: String = ""
    @Published var balanceCardColor: String = "#FFFFFF"
    @Published var currentBalance: String = ""
    @Published var balanceType: String = "IDR"
    @Published var balanceCardImageUrl: String?
    @Published var showBalanceCard: Bool = false
    
    // Menu
    @Published var horizontalMenuHeader: SectionHeaderHomePage?
    @Published var horizontalMenuItems: [MenuItemHorizontal] = []
    @Published var showMenu: Bool = false
    
    // Section Transaction
    @Published var verticalMenuHeader: SectionHeaderHomePage?
    @Published var verticalTransactionItems: [TransactionItem] = []
    @Published var showTransaction: Bool = false
   
    // Promo Section
    @Published var bannerHeader: SectionHeaderHomePage?
    @Published var bannerImages: [HomepageImage] = []
    @Published var showBanner: Bool = false
    
    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    private let useLocalJSON: Bool
    
    init(networkService: NetworkServiceProtocol = NetworkService(), useLocalJSON: Bool = false) {
        self.networkService = networkService
        self.useLocalJSON = useLocalJSON
    }
    
    // MARK: - Fetch Homepage Data
    func fetchHomepageData() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        if useLocalJSON {
            await loadFromLocalJSON()
        } else {
            await loadFromAPI()
        }
    }
    
    private func loadFromLocalJSON() async {
        if let response = JSONFileLoader.loadHomepageData() {
            applyHomepageData(response.data)
            print("✅ Homepage data loaded from local JSON file.")
        } else {
            errorMessage = "Failed to load data from local JSON file"
            applyFallbackData()
        }
    }
    
    private func loadFromAPI() async {
        do {
            let response: HomepageResponse = try await networkService.request(
                HomepageEndpoint.project(id: "BRIMO_ID"),
                expecting: HomepageResponse.self
            )
            applyHomepageData(response.data)
            print("✅ Homepage data fetched from API successfully.")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Failed to load homepage data from API:", error.localizedDescription)
            applyFallbackData()
        }
    }
    
    // MARK: - Apply Homepage Data to UI
    private func applyHomepageData(_ data: HomepageData) {
        // Header
        if let header = data.header {
            headerTitle = header.title ?? "Welcome"
            headerSubtitle = header.subtitle ?? "Enjoy your experience with us"
            leftLogoUrl = convertToFullUrl(header.leftLogo?.url)
            rightLogoUrl = convertToFullUrl(header.rightLogo?.url)
            showHeader = true
        }
        
        // Balance Card
        if let card = data.cardBalanced {
            accountNumber = card.accountNumber ?? ""
            currentBalance = formatBalance(card.balance)
            balanceType = card.balanceType ?? "IDR"
            balanceCardImageUrl = convertToFullUrl(card.images?.first?.url)
            showBalanceCard = !accountNumber.isEmpty && !currentBalance.isEmpty
           
        }
        
        // Horizontal Menu with Section Header
        if let horizontalSection = data.menuItemHorizontal {
            horizontalMenuHeader = horizontalSection.sectionHeader
            horizontalMenuItems = horizontalSection.items
            showMenu = !horizontalMenuItems.isEmpty
        }
        
        // Vertical Menu with Section Header
        if let verticalSection = data.menuItemVertical {
            verticalMenuHeader = verticalSection.sectionHeader
            verticalTransactionItems = verticalSection.items
            showTransaction = !verticalTransactionItems.isEmpty
        }
        
        // Banner Section with Section Header
        if let bannerSection = data.bannerSection {
            bannerHeader = bannerSection.sectionHeader
            bannerImages = bannerSection.images
            showBanner = !bannerImages.isEmpty
        }
    }
    
    // MARK: - Fallback Data
    private func applyFallbackData() {
        headerTitle = "Welcome to UKLN"
        headerSubtitle = "Enjoy your experience with us"
        accountNumber = "17102170003"
        currentBalance = "1,000,000"
        balanceType = "IDR"
        showHeader = true
        showBalanceCard = true
        showMenu = true
        showTransaction = true
        
        // Fallback section headers
        horizontalMenuHeader = SectionHeaderHomePage(
            title: "Quick Actions",
            subtitle: "Frequently used services",
            onTap: "showAllQuickActions"
        )
        verticalMenuHeader = SectionHeaderHomePage(
            title: "All Services",
            subtitle: "Complete list of banking services",
            onTap: "showAllServices"
        )
        bannerHeader = SectionHeaderHomePage(
            title: "Special Promotions",
            subtitle: "Exclusive offers for you",
            onTap: "showAllPromotions"
        )
    }
    
    // MARK: - Helper Methods
    func convertToFullUrl(_ path: String?) -> String? {
        guard let path = path, !path.isEmpty else { return nil }
        if path.hasPrefix("http") {
            return path
        } else {
            return "http://172.24.169.113/strapi" + path
        }
    }
    
    private func formatBalance(_ balance: String?) -> String {
        guard let balance = balance, let amount = Double(balance) else { return "0" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter.string(from: NSNumber(value: amount)) ?? balance
    }
    
    // MARK: - Actions
    func handleRefresh() async {
        await fetchHomepageData()
    }
    
    func handleMenuTap(_ menuType: String) {
        print("🔹 Menu tapped: \(menuType)")
    }
    
    func showAllQuickActions() {
        print("🔹 Show all quick actions tapped")
    }
    
    func showAllServices() {
        print("🔹 Show all services tapped")
    }
    
    func showAllAccounts() {
        print("🔹 Show all accounts tapped")
    }
    
    func showAllTransactions() {
        print("🔹 Show all transactions tapped")
    }
    
    func showAllPromotions() {
        print("🔹 Show all promotions tapped")
    }
    
    func showNotifications() {
        print("🔹 Show notifications tapped")
    }
    
    var showPromotions: Bool {
        return showBanner
    }
}
