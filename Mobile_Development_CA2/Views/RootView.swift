//
//  RootView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 11/04/2025.
//

import SwiftUI

struct RootView: View {
    @State private var showIntro = false

    var body: some View {
        NavigationStack {
            if showIntro {
                IntroScreenView()
            } else {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                            showIntro = true
                        }
                    }
            }
        }
    }
}
