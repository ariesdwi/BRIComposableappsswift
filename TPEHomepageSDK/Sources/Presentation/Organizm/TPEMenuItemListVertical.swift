
//
//  TPEMenuItemListVertical.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

// MARK: - Beautiful Individual Menu Item View
public struct TPEHomeMenuItemVertical: View {
    public let title: String
    public let iconUrl: String?
    public let circleIcon: AnyView?
    public let iconSize: CGFloat
    public let isNew: Bool
    public let onTap: (() -> Void)?
    
    // Animation states
    @State private var isPressed = false
    @State private var isHovered = false
    
    public init(
        title: String,
        iconUrl: String? = nil,
        circleIcon: AnyView? = nil,
        iconSize: CGFloat = 56, // Slightly larger for better visual impact
        isNew: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.iconUrl = iconUrl
        self.circleIcon = circleIcon
        self.iconSize = iconSize
        self.isNew = isNew
        self.onTap = onTap
    }

    public var body: some View {
        VStack(spacing: 12) {
            // Square container for icon
            ZStack {
                // Square background
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .frame(width: iconSize, height: iconSize)
                    .shadow(
                        color: .black.opacity(isHovered ? 0.15 : 0.08),
                        radius: isHovered ? 6 : 3,
                        x: 0,
                        y: isHovered ? 3 : 1
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                Color.blue.opacity(isHovered ? 0.3 : 0.1),
                                lineWidth: isHovered ? 1.5 : 1
                            )
                    )
                
                // Icon content
                iconView
                    .scaleEffect(isPressed ? 0.95 : (isHovered ? 1.05 : 1.0))
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isHovered)

                // New badge with improved design
                if isNew {
                    newBadge
                }
            }
            
            // Title below the square box
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .frame(width: 80)
                .lineLimit(2)
                .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .background(backgroundView)
        .contentShape(Rectangle())
        .onTapGesture { handleTap() }
        .onLongPressGesture(minimumDuration: 0.1, maximumDistance: 10) {
            // Handle press states for better feedback
        } onPressingChanged: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }
        .hoverEffect(.lift)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
    
    // MARK: - Background View (for the entire item)
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.clear) // Changed to clear since we have square box for icon
            .scaleEffect(isPressed ? 0.98 : 1.0)
    }
    
    // MARK: - Enhanced Icon View
    @ViewBuilder
    private var iconView: some View {
        if let iconUrl = iconUrl, let url = URL(string: iconUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: iconSize * 0.6, height: iconSize * 0.6)
                        .scaleEffect(0.8)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: iconSize * 0.7, height: iconSize * 0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    fallbackIcon
                @unknown default:
                    fallbackIcon
                }
            }
        } else if let circleIcon = circleIcon {
            circleIcon
                .frame(width: iconSize * 0.7, height: iconSize * 0.7)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            fallbackIcon
        }
    }
    
    // MARK: - Enhanced New Badge
    private var newBadge: some View {
        Text("BARU")
            .font(.system(size: 9, weight: .heavy, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                LinearGradient(
                    colors: [Color.red, Color.orange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
            .shadow(color: .red.opacity(0.4), radius: 2, x: 0, y: 2)
            .offset(x: iconSize * 0.3, y: -iconSize * 0.3) // Position at top-right corner
            .scaleEffect(isHovered ? 1.1 : 1.0)
    }
    
    // MARK: - Enhanced Fallback Icon
    private var fallbackIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: iconSize * 0.7, height: iconSize * 0.7)
            
            Text(initials(from: title))
                .font(.system(size: iconSize * 0.25, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
        }
    }
    
    // MARK: - Tap Handler with Haptic Feedback
    private func handleTap() {
        // Add haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        // Animate tap
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = false
            }
        }
        
        onTap?()
    }
    
    // MARK: - Initials Helper
    private func initials(from text: String) -> String {
        let words = text.split(separator: " ")
        if words.count >= 2 {
            return "\(words[0].prefix(1))\(words[1].prefix(1))".uppercased()
        } else if let first = words.first {
            return String(first.prefix(1)).uppercased()
        }
        return "?"
    }
}


