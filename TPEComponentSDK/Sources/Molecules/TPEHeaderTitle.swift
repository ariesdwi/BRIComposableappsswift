//
//  TPEHeaderTitle.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct TPEHeaderTitle: View {
    let title: String
    let subtitle: String?
    
    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
    }
}
