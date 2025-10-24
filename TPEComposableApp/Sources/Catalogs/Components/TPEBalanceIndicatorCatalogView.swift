//
//  TPEBalanceIndicatorCatalogView.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI
import TPEComponentSDK

struct TPEBalanceIndicatorCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView(
                    title: "TPEBalanceIndicator",
                    subtitle: "Visual indicator showing balance or progress with dot patterns"
                )
                
                // Basic Usage
                ComponentSection(title: "Basic Usage", icon: "circle.grid.3x3") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Default Indicator")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEBalanceIndicator()
                        }
                        
                        HStack {
                            Text("Custom Color")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEBalanceIndicator(color: TPEColors.green70)
                        }
                        
                        HStack {
                            Text("Custom Item Count")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEBalanceIndicator(itemCount: 8)
                        }
                    }
                }
                
                // Color Variants
                ComponentSection(title: "Color Variants", icon: "paintpalette") {
                    VStack(spacing: 12) {
                        ForEach(BalanceIndicatorColor.allCases, id: \.self) { colorCase in
                            HStack {
                                Text(colorCase.name)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .frame(width: 120, alignment: .leading)
                                
                                Spacer()
                                
                                TPEBalanceIndicator(
                                    color: colorCase.color,
                                    itemCount: 5
                                )
                            }
                        }
                    }
                }
                
                // Item Count Variations
                ComponentSection(title: "Item Count Variations", icon: "number") {
                    VStack(spacing: 12) {
                        ForEach(1..<11, id: \.self) { count in
                            HStack {
                                Text("\(count) items")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                
                                Spacer()
                                
                                TPEBalanceIndicator(
                                    color: TPEColors.blue70,
                                    itemCount: count
                                )
                            }
                        }
                    }
                }
                
                // Size Variations
                ComponentSection(title: "Size Variations", icon: "textformat.size") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Small (4px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 4
                            )
                        }
                        
                        HStack {
                            Text("Medium (6px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 6
                            )
                        }
                        
                        HStack {
                            Text("Default (8px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEBalanceIndicator(
                                color: TPEColors.blue70,
                                itemCount: 5
                            )
                        }
                        
                        HStack {
                            Text("Large (10px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 10
                            )
                        }
                        
                        HStack {
                            Text("X-Large (12px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 12
                            )
                        }
                    }
                }
                
                // Spacing Variations
                ComponentSection(title: "Spacing Variations", icon: "arrow.left.and.right") {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Tight (2px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 8,
                                spacing: 2
                            )
                        }
                        
                        HStack {
                            Text("Default (4px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            TPEBalanceIndicator(
                                color: TPEColors.blue70,
                                itemCount: 5
                            )
                        }
                        
                        HStack {
                            Text("Wide (6px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 8,
                                spacing: 6
                            )
                        }
                        
                        HStack {
                            Text("Extra Wide (8px)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            BalanceIndicatorView(
                                color: TPEColors.blue70,
                                itemCount: 5,
                                dotSize: 8,
                                spacing: 8
                            )
                        }
                    }
                }
                
                // Interactive Examples
                ComponentSection(title: "Interactive Examples", icon: "cursorarrow.motionlines") {
                    VStack(spacing: 20) {
                        // Strength Indicator
                        VStack(spacing: 12) {
                            HStack {
                                Text("Password Strength")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("Medium")
                                    .font(.caption)
                                    .foregroundColor(TPEColors.orange70)
                            }
                            
                            HStack {
                                Text("Strength:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                TPEBalanceIndicator(
                                    color: TPEColors.orange70,
                                    itemCount: 3
                                )
                            }
                        }
                        
                        // Progress Indicator
                        VStack(spacing: 12) {
                            HStack {
                                Text("Progress Tracker")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("Step 3 of 5")
                                    .font(.caption)
                                    .foregroundColor(TPEColors.blue70)
                            }
                            
                            HStack {
                                Text("Progress:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                TPEBalanceIndicator(
                                    color: TPEColors.blue70,
                                    itemCount: 5
                                )
                            }
                        }
                        
                        // Rating Indicator
                        VStack(spacing: 12) {
                            HStack {
                                Text("Quality Rating")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("4/5 Stars")
                                    .font(.caption)
                                    .foregroundColor(TPEColors.green70)
                            }
                            
                            HStack {
                                Text("Rating:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                TPEBalanceIndicator(
                                    color: TPEColors.green70,
                                    itemCount: 4
                                )
                            }
                        }
                        
                        // Status Indicator
                        VStack(spacing: 12) {
                            HStack {
                                Text("Connection Status")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("Connected")
                                    .font(.caption)
                                    .foregroundColor(TPEColors.green70)
                            }
                            
                            HStack {
                                Text("Signal:")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                TPEBalanceIndicator(
                                    color: TPEColors.green70,
                                    itemCount: 5
                                )
                            }
                        }
                    }
                }
                
                // Combined Examples
                ComponentSection(title: "Combined Examples", icon: "square.grid.2x2") {
                    VStack(spacing: 16) {
                        // Multiple indicators in a row
                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                TPEBalanceIndicator(
                                    color: TPEColors.blue70,
                                    itemCount: 3
                                )
                                Text("Low")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(spacing: 8) {
                                TPEBalanceIndicator(
                                    color: TPEColors.orange70,
                                    itemCount: 5
                                )
                                Text("Medium")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(spacing: 8) {
                                TPEBalanceIndicator(
                                    color: TPEColors.green70,
                                    itemCount: 8
                                )
                                Text("High")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(spacing: 8) {
                                TPEBalanceIndicator(
                                    color: TPEColors.red70,
                                    itemCount: 10
                                )
                                Text("Max")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Balance Indicator")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Supporting Structures

enum BalanceIndicatorColor: CaseIterable {
    case blue
    case green
    case orange
    case red
    case gray
    case dark
    
    var name: String {
        switch self {
        case .blue: return "Blue"
        case .green: return "Green"
        case .orange: return "Orange"
        case .red: return "Red"
        case .gray: return "Gray"
        case .dark: return "Dark"
        }
    }
    
    var color: Color {
        switch self {
        case .blue: return TPEColors.blue70
        case .green: return TPEColors.green70
        case .orange: return TPEColors.orange70
        case .red: return TPEColors.red70
        case .gray: return TPEColors.light60
        case .dark: return TPEColors.dark30
        }
    }
}

// Extended version for catalog demonstrations
struct BalanceIndicatorView: View {
    let color: Color
    let itemCount: Int
    let dotSize: CGFloat
    let spacing: CGFloat
    
    init(
        color: Color = TPEColors.blue80,
        itemCount: Int = 5,
        dotSize: CGFloat = 8,
        spacing: CGFloat = 4
    ) {
        self.color = color
        self.itemCount = itemCount
        self.dotSize = dotSize
        self.spacing = spacing
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<itemCount, id: \.self) { _ in
                Circle()
                    .fill(color)
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}

// MARK: - Convenience Extensions

public extension TPEBalanceIndicator {
    /// Create a balance indicator for strength measurement
    static func strength(level: Int, maxLevel: Int = 5) -> TPEBalanceIndicator {
        let color: Color
        switch level {
        case 0...1: color = TPEColors.red70
        case 2...3: color = TPEColors.orange70
        case 4...5: color = TPEColors.green70
        default: color = TPEColors.green70
        }
        
        return TPEBalanceIndicator(
            color: color,
            itemCount: level
        )
    }
    
    /// Create a balance indicator for progress tracking
    static func progress(current: Int, total: Int) -> TPEBalanceIndicator {
        TPEBalanceIndicator(
            color: TPEColors.blue70,
            itemCount: current
        )
    }
    
    /// Create a balance indicator for rating display
    static func rating(score: Int, maxScore: Int = 5) -> TPEBalanceIndicator {
        TPEBalanceIndicator(
            color: TPEColors.orange70,
            itemCount: score
        )
    }
    
    /// Create a balance indicator for status indication
    static func status(isActive: Bool, itemCount: Int = 3) -> TPEBalanceIndicator {
        TPEBalanceIndicator(
            color: isActive ? TPEColors.green70 : TPEColors.light60,
            itemCount: itemCount
        )
    }
}

// MARK: - Previews

#Preview("Balance Indicator Catalog") {
    NavigationView {
        TPEBalanceIndicatorCatalogView()
    }
}

#Preview("Basic Examples") {
    VStack(spacing: 20) {
        TPEBalanceIndicator()
        TPEBalanceIndicator(color: TPEColors.green70, itemCount: 3)
        TPEBalanceIndicator(color: TPEColors.orange70, itemCount: 7)
        TPEBalanceIndicator(color: TPEColors.red70, itemCount: 10)
    }
    .padding()
}
