
import SwiftUI

public struct LoginCard: View {
    let title: String
    let subtitle: String
    let loginText: String
    let onLoginTap: () -> Void
    let onRegisterTap: () -> Void
    let cardHeight: CGFloat
    
    public init(
        title: String,
        subtitle: String,
        loginText: String,
        onLoginTap: @escaping () -> Void,
        onRegisterTap: @escaping () -> Void,
        cardHeight: CGFloat = 320
    ) {
        self.title = title
        self.subtitle = subtitle
        self.loginText = loginText
        self.onLoginTap = onLoginTap
        self.onRegisterTap = onRegisterTap
        self.cardHeight = cardHeight
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            OvalTopShape()
                .fill(Color.white)
                .frame(height: cardHeight)
                .overlay(
                    VStack(spacing: 0) {
                        Spacer().frame(height: 68)
                        
                        VStack(spacing: 8) {
                            TPEText(
                                text: title,
                                variant: .text16Bold,
                                color: TPEColors.black,
                                textAlignment: .center
                            )
                            
                            TPEText(
                                text: subtitle,
                                variant: .secondary,
                                color: TPEColors.black,
                                textAlignment: .center
                            )
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 44)
                        
                        TPEButton(
                            title: loginText,
                            variant: .primary,
                            size: .medium,
                            roundType: .rounded,
                            isCentered: true,
                            isEnabled: true,
                            onPressed: onLoginTap
                        )
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 24)
                        
                        HStack(spacing: 4) {
                            TPEText(
                                text: "Don't have account?",
                                variant: .secondary,
                                color: TPEColors.black,
                                textAlignment: .center
                            )
                            
                            TPELinkText(
                                text: "Registration Account",
                                color: TPEColors.primaryBlue,
                                onTap: onRegisterTap
                            )
                        }
                        
                        Spacer()
                    }
                )
        }
    }
}

struct OvalTopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: 40))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: 40),
            control: CGPoint(x: rect.midX, y: -40)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}
