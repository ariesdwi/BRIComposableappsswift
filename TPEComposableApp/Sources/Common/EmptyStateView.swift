//
//  EmptyStateView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//


import SwiftUI

/// A reusable empty state component for displaying when no content is available
public struct EmptyStateView: View {
    let title: String
    let subtitle: String
    let icon: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    /// Initialize with optional action button
    public init(
        title: String,
        subtitle: String,
        icon: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.actionTitle = actionTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 56))
                .foregroundColor(.secondary)
                .symbolRenderingMode(.hierarchical)
            
            // Text Content
            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            .padding(.horizontal)
            
            // Action Button (if provided)
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Convenience Initializers
public extension EmptyStateView {
    /// Initialize without action button
    init(title: String, subtitle: String, icon: String) {
        self.init(
            title: title,
            subtitle: subtitle,
            icon: icon,
            actionTitle: nil,
            action: nil
        )
    }
}

// MARK: - Predefined Empty States
public extension EmptyStateView {
    /// No search results empty state
    static func noResults(query: String? = nil) -> EmptyStateView {
        let subtitle = query.map { "No results found for \"\($0)\"" }
            ?? "Try adjusting your search or filters"
        
        return EmptyStateView(
            title: "No Results Found",
            subtitle: subtitle,
            icon: "magnifyingglass"
        )
    }
    
    /// No content available empty state
    static func noContent(title: String = "No Content", subtitle: String = "There's nothing to display here yet") -> EmptyStateView {
        EmptyStateView(
            title: title,
            subtitle: subtitle,
            icon: "doc.text"
        )
    }
    
    /// Error state
    static func error(title: String = "Something Went Wrong", subtitle: String = "Please try again later") -> EmptyStateView {
        EmptyStateView(
            title: title,
            subtitle: subtitle,
            icon: "exclamationmark.triangle"
        )
    }
    
    /// Empty state with retry action
    static func errorWithRetry(
        title: String = "Something Went Wrong",
        subtitle: String = "Please try again later",
        retryAction: @escaping () -> Void
    ) -> EmptyStateView {
        EmptyStateView(
            title: title,
            subtitle: subtitle,
            icon: "exclamationmark.triangle",
            actionTitle: "Try Again",
            action: retryAction
        )
    }
}

// MARK: - Previews
#Preview("Basic") {
    EmptyStateView(
        title: "No Atoms Found",
        subtitle: "Try adjusting your search or select a different category",
        icon: "atom"
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("With Action") {
    EmptyStateView(
        title: "Connection Error",
        subtitle: "Unable to load content. Please check your connection.",
        icon: "wifi.exclamationmark",
        actionTitle: "Retry",
        action: { print("Retry tapped") }
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Predefined States") {
    ScrollView {
        VStack(spacing: 20) {
            EmptyStateView.noResults(query: "SwiftUI")
            EmptyStateView.noContent()
            EmptyStateView.error()
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
}
