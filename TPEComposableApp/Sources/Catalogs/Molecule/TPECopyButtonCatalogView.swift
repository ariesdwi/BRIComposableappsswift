//
//  TPECopyButtonCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPECopyButtonCatalogView: View {
    @State private var sampleText = "Hello, this is sample text to copy!"
    @State private var apiKey = "sk-1234567890abcdef"
    @State private var urlText = "https://example.com/very-long-url-path"
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPECopyButton",
                    subtitle: "Copy text to clipboard with visual feedback"
                )
                
                // Basic Usage
                ComponentSection(title: "Basic Usage", icon: "doc.on.doc") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Sample Text:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(sampleText)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            Spacer()
                            TPECopyButton(textToCopy: sampleText)
                        }
                        
                        Text("Tap the copy button to copy the text to clipboard")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Color Variants
                ComponentSection(title: "Color Variants", icon: "paintpalette") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Default Blue")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Default blue color text"
                            )
                        }
                        
                        HStack {
                            Text("Custom Color")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textColor: TPEColors.green70,
                                textToCopy: "Green color text"
                            )
                        }
                        
                        HStack {
                            Text("Dark Color")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textColor: TPEColors.dark30,
                                textToCopy: "Dark color text"
                            )
                        }
                        
                        HStack {
                            Text("Red Color")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textColor: TPEColors.red70,
                                textToCopy: "Red color text"
                            )
                        }
                    }
                }
                
                // Custom Text
                ComponentSection(title: "Custom Text", icon: "textformat") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Custom Copy Text")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Custom button text",
                                copyText: "Copy Me"
                            )
                        }
                        
                        HStack {
                            Text("Short Text")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Short",
                                copyText: "C"
                            )
                        }
                        
                        HStack {
                            Text("Icon Only")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Icon only",
                                copyText: ""
                            )
                        }
                    }
                }
                
                // Custom Messages
                ComponentSection(title: "Custom Messages", icon: "message") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Custom Success")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Custom success message",
                                successMessage: "✅ Text copied!"
                            )
                        }
                        
                        HStack {
                            Text("Professional")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPECopyButton(
                                textToCopy: "Professional message",
                                successMessage: "Copied to clipboard successfully"
                            )
                        }
                    }
                }
                
                // Real World Examples
                ComponentSection(title: "Real World Examples", icon: "square.grid.2x2") {
                    VStack(spacing: 20) {
                        // API Key Example
                        VStack(spacing: 12) {
                            HStack {
                                Text("API Key")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            HStack {
                                Text(apiKey)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                Spacer()
                                TPECopyButton(
                                    textColor: TPEColors.blue70,
                                    textToCopy: apiKey,
                                    copyText: "Copy Key",
                                    successMessage: "API Key copied!"
                                )
                            }
                            .padding()
                            .background(TPEColors.light10)
                            .cornerRadius(8)
                        }
                        
                        // URL Example
                        VStack(spacing: 12) {
                            HStack {
                                Text("Share URL")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            HStack {
                                Text(urlText)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                Spacer()
                                TPECopyButton(
                                    textColor: TPEColors.green70,
                                    textToCopy: urlText,
                                    copyText: "Copy URL",
                                    successMessage: "URL copied!"
                                )
                            }
                            .padding()
                            .background(TPEColors.light10)
                            .cornerRadius(8)
                        }
                        
                        // Code Snippet Example
                        VStack(spacing: 12) {
                            HStack {
                                Text("Code Snippet")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("const apiKey = 'sk-1234567890';")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundColor(.primary)
                                
                                HStack {
                                    Spacer()
                                    TPECopyButton(
                                        textColor: TPEColors.orange70,
                                        textToCopy: "const apiKey = 'sk-1234567890';",
                                        copyText: "Copy Code",
                                        successMessage: "Code copied!"
                                    )
                                }
                            }
                            .padding()
                            .background(TPEColors.light10)
                            .cornerRadius(8)
                        }
                    }
                }
                
                // Integration Examples
                ComponentSection(title: "Integration Examples", icon: "cursorarrow.motionlines") {
                    VStack(spacing: 16) {
                        // With Input Field
                        VStack(spacing: 12) {
                            HStack {
                                Text("With Input Field")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            HStack {
                                TextField("Enter text to copy", text: $sampleText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TPECopyButton(textToCopy: sampleText)
                            }
                        }
                        
                        // In List Item
                        VStack(spacing: 12) {
                            HStack {
                                Text("In List Items")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            VStack(spacing: 8) {
                                ForEach(1...3, id: \.self) { index in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Item \(index)")
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                            Text("Value: ABC-\(index)XYZ")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        TPECopyButton(
                                            textToCopy: "ABC-\(index)XYZ",
                                            copyText: "Copy",
                                            successMessage: "Value \(index) copied!"
                                        )
                                    }
                                    .padding()
                                    .background(TPEColors.light10)
                                    .cornerRadius(8)
                                    
                                    if index < 3 {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Copy Button")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Previews

#Preview("Copy Button Catalog") {
    NavigationView {
        TPECopyButtonCatalogView()
    }
}

#Preview("Basic Examples") {
    VStack(spacing: 16) {
        TPECopyButton(textToCopy: "Sample text 1")
        TPECopyButton(textColor: .green, textToCopy: "Sample text 2")
        TPECopyButton(textToCopy: "Sample text 3", copyText: "Copy Me")
        TPECopyButton(textToCopy: "Sample text 4", successMessage: "✅ Copied!")
    }
    .padding()
}
