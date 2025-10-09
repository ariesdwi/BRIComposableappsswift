//
//  Untitled.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPETextCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPEText",
                    subtitle: "Typography system and text components"
                )
                
                // Text Variants
                ComponentSection(title: "Text Variants", icon: "textformat") {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(TPETextVariant.allCases, id: \.self) { variant in
                            HStack {
                                TPEText(
                                    text: variant.name,
                                    variant: variant,
                                    color: .primary,
                                    textAlignment: .leading
                                )
                                
                                Spacer()
                                
                                Text(variant.name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                // Text Colors
                ComponentSection(title: "Text Colors", icon: "paintpalette") {
                    VStack(alignment: .leading, spacing: 12) {
                        TPEText(
                            text: "Primary Text",
                            variant: .text16Bold,
                            color: .primary,
                            textAlignment: .leading
                        )
                        
                        TPEText(
                            text: "Secondary Text",
                            variant: .text16Regular,
                            color: .secondary,
                            textAlignment: .leading
                        )
                        
                        TPEText(
                            text: "Accent Text",
                            variant: .text16Bold,
                            color: .blue,
                            textAlignment: .leading
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("TPEText")
        .navigationBarTitleDisplayMode(.large)
    }
}
