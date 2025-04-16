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
                    .frame(height: UIScreen.main.bounds.height * 0.65)
                    .clipped()
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    IntroScreenView()
}
