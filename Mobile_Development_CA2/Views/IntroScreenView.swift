//
//  IntroScreenView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 11/04/2025.
//

import SwiftUI

import SwiftUI

struct IntroScreenView: View {
    var body: some View {
            VStack(spacing: 0) {
                // Top Image
                Image("intro_banner")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.60)
                    .clipped()
                
                // Bottom Overlay
                ZStack {
                    Color.white
                        .cornerRadius(60, corners: [.topLeft, .topRight])
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: -5)
                    
                    Spacer()
                }
                .offset(y: -60)
                .frame(height: UIScreen.main.bounds.height * 0.40)

            }
            .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    IntroScreenView()
}
