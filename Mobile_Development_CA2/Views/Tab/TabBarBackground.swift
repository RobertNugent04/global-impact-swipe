//
//  TabBarBackground.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 13/04/2025.
//


import SwiftUI

/// Green bar with  a downward curve in the center.
struct TabBarBackground: Shape{
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let curveWidth: CGFloat = 120
        let curveDepth: CGFloat = 40
        
        p.addRoundedRect(in: rect, cornerSize: .init(width: 20, height: 20))
        
        // to carve the sccop
        p.move(to: CGPoint(x: rect.midX - curveWidth/2, y:0))
        p.addQuadCurve(to:   CGPoint(x: rect.midX, y: curveDepth),control: CGPoint(x: rect.midX - curveWidth/4, y: 0))
        p.addQuadCurve(to:   CGPoint(x: rect.midX + curveWidth/2, y: 0),control: CGPoint(x: rect.midX + curveWidth/4, y: 0))
        
        return p
    }
}
