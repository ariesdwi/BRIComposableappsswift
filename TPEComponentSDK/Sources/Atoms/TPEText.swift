////
////  TPEText.swift
////  TPEComposable
////
////  Created by PT Siaga Abdi Utama on 06/10/25.
////
//
//import SwiftUI
//
//public enum TPETextVariant {
//    case text16Bold
//    case secondary
//}
//
//public struct TPEText: View {
//    let text: String
//    let variant: TPETextVariant
//    let color: Color
//    let textAlignment: TextAlignment
//    
//    public init(text: String, variant: TPETextVariant, color: Color, textAlignment: TextAlignment = .center) {
//        self.text = text
//        self.variant = variant
//        self.color = color
//        self.textAlignment = textAlignment
//    }
//    
//    public var body: some View {
//        Text(text)
//            .font(font)
//            .foregroundColor(color)
//            .multilineTextAlignment(textAlignment)
//            .lineLimit(nil)
//    }
//    
//    private var font: Font {
//        switch variant {
//        case .text16Bold:
//            return .system(size: 16, weight: .bold)
//        case .secondary:
//            return .system(size: 14, weight: .regular)
//        }
//    }
//}


//
//  TPEText.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 06/10/25.
//

import SwiftUI

public enum TPETextVariant: CaseIterable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption1
    case caption2
    case text16Bold
    case text16Regular
    case text14Bold
    case text14Regular
    case text12Bold
    case text12Regular
    case secondary
    
    public var name: String {
        switch self {
        case .largeTitle: return "Large Title"
        case .title1: return "Title 1"
        case .title2: return "Title 2"
        case .title3: return "Title 3"
        case .headline: return "Headline"
        case .body: return "Body"
        case .callout: return "Callout"
        case .subheadline: return "Subheadline"
        case .footnote: return "Footnote"
        case .caption1: return "Caption 1"
        case .caption2: return "Caption 2"
        case .text16Bold: return "Text 16 Bold"
        case .text16Regular: return "Text 16 Regular"
        case .text14Bold: return "Text 14 Bold"
        case .text14Regular: return "Text 14 Regular"
        case .text12Bold: return "Text 12 Bold"
        case .text12Regular: return "Text 12 Regular"
        case .secondary: return "Secondary"
        }
    }
}

public struct TPEText: View {
    let text: String
    let variant: TPETextVariant
    let color: Color
    let textAlignment: TextAlignment
    let lineLimit: Int?
    let minimumScaleFactor: CGFloat
    
    public init(
        text: String,
        variant: TPETextVariant,
        color: Color = .primary,
        textAlignment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        minimumScaleFactor: CGFloat = 1.0
    ) {
        self.text = text
        self.variant = variant
        self.color = color
        self.textAlignment = textAlignment
        self.lineLimit = lineLimit
        self.minimumScaleFactor = minimumScaleFactor
    }
    
    public var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(color)
            .multilineTextAlignment(textAlignment)
            .lineLimit(lineLimit)
            .minimumScaleFactor(minimumScaleFactor)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var font: Font {
        switch variant {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .body:
            return .body
        case .callout:
            return .callout
        case .subheadline:
            return .subheadline
        case .footnote:
            return .footnote
        case .caption1:
            return .caption
        case .caption2:
            return .caption2
        case .text16Bold, .text16Regular:
            return .system(size: 16)
        case .text14Bold, .text14Regular:
            return .system(size: 14)
        case .text12Bold, .text12Regular:
            return .system(size: 12)
        case .secondary:
            return .system(size: 14)
        }
    }
    
    private var fontWeight: Font.Weight {
        switch variant {
        case .largeTitle, .title1, .title2, .title3:
            return .bold
        case .headline:
            return .semibold
        case .text16Bold, .text14Bold, .text12Bold:
            return .bold
        case .body, .callout, .subheadline, .footnote, .caption1, .caption2, .text16Regular, .text14Regular, .text12Regular, .secondary:
            return .regular
        }
    }
}

// MARK: - Convenience Initializers
public extension TPEText {
    /// Creates a large title text
    static func largeTitle(_ text: String, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .largeTitle, color: color, textAlignment: alignment)
    }
    
    /// Creates a title text
    static func title(_ text: String, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .title1, color: color, textAlignment: alignment)
    }
    
    /// Creates a headline text
    static func headline(_ text: String, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .headline, color: color, textAlignment: alignment)
    }
    
    /// Creates a body text
    static func body(_ text: String, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .body, color: color, textAlignment: alignment)
    }
    
    /// Creates a caption text
    static func caption(_ text: String, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .caption1, color: color, textAlignment: alignment)
    }
    
    /// Creates a secondary text
    static func secondary(_ text: String, color: Color = .secondary, alignment: TextAlignment = .leading) -> TPEText {
        TPEText(text: text, variant: .secondary, color: color, textAlignment: alignment)
    }
    
    /// Creates a bold text with custom size
    static func bold(_ text: String, size: CGFloat, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        let variant: TPETextVariant
        switch size {
        case 16: variant = .text16Bold
        case 14: variant = .text14Bold
        case 12: variant = .text12Bold
        default: variant = .text16Bold
        }
        return TPEText(text: text, variant: variant, color: color, textAlignment: alignment)
    }
    
    /// Creates a regular text with custom size
    static func regular(_ text: String, size: CGFloat, color: Color = .primary, alignment: TextAlignment = .leading) -> TPEText {
        let variant: TPETextVariant
        switch size {
        case 16: variant = .text16Regular
        case 14: variant = .text14Regular
        case 12: variant = .text12Regular
        default: variant = .text16Regular
        }
        return TPEText(text: text, variant: variant, color: color, textAlignment: alignment)
    }
}

// MARK: - Preview
#Preview {
    VStack(alignment: .leading, spacing: 16) {
        TPEText.largeTitle("Large Title")
        TPEText.title("Title")
        TPEText.headline("Headline")
        TPEText.body("Body text that can span multiple lines and provide detailed information.")
        TPEText.caption("Caption text")
        TPEText.secondary("Secondary text for less important information")
        TPEText.bold("Bold Text", size: 16)
        TPEText.regular("Regular Text", size: 14)
    }
    .padding()
}
