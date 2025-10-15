//
//  TPEShapes.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 15/10/25.
//

import SwiftUI

public struct FlipRoundedTopShape: Shape {
    public init() {}
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let curveStartY = rect.height * 0.3
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: curveStartY))
        
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: curveStartY),
            control: CGPoint(x: rect.width / 2, y: rect.height * 0.1)
        )
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
