//
//  TPECopyButton.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPECopyButton: View {
    let textColor: Color?
    let textToCopy: String
    let copyText: String
    let successMessage: String
    
    @State private var showCopiedMessage = false
    
    public init(
        textColor: Color? = nil,
        textToCopy: String,
        copyText: String = "Copy",
        successMessage: String = "Copied to clipboard"
    ) {
        self.textColor = textColor
        self.textToCopy = textToCopy
        self.copyText = copyText
        self.successMessage = successMessage
    }
    
    public var body: some View {
        Button(action: copyToClipboard) {
            HStack(spacing: 4) {
                Text(copyText)
                    .font(.system(size: 12, weight: .medium))
                
                Image(systemName: "doc.on.doc")
                    .font(.system(size: 14))
                
                
            }
            .foregroundColor(textColor ?? .blue)
        }
        .overlay(
            Group {
                if showCopiedMessage {
                    Text(successMessage)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(6)
                        .offset(y: -30)
                }
            }
        )
    }
    
    private func copyToClipboard() {
        #if os(iOS)
        UIPasteboard.general.string = textToCopy
        #endif
        
        withAnimation {
            showCopiedMessage = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showCopiedMessage = false
            }
        }
    }
}
