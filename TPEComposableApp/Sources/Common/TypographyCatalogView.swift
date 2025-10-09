//
//  TypographyCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

// MARK: - Catalog Section Component
struct CatalogSection<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}


struct TypographyCatalogView: View {
    let textStyles: [(text: String, variant: TPETextVariant)] = [
        ("Large Title", .largeTitle),
        ("Title 1", .title1),
        ("Title 2", .title2),
        ("Title 3", .title3),
        ("Headline", .headline),
        ("Body", .body),
        ("Callout", .callout),
        ("Subheadline", .subheadline),
        ("Footnote", .footnote),
        ("Caption 1", .caption1),
        ("Caption 2", .caption2),
        ("Text 16 Bold", .text16Bold),
        ("Text 16 Regular", .text16Regular),
        ("Text 14 Bold", .text14Bold),
        ("Text 14 Regular", .text14Regular),
        ("Text 12 Bold", .text12Bold),
        ("Text 12 Regular", .text12Regular),
        ("Secondary", .secondary)
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                CatalogSection(title: "Text Variants", icon: "textformat.size") {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(textStyles.enumerated()), id: \.offset) { index, style in
                            HStack(alignment: .top) {
                                TPEText(
                                    text: style.text,
                                    variant: style.variant,
                                    color: .primary,
                                    textAlignment: .leading
                                )
                                
                                Spacer()
                                
                                Text(style.variant.name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(4)
                            }
                            
                            if index < textStyles.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
                
                // Usage Examples Section
                CatalogSection(title: "Usage Examples", icon: "doc.text.fill") {
                    VStack(alignment: .leading, spacing: 16) {
                        TPEText.largeTitle("Welcome to TPE Design System")
                        TPEText.title("Getting Started Guide")
                        TPEText.headline("Key Features")
                        TPEText.body("This is a comprehensive design system built with SwiftUI and following atomic design principles.")
                        TPEText.secondary("Last updated: October 2025")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Typography")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        TypographyCatalogView()
    }
}
