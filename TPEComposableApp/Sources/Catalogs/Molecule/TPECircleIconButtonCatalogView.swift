//
//  TPECircleIconButtonCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPECircleIconButtonCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPECircleIconButton",
                    subtitle: "Circular icon buttons with badges and various styles"
                )
                
                // Basic Sizes
                ComponentSection(title: "Basic Sizes", icon: "square.grid.2x2") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "heart.fill",
                            size: 40,
                            onPressed: { print("Small button tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "star.fill",
                            size: 50,
                            onPressed: { print("Medium button tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "plus",
                            size: 60,
                            onPressed: { print("Large button tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "bell.fill",
                            size: 70,
                            onPressed: { print("X-Large button tapped") }
                        )
                    }
                }
                
                // Color Variants
                ComponentSection(title: "Color Variants", icon: "paintpalette") {
                    HStack(spacing: 16) {
                        TPECircleIconButton(
                            icon: "heart.fill",
                            iconColor: .white,
                            backgroundColor: TPEColors.primaryBlue,
                            onPressed: { print("Primary blue tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "checkmark",
                            iconColor: .white,
                            backgroundColor: TPEColors.green70,
                            onPressed: { print("Green tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "exclamationmark.triangle.fill",
                            iconColor: .white,
                            backgroundColor: TPEColors.orange70,
                            onPressed: { print("Orange tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "xmark",
                            iconColor: .white,
                            backgroundColor: TPEColors.red70,
                            onPressed: { print("Red tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "gear",
                            iconColor: TPEColors.dark30,
                            backgroundColor: TPEColors.light20,
                            onPressed: { print("Light gray tapped") }
                        )
                    }
                }
                
                // With Borders
                ComponentSection(title: "With Borders", icon: "circle.inset.filled") {
                    HStack(spacing: 16) {
                        TPECircleIconButton(
                            icon: "camera.fill",
                            iconColor: TPEColors.primaryBlue,
                            backgroundColor: .white,
                            borderColor: TPEColors.primaryBlue,
                            borderWidth: 2,
                            onPressed: { print("Blue border tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "mic.fill",
                            iconColor: TPEColors.green70,
                            backgroundColor: .white,
                            borderColor: TPEColors.green70,
                            borderWidth: 2,
                            onPressed: { print("Green border tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "photo.fill",
                            iconColor: TPEColors.orange70,
                            backgroundColor: .white,
                            borderColor: TPEColors.orange70,
                            borderWidth: 3,
                            onPressed: { print("Thick orange border tapped") }
                        )
                    }
                }
                
                // With Badges
                ComponentSection(title: "With Badges", icon: "number.circle") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "bell.fill",
                            onPressed: { print("Notification bell tapped") }, badgeCount: 3
                        )
                        
                        TPECircleIconButton(
                            icon: "envelope.fill",
                            onPressed: { print("Messages tapped") }, badgeCount: 12,
                            badgeColor: TPEColors.orange70
                        )
                        
                        TPECircleIconButton(
                            icon: "cart.fill",
                            onPressed: { print("Cart tapped") }, badgeCount: 99,
                            badgeColor: TPEColors.green70,
                            badgeTextColor: .white
                        )
                        
                        TPECircleIconButton(
                            icon: "person.fill",
                            onPressed: { print("Profile tapped") }, badgeCount: 1,
                            badgeColor: TPEColors.red70
                        )
                    }
                }
                
                // Badge Sizes
                ComponentSection(title: "Badge Sizes", icon: "circlebadge") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "bell.fill",
                            onPressed: { print("Small badge tapped") }, badgeCount: 5,
                            badgeSize: 14
                        )
                        
                        TPECircleIconButton(
                            icon: "envelope.fill",
                            onPressed: { print("Medium badge tapped") }, badgeCount: 8,
                            badgeSize: 17
                        )
                        
                        TPECircleIconButton(
                            icon: "cart.fill",
                            onPressed: { print("Large badge tapped") }, badgeCount: 15,
                            badgeSize: 20
                        )
                    }
                }
                
                // With Shadows
                ComponentSection(title: "With Shadows", icon: "shadow") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "heart.fill",
                            onPressed: { print("Shadow button 1 tapped") }, showShadow: true
                        )
                        
                        TPECircleIconButton(
                            icon: "star.fill",
                            backgroundColor: TPEColors.green70,
                            onPressed: { print("Shadow button 2 tapped") }, showShadow: true
                        )
                        
                        TPECircleIconButton(
                            icon: "plus",
                            backgroundColor: TPEColors.orange70,
                            onPressed: { print("Shadow button 3 tapped") }, showShadow: true
                        )
                    }
                }
                
                // Disabled States
                ComponentSection(title: "Disabled States", icon: "slash.circle") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "heart.fill",
                            onPressed: nil // Disabled
                        )
                        
                        TPECircleIconButton(
                            icon: "bell.fill",
                            backgroundColor: TPEColors.light40,
                            onPressed: nil // Disabled
                        )
                        
                        TPECircleIconButton(
                            icon: "cart.fill",
                            onPressed: nil, badgeCount: 3 // Disabled
                        )
                    }
                }
                
                // No Badge Examples
                ComponentSection(title: "No Badge Examples", icon: "circle") {
                    HStack(spacing: 20) {
                        TPECircleIconButton(
                            icon: "heart.fill",
                            onPressed: { print("No badge button tapped") }
                        )
                        
                        TPECircleIconButton(
                            icon: "star.fill",
                            onPressed: { print("Zero badge count tapped") }, badgeCount: 0
                        )
                        
                        TPECircleIconButton(
                            icon: "gear",
                            onPressed: { print("Nil badge count tapped") }, badgeCount: nil
                        )
                    }
                }
                
                // Combined Examples
                ComponentSection(title: "Combined Examples", icon: "square.grid.2x2") {
                    VStack(spacing: 20) {
                        HStack(spacing: 16) {
                            Text("Action Buttons")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            TPECircleIconButton(
                                icon: "phone.fill",
                                size: 44,
                                iconColor: .white,
                                backgroundColor: TPEColors.green70,
                                onPressed: { print("Call tapped") }, showShadow: true
                            )
                            
                            TPECircleIconButton(
                                icon: "message.fill",
                                size: 44,
                                iconColor: .white,
                                backgroundColor: TPEColors.primaryBlue,
                                onPressed: { print("Message tapped") }, showShadow: true
                            )
                            
                            TPECircleIconButton(
                                icon: "video.fill",
                                size: 44,
                                iconColor: .white,
                                backgroundColor: TPEColors.orange70,
                                onPressed: { print("Video call tapped") }, showShadow: true
                            )
                        }
                        
                        HStack(spacing: 16) {
                            Text("Social Media")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            TPECircleIconButton(
                                icon: "heart.fill",
                                size: 40,
                                iconColor: .white,
                                backgroundColor: TPEColors.red70,
                                onPressed: { print("Likes tapped") }, badgeCount: 24
                            )
                            
                            TPECircleIconButton(
                                icon: "bubble.left.fill",
                                size: 40,
                                iconColor: .white,
                                backgroundColor: TPEColors.primaryBlue,
                                onPressed: { print("Comments tapped") }, badgeCount: 7
                            )
                            
                            TPECircleIconButton(
                                icon: "arrow.rectanglepath",
                                size: 40,
                                iconColor: .white,
                                backgroundColor: TPEColors.green70,
                                onPressed: { print("Shares tapped") }, badgeCount: 3
                            )
                        }
                        
                        HStack(spacing: 16) {
                            Text("Settings")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            TPECircleIconButton(
                                icon: "gearshape.fill",
                                size: 44,
                                iconColor: TPEColors.dark30,
                                backgroundColor: TPEColors.light20,
                                borderColor: TPEColors.light40,
                                borderWidth: 1,
                                onPressed: { print("Settings tapped") }
                            )
                            
                            TPECircleIconButton(
                                icon: "person.fill",
                                size: 44,
                                iconColor: TPEColors.dark30,
                                backgroundColor: TPEColors.light20,
                                borderColor: TPEColors.light40,
                                borderWidth: 1,
                                onPressed: { print("Profile tapped") }, badgeCount: 1
                            )
                            
                            TPECircleIconButton(
                                icon: "bell.fill",
                                size: 44,
                                iconColor: TPEColors.dark30,
                                backgroundColor: TPEColors.light20,
                                borderColor: TPEColors.light40,
                                borderWidth: 1,
                                onPressed: { print("Notifications tapped") }, badgeCount: 5
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Circle Icon Button")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Convenience Extensions

public extension TPECircleIconButton {
    /// Create a favorite/heart button with common styling
    static func favorite(
        isFilled: Bool = false,
        badgeCount: Int? = nil,
        onPressed: (() -> Void)? = nil
    ) -> TPECircleIconButton {
        TPECircleIconButton(
            icon: isFilled ? "heart.fill" : "heart",
            iconColor: isFilled ? TPEColors.red70 : TPEColors.dark30,
            backgroundColor: isFilled ? .white : TPEColors.light20,
            borderColor: TPEColors.light40,
            borderWidth: 1,
            onPressed: onPressed,
            badgeCount: badgeCount
        )
    }
    
    /// Create a notification bell button
    static func notification(
        badgeCount: Int? = nil,
        onPressed: (() -> Void)? = nil
    ) -> TPECircleIconButton {
        TPECircleIconButton(
            icon: "bell.fill",
            onPressed: onPressed, badgeCount: badgeCount
        )
    }
    
    /// Create a cart/shopping button
    static func cart(
        badgeCount: Int? = nil,
        onPressed: (() -> Void)? = nil
    ) -> TPECircleIconButton {
        TPECircleIconButton(
            icon: "cart.fill",
            onPressed: onPressed, badgeCount: badgeCount
        )
    }
    
    /// Create an add/plus button
    static func add(
        onPressed: (() -> Void)? = nil
    ) -> TPECircleIconButton {
        TPECircleIconButton(
            icon: "plus",
            iconColor: .white,
            backgroundColor: TPEColors.primaryBlue,
            onPressed: onPressed, showShadow: true
        )
    }
}

// MARK: - Previews

#Preview("Circle Icon Button Catalog") {
    NavigationView {
        TPECircleIconButtonCatalogView()
    }
}

#Preview("Basic Examples") {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            TPECircleIconButton(
                icon: "heart.fill",
                size: 44,
                onPressed: { print("Button tapped") }
            )
            
            TPECircleIconButton(
                icon: "bell.fill",
                onPressed: { print("Notification tapped") }, badgeCount: 3
            )
            
            TPECircleIconButton(
                icon: "cart.fill",
                onPressed: { print("Cart tapped") }, badgeCount: 12
            )
        }
        
        HStack(spacing: 16) {
            TPECircleIconButton.favorite(isFilled: true, badgeCount: 5)
            TPECircleIconButton.notification(badgeCount: 8)
            TPECircleIconButton.add()
        }
    }
    .padding()
}
