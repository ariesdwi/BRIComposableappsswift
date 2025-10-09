//
//  SearchBar.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

//
//  SearchBar.swift
//  TPEComposable
//
//  Created by Your Name
//

import SwiftUI

/// A customizable search bar component with clear button and search icon
public struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    let onCommit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    /// Initialize search bar with optional commit action
    public init(
        text: Binding<String>,
        placeholder: String = "Search...",
        onCommit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = onCommit
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.secondary)
                .symbolRenderingMode(.hierarchical)
            
            // Text Field
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit {
                    onCommit?()
                }
            
            // Clear Button
            if !text.isEmpty {
                Button(action: clearText) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.secondary)
                        .symbolRenderingMode(.hierarchical)
                        .transition(.scale.combined(with: .opacity))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: text.isEmpty)
        .onTapGesture {
            isFocused = true
        }
    }
    
    private func clearText() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            text = ""
        }
        isFocused = true
    }
    
    private var borderColor: Color {
        isFocused ? .blue.opacity(0.8) : Color(.separator)
    }
}

// MARK: - Search Bar Variants
public extension SearchBar {
    /// Search bar without clear button animation
    static func simple(
        text: Binding<String>,
        placeholder: String = "Search..."
    ) -> SearchBar {
        SearchBar(text: text, placeholder: placeholder, onCommit: nil)
    }
    
    /// Search bar with search submission handler
    static func withSubmission(
        text: Binding<String>,
        placeholder: String = "Search...",
        onSubmit: @escaping () -> Void
    ) -> SearchBar {
        SearchBar(text: text, placeholder: placeholder, onCommit: onSubmit)
    }
}

// MARK: - Search Bar with Scope
public struct SearchBarWithScope<Scope: Hashable & CaseIterable>: View where Scope.AllCases: RandomAccessCollection {
    @Binding var text: String
    @Binding var scope: Scope
    let placeholder: String
    let scopeTitle: String
    
    public init(
        text: Binding<String>,
        scope: Binding<Scope>,
        placeholder: String = "Search...",
        scopeTitle: String = "Filter"
    ) {
        self._text = text
        self._scope = scope
        self.placeholder = placeholder
        self.scopeTitle = scopeTitle
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Search Bar
            SearchBar(text: $text, placeholder: placeholder)
            
            // Scope Picker
            if let allCases = Scope.allCases as? [Scope] {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Text(scopeTitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        ForEach(allCases, id: \.self) { scopeCase in
                            ScopeChip(
                                title: "\(scopeCase)",
                                isSelected: scope == scopeCase
                            ) {
                                withAnimation(.spring(response: 0.3)) {
                                    scope = scopeCase
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
        }
    }
}

// MARK: - Scope Chip
struct ScopeChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
        .buttonStyle(ScaleButtonStyle(scale: 0.96))
    }
    
    private var backgroundColor: Color {
        isSelected ? .blue : Color(.systemBackground)
    }
    
    private var foregroundColor: Color {
        isSelected ? .white : .primary
    }
    
    private var borderColor: Color {
        isSelected ? .blue : Color(.separator)
    }
}

// MARK: - Previews
#Preview("Basic Search Bar") {
    struct SearchBarPreview: View {
        @State private var searchText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                SearchBar(text: $searchText, placeholder: "Search components...")
                
                SearchBar(text: $searchText, placeholder: "With submission") {
                    print("Search submitted: \(searchText)")
                }
                
                Text("Current search: \(searchText)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
    }
    
    return SearchBarPreview()
}

#Preview("Search Bar States") {
    VStack(spacing: 20) {
        SearchBar(text: .constant(""), placeholder: "Empty search bar")
        
        SearchBar(text: .constant("SwiftUI"), placeholder: "With text")
        
        SearchBar(text: .constant("Very long search query that might wrap"), placeholder: "Long text")
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Search Bar with Scope") {
    enum PreviewScope: String, CaseIterable {
        case all = "All"
        case atoms = "Atoms"
        case molecules = "Molecules"
        case organisms = "Organisms"
    }
    
    struct ScopePreview: View {
        @State private var searchText = ""
        @State private var scope: PreviewScope = .all
        
        var body: some View {
            VStack(spacing: 20) {
                SearchBarWithScope(
                    text: $searchText,
                    scope: $scope,
                    placeholder: "Search design system...",
                    scopeTitle: "Category"
                )
                
                VStack(spacing: 8) {
                    Text("Current Search: \(searchText)")
                    Text("Current Scope: \(scope.rawValue)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
    }
    
    return ScopePreview()
}

#Preview("Dark Mode") {
    struct DarkModePreview: View {
        @State private var searchText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                SearchBar(text: $searchText, placeholder: "Search in dark mode...")
                
                SearchBar(text: .constant("Dark mode text"), placeholder: "With content")
            }
            .padding()
            .background(Color(.systemBackground))
            .preferredColorScheme(.dark)
        }
    }
    
    return DarkModePreview()
}
