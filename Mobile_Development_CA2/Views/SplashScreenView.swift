//
//  SplashScreenView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 11/04/2025.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Image("logo-no-background")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
