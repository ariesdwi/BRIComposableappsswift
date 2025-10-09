//
//  CategoryFilter.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI

/// A horizontal category filter component with smooth selection animations
public struct CategoryFilter<Category: FilterCategory>: View {
    @Binding var selectedCategory: Category
    let categories: [Category]
    
    /// Initialize with custom categories
    public init(
        selectedCategory: Binding<Category>,
        categories: [Category]
    ) {
        self._selectedCategory = selectedCategory
        self.categories = categories
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories) { category in
                            CategoryChip(
                                category: category,
                                isSelected: selectedCategory.id == category.id
                            ) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedCategory = category
                                }
                            }
                            .id(category.id)
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 1)
                }
                .onChange(of: selectedCategory) { _, newCategory in
                    withAnimation {
                        proxy.scrollTo(newCategory.id, anchor: .center)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

// MARK: - Category Chip Component
struct CategoryChip<Category: FilterCategory>: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                // Icon
                Image(systemName: category.icon)
                    .font(.system(size: 14, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                
                // Title
                Text(category.title)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor, lineWidth: isSelected ? 0 : 1)
            )
            .shadow(
                color: isSelected ? .blue.opacity(0.25) : .clear,
                radius: isSelected ? 4 : 0,
                x: 0,
                y: 2
            )
        }
        .buttonStyle(ScaleButtonStyle(scale: 0.96))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel("\(category.title) category")
    }
    
    // MARK: - Computed Properties
    private var backgroundColor: Color {
        isSelected ? .blue : Color(.systemBackground)
    }
    
    private var foregroundColor: Color {
        isSelected ? .white : .primary
    }
    
    private var borderColor: Color {
        isSelected ? .clear : Color(.separator)
    }
}

// MARK: - Filter Category Protocol
public protocol FilterCategory: CaseIterable, Identifiable, Hashable, Equatable {
    var title: String { get }
    var icon: String { get }
}

// MARK: - Scale Button Style
//struct ScaleButtonStyle: ButtonStyle {
//    let scale: CGFloat
//    
//    init(scale: CGFloat = 0.95) {
//        self.scale = scale
//    }
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? scale : 1.0)
//            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
//    }
//}


// MARK: - Preview Helper
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    let content: (Binding<Value>) -> Content
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}
