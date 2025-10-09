//
//import SwiftUI
//import TPELoginSDK
//import TPEComponentSDK
//
//struct DesignSystemBrowser: View {
//    @State private var selectedCategory: Category = .components
//    @State private var searchText: String = ""
//    
//    enum Category: String, CaseIterable {
//        case components = "Components"
//        case templates = "Templates"
//        case foundations = "Foundations"
//        
//        var icon: String {
//            switch self {
//            case .components: return "square.grid.2x2"
//            case .templates: return "rectangle.3.group"
//            case .foundations: return "paintpalette"
//            }
//        }
//    }
//    
//    var filteredItems: [DesignSystemItem] {
//        let items = DesignSystemItem.allItems
//        if searchText.isEmpty {
//            return items.filter { $0.category == selectedCategory }
//        } else {
//            return items.filter {
//                $0.category == selectedCategory &&
//                ($0.title.localizedCaseInsensitiveContains(searchText) ||
//                 $0.subtitle.localizedCaseInsensitiveContains(searchText))
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Background
//                Color(.systemGroupedBackground)
//                    .ignoresSafeArea()
//                
//                ScrollView {
//                    LazyVStack(spacing: 16) {
//                        // Search Bar
//                        SearchBar(text: $searchText)
//                            .padding(.horizontal)
//                        
//                        // Category Picker
//                        CategoryPicker(selectedCategory: $selectedCategory)
//                            .padding(.horizontal)
//                        
//                        // Items Grid
//                        if filteredItems.isEmpty {
//                            EmptyStateView(category: selectedCategory, searchText: searchText)
//                        } else {
//                            LazyVGrid(
//                                columns: [
//                                    GridItem(.flexible()),
//                                    GridItem(.flexible())
//                                ],
//                                spacing: 16
//                            ) {
//                                ForEach(filteredItems) { item in
//                                    DesignSystemCard(item: item)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                    .padding(.vertical)
//                }
//            }
//            .navigationTitle("TPE Design System")
//            .navigationBarTitleDisplayMode(.large)
//        }
//        .navigationViewStyle(.stack)
//    }
//}
//
//// MARK: - Empty State View
//struct EmptyStateView: View {
//    let category: DesignSystemBrowser.Category
//    let searchText: String
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Image(systemName: "magnifyingglass")
//                .font(.system(size: 48))
//                .foregroundColor(.secondary)
//            
//            VStack(spacing: 8) {
//                Text(emptyStateTitle)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.primary)
//                
//                Text(emptyStateSubtitle)
//                    .font(.body)
//                    .foregroundColor(.secondary)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 32)
//            }
//        }
//        .frame(height: 300)
//    }
//    
//    private var emptyStateTitle: String {
//        if !searchText.isEmpty {
//            return "No results found"
//        } else {
//            return "No items in \(category.rawValue)"
//        }
//    }
//    
//    private var emptyStateSubtitle: String {
//        if !searchText.isEmpty {
//            return "Try adjusting your search or browse different categories"
//        } else {
//            return "Check back later for new \(category.rawValue.lowercased())"
//        }
//    }
//}
//
//// MARK: - Search Bar
//struct SearchBar: View {
//    @Binding var text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.secondary)
//            
//            TextField("Search components...", text: $text)
//                .textFieldStyle(PlainTextFieldStyle())
//            
//            if !text.isEmpty {
//                Button(action: { text = "" }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
//        .padding(12)
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
//    }
//}
//
//// MARK: - Category Picker
//struct CategoryPicker: View {
//    @Binding var selectedCategory: DesignSystemBrowser.Category
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 12) {
//                ForEach(DesignSystemBrowser.Category.allCases, id: \.self) { category in
//                    CategoryChip(
//                        category: category,
//                        isSelected: selectedCategory == category
//                    ) {
//                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                            selectedCategory = category
//                        }
//                    }
//                }
//            }
//            .padding(.vertical, 4)
//        }
//    }
//}
//
//struct CategoryChip: View {
//    let category: DesignSystemBrowser.Category
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            HStack(spacing: 8) {
//                Image(systemName: category.icon)
//                    .font(.system(size: 14, weight: .medium))
//                
//                Text(category.rawValue)
//                    .font(.system(size: 14, weight: .medium))
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//            .background(backgroundColor)
//            .foregroundColor(foregroundColor)
//            .cornerRadius(20)
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(borderColor, lineWidth: 1)
//            )
//        }
//        .buttonStyle(ScaleButtonStyle())
//    }
//    
//    private var backgroundColor: Color {
//        isSelected ? .blue : Color(.systemBackground)
//    }
//    
//    private var foregroundColor: Color {
//        isSelected ? .white : .primary
//    }
//    
//    private var borderColor: Color {
//        isSelected ? .blue : Color(.separator)
//    }
//}
//
//// MARK: - Design System Card
//struct DesignSystemCard: View {
//    let item: DesignSystemItem
//    
//    var body: some View {
//        NavigationLink(destination: item.destinationView) {
//            VStack(alignment: .leading, spacing: 12) {
//                // Icon
//                ZStack {
//                    Circle()
//                        .fill(item.category.color.opacity(0.1))
//                        .frame(width: 44, height: 44)
//                    
//                    Image(systemName: item.icon)
//                        .font(.system(size: 18, weight: .medium))
//                        .foregroundColor(item.category.color)
//                }
//                
//                // Content
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(item.title)
//                        .font(.system(size: 16, weight: .semibold))
//                        .foregroundColor(.primary)
//                        .lineLimit(1)
//                    
//                    Text(item.subtitle)
//                        .font(.system(size: 14, weight: .regular))
//                        .foregroundColor(.secondary)
//                        .lineLimit(2)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
//                
//                Spacer()
//                
//                // Badge
//                HStack {
//                    Text(item.category.rawValue)
//                        .font(.system(size: 11, weight: .medium))
//                        .foregroundColor(item.category.color)
//                        .padding(.horizontal, 8)
//                        .padding(.vertical, 4)
//                        .background(item.category.color.opacity(0.1))
//                        .cornerRadius(6)
//                    
//                    Spacer()
//                    
//                    Image(systemName: "chevron.right")
//                        .font(.system(size: 13, weight: .medium))
//                        .foregroundColor(.secondary)
//                }
//            }
//            .padding(16)
//            .background(Color(.systemBackground))
//            .cornerRadius(16)
//            .shadow(
//                color: .black.opacity(0.05),
//                radius: 8,
//                x: 0,
//                y: 2
//            )
//        }
//        .buttonStyle(ScaleButtonStyle())
//    }
//}
//
//// MARK: - Design System Item Model
//struct DesignSystemItem: Identifiable {
//    let id = UUID()
//    let title: String
//    let subtitle: String
//    let icon: String
//    let category: DesignSystemBrowser.Category
//    let destination: Destination
//    
//    enum Destination {
//        case atoms
//        case molecules
//        case organisms
//        case typography
//        case colors
//        case loginTemplate
//        case homepageTemplate
//        case accountTemplate
//        
//        @ViewBuilder
//        var view: some View {
//            switch self {
//            case .atoms: AtomsCatalogView()
//            case .molecules: MoleculesCatalogView()
//            case .organisms: OrganismsCatalogView()
//            case .typography: TypographyCatalogView()
//            case .colors: ColorsCatalogView()
//            case .loginTemplate: LoginTemplateCatalogView()
//            case .homepageTemplate: HomepageTemplateCatalogView()
//            case .accountTemplate: AccountTemplateCatalogView()
//            }
//        }
//    }
//    
//    var destinationView: some View {
//        destination.view
//    }
//    
//    static let allItems: [DesignSystemItem] = [
//        // Foundations
//        DesignSystemItem(
//            title: "Colors",
//            subtitle: "Color palette and usage guidelines",
//            icon: "paintpalette.fill",
//            category: .foundations,
//            destination: .colors
//        ),
//        DesignSystemItem(
//            title: "Typography",
//            subtitle: "Text styles and font hierarchy",
//            icon: "textformat",
//            category: .foundations,
//            destination: .typography
//        ),
//        
//        // Components - Atoms
//        DesignSystemItem(
//            title: "Atoms",
//            subtitle: "Basic building blocks and elements",
//            icon: "atom",
//            category: .components,
//            destination: .atoms
//        ),
//        // Components - Molecules
//        DesignSystemItem(
//            title: "Molecules",
//            subtitle: "Simple component combinations",
//            icon: "circle.hexagongrid",
//            category: .components,
//            destination: .molecules
//        ),
//        
//        // Components - Organisms
//        DesignSystemItem(
//            title: "Organisms",
//            subtitle: "Complex UI sections and patterns",
//            icon: "square.3.layers.3d",
//            category: .components,
//            destination: .organisms
//        ),
//        // Templates
//        DesignSystemItem(
//            title: "Login",
//            subtitle: "Authentication screens and flows",
//            icon: "person.crop.circle.fill",
//            category: .templates,
//            destination: .loginTemplate
//        ),
//        DesignSystemItem(
//            title: "HomePage",
//            subtitle: "Main application overview screens",
//            icon: "chart.bar.fill",
//            category: .templates,
//            destination: .homepageTemplate
//        ),
//        DesignSystemItem(
//            title: "Account",
//            subtitle: "User profile and settings screens",
//            icon: "person.fill",
//            category: .templates,
//            destination: .accountTemplate
//        )
//    ]
//}
//
//extension DesignSystemBrowser.Category {
//    var color: Color {
//        switch self {
//        case .components: return .blue
//        case .templates: return .green
//        case .foundations: return .orange
//        }
//    }
//}
//
//// MARK: - Catalog Views
//
//// Atoms Catalog
//struct AtomsCatalogView: View {
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 24) {
//                // Buttons Section
//                CatalogSection(title: "Buttons", icon: "button.programmable") {
//                    TPEButton(
//                        title: "Primary Button",
//                        variant: .primary,
//                        onPressed: { print("Primary tapped") }
//                    )
//                    
//                    TPEButton(
//                        title: "Secondary Button",
//                        variant: .secondary,
//                        onPressed: { print("Secondary tapped") }
//                    )
//                    
//                    TPEButton(
//                        title: "Disabled Button",
//                        variant: .primary,
//                        isEnabled: false,
//                        onPressed: { print("Disabled tapped") }
//                    )
//                }
//                
//                // Text Section
//                CatalogSection(title: "Typography", icon: "textformat") {
//                    VStack(alignment: .leading, spacing: 12) {
//                        TPEText(
//                            text: "Large Title Text",
//                            variant: .largeTitle,
//                            color: .primary,
//                            textAlignment: .leading
//                        )
//                        
//                        TPEText(
//                            text: "Bold Headline Text",
//                            variant: .text16Bold,
//                            color: .primary,
//                            textAlignment: .leading
//                        )
//                        
//                        TPEText(
//                            text: "Secondary description text",
//                            variant: .secondary,
//                            color: .secondary,
//                            textAlignment: .leading
//                        )
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Atoms")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//// Molecules Catalog
//struct MoleculesCatalogView: View {
//    @State private var formText = ""
//    @State private var searchText = ""
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 24) {
//                // Form Fields
//                CatalogSection(title: "Form Fields", icon: "rectangle.and.pencil.and.ellipsis") {
//                    FormFieldMolecule(
//                        title: "Email Address",
//                        placeholder: "user@example.com",
//                        icon: "envelope.fill",
//                        text: $formText
//                    )
//                    
//                    FormFieldMolecule(
//                        title: "Password",
//                        placeholder: "Enter password",
//                        icon: "lock.fill",
//                        showError: true,
//                        errorMessage: "Password must be at least 8 characters",
//                        text: .constant("")
//                    )
//                }
//                
//                // Button Groups
//                CatalogSection(title: "Button Groups", icon: "square.split.2x1") {
//                    ButtonGroupMolecule(
//                        primaryTitle: "Save Changes",
//                        secondaryTitle: "Cancel",
//                        primaryAction: { print("Save tapped") },
//                        secondaryAction: { print("Cancel tapped") }
//                    )
//                }
//                
//                // Card Headers
//                CatalogSection(title: "Card Headers", icon: "rectangle.inset.filled") {
//                    CardHeaderMolecule(
//                        title: "Profile Settings",
//                        subtitle: "Manage your account preferences",
//                        icon: "person.circle.fill",
//                        actionTitle: "Edit",
//                        action: { print("Edit tapped") }
//                    )
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Molecules")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//// Organisms Catalog
//struct OrganismsCatalogView: View {
//    @State private var showLoginDemo = false
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 24) {
//                // Login Organism
//                CatalogSection(title: "Login Organism", icon: "person.crop.circle.fill") {
//                    VStack(spacing: 16) {
//                        TPEOrganizmLoginTL(
//                            config: LoginConfig(
//                                title: "Welcome Back",
//                                subtitle: "Sign in to your account",
//                                loginText: "Sign In"
//                            ),
//                            cardHeight: 280,
//                            onLoginSuccess: {
//                                print("Login successful!")
//                            },
//                            onRegisterSuccess: {
//                                print("Registration started")
//                            }
//                        )
//                        .frame(height: 320)
//                        
//                        Button("Open Full Screen Demo") {
//                            showLoginDemo = true
//                        }
//                        .buttonStyle(.borderedProminent)
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Organisms")
//        .navigationBarTitleDisplayMode(.large)
//        .fullScreenCover(isPresented: $showLoginDemo) {
//            NavigationView {
//                LoginTemplateCatalogView()
//                    .navigationBarItems(trailing: Button("Close") {
//                        showLoginDemo = false
//                    })
//            }
//        }
//    }
//}
//
//// Colors Catalog
//struct ColorsCatalogView: View {
//    let colorGroups: [(name: String, colors: [(color: Color, name: String)])] = [
//        ("Primary", [
//            (.blue, "Blue"),
//            (.green, "Green"),
//            (.orange, "Orange")
//        ]),
//        ("Neutral", [
//            (.black, "Black"),
//            (.gray, "Gray"),
//            (.white, "White")
//        ]),
//        ("Semantic", [
//            (.red, "Error"),
//            (.green, "Success"),
//            (.orange, "Warning")
//        ])
//    ]
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 24) {
//                ForEach(colorGroups, id: \.name) { group in
//                    CatalogSection(title: group.name, icon: "paintpalette.fill") {
//                        LazyVGrid(columns: [
//                            GridItem(.flexible()),
//                            GridItem(.flexible()),
//                            GridItem(.flexible())
//                        ], spacing: 16) {
//                            ForEach(group.colors, id: \.name) { color in
//                                ColorSwatch(color: color.color, name: color.name)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Colors")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//
//// Template Catalog Views
//struct LoginTemplateCatalogView: View {
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 24) {
//                Text("Login Templates")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                
//                TPEOrganizmLoginTL(
//                    config: LoginConfig(
//                        title: "Welcome to MyApp",
//                        subtitle: "Sign in to access your account",
//                        loginText: "Sign In"
//                    ),
//                    cardHeight: 300,
//                    onLoginSuccess: {
//                        print("Login successful!")
//                    },
//                    onRegisterSuccess: {
//                        print("Registration started")
//                    }
//                )
//                .padding()
//            }
//            .padding()
//        }
//        .navigationTitle("Login Templates")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//
//
//// MARK: - Supporting Components
//
//struct CatalogSection<Content: View>: View {
//    let title: String
//    let icon: String
//    let content: Content
//    
//    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
//        self.title = title
//        self.icon = icon
//        self.content = content()
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            HStack {
//                Image(systemName: icon)
//                    .foregroundColor(.blue)
//                
//                Text(title)
//                    .font(.headline)
//                    .fontWeight(.semibold)
//                
//                Spacer()
//            }
//            
//            content
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
//    }
//}
//
//struct ColorSwatch: View {
//    let color: Color
//    let name: String
//    
//    var body: some View {
//        VStack(spacing: 8) {
//            color
//                .frame(height: 60)
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
//                )
//            
//            Text(name)
//                .font(.system(size: 12, weight: .medium))
//                .foregroundColor(.primary)
//        }
//    }
//}
//
//// MARK: - Button Styles
//struct ScaleButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
//            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
//    }
//}
//
//// MARK: - Text Variant Extension
//extension TPETextVariant {
//    var name: String {
//        switch self {
//        case .largeTitle: return "Large Title"
//        case .title1: return "Title 1"
//        case .title2: return "Title 2"
//        case .text16Bold: return "Headline"
//        case .text16Regular: return "Body"
//        case .caption: return "Caption"
//        case .secondary: return "Secondary"
//        @unknown default: return "Unknown"
//        }
//    }
//}
//
//// MARK: - Previews
//#Preview("Design System Browser") {
//    DesignSystemBrowser()
//}
//
//#Preview("Dark Mode") {
//    DesignSystemBrowser()
//        .preferredColorScheme(.dark)
//}
//
//#Preview("Atoms Catalog") {
//    NavigationView {
//        AtomsCatalogView()
//    }
//}
//
//#Preview("Molecules Catalog") {
//    NavigationView {
//        MoleculesCatalogView()
//    }
//}
