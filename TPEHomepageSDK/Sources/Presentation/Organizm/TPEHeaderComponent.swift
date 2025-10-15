// Organisms/TPEHeaderComponent.swift
import SwiftUI
import TPEComponentSDK

public struct TPEHeaderComponent: View {
    let userName: String
    let greeting: String
    let notificationCount: Int?
    let singleLineType: Bool
    let rightCircleButton: TPECircleIconButton?
    let logoUrl: String?
    
    // Enhanced visual properties
    private let backgroundColor: Color
    private let backgroundGradient: LinearGradient?
    private let cornerRadius: CGFloat
    private let shadowColor: Color
    private let shadowRadius: CGFloat
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(
        userName: String,
        greeting: String = "Welcome",
        singleLineType: Bool = true,
        notificationCount: Int? = nil,
        rightCircleButton: TPECircleIconButton? = nil,
        logoUrl: String? = nil,
        backgroundColor: Color = .clear,
        backgroundGradient: LinearGradient? = nil,
        cornerRadius: CGFloat = 0,
        shadowColor: Color = .clear,
        shadowRadius: CGFloat = 0
    ) {
        self.userName = userName
        self.greeting = greeting
        self.singleLineType = singleLineType
        self.notificationCount = notificationCount
        self.rightCircleButton = rightCircleButton
        self.logoUrl = logoUrl
        self.backgroundColor = backgroundColor
        self.backgroundGradient = backgroundGradient
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Logo with enhanced styling
            logoContent
                .accessibilityLabel("App logo")
            
            // Greeting and Username with improved typography
            greetingContent
                .accessibilityElement(children: .combine)
            
            Spacer()
            
            // Right Circle Button with badge
            buttonContent
                .padding(.trailing, 12)
        }
        .padding(.top, 16) // Changed from 20 to 16 for consistency
        .background(backgroundContent)
        .cornerRadius(cornerRadius)
        .shadow(color: shadowColor, radius: shadowRadius)
    }
    
    // MARK: - Subviews
    
    private var logoContent: some View {
        Group {
            if let logoUrl = logoUrl {
                AsyncImage(url: URL(string: logoUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .scaleEffect(0.8)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        fallbackLogo
                    @unknown default:
                        fallbackLogo
                    }
                }
            } else {
                fallbackLogo
            }
        }
        .frame(width: 44, height: 44)
        .background(
            LinearGradient(
                colors: [.white.opacity(0.15), .white.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
    
    private var fallbackLogo: some View {
        Image(systemName: "banknote")
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [.white.opacity(0.2), .white.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
    
    private var greetingContent: some View {
        Group {
            if singleLineType {
                Text("\(greeting), \(userName)")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(greeting)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(userName)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                }
            }
        }
    }
    
    @ViewBuilder
    private var buttonContent: some View {
        if let rightCircleButton = rightCircleButton {
            ZStack(alignment: .topTrailing) {
                rightCircleButton
                
                // Notification badge
                if let count = notificationCount, count > 0 {
                    Text("\(min(count, 99))")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .frame(minWidth: 18, minHeight: 18)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 4, y: -4)
                        .scaleEffect(0.9)
                }
            }
        }
    }
    
    private var backgroundContent: some View {
        Group {
            if let gradient = backgroundGradient {
                gradient
            } else {
                backgroundColor
            }
        }
    }
}
