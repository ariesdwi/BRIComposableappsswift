//
//  IconsCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 07/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TpeLinkCatalogView: View {
    @State private var tapCount = 0
    
    var body: some View {
        List {
            Section("Basic Examples") {
                TPELinkText(
                    text: "Default Link",
                    color: .blue,
                    onTap: {
                        print("Default link tapped!")
                    }
                )
                
                TPELinkText(
                    text: "Primary Color Link",
                    color: .primary,
                    onTap: {
                        print("Primary link tapped!")
                    }
                )
                
                TPELinkText(
                    text: "Red Warning Link",
                    color: .red,
                    onTap: {
                        print("Warning link tapped!")
                    }
                )
            }
            
            Section("Interactive Example") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tap count: \(tapCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    TPELinkText(
                        text: "Increment Counter",
                        color: .green,
                        onTap: {
                            tapCount += 1
                        }
                    )
                }
            }
            
            Section("Different States") {
                TPELinkText(
                    text: "Navigation Link",
                    color: .purple,
                    onTap: {
                        print("Navigate somewhere...")
                    }
                )
                
                TPELinkText(
                    text: "Action Link",
                    color: .orange,
                    onTap: {
                        print("Perform action...")
                    }
                )
            }
        }
        .navigationTitle("Link Text Catalog")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview provider for testing
#Preview {
    NavigationView {
        TpeLinkCatalogView()
    }
}
