//
//  RootView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 11/04/2025.
//

import SwiftUI

struct RootView: View {
    @State private var hasFinishedSplash = false
    @EnvironmentObject var session: SessionManager

    var body: some View {
        NavigationStack {
            ZStack {
                if hasFinishedSplash {
                    if session.isLoggedIn {
                        HomeTabView()
                            .transition(.opacity)
                    }else{
                        IntroScreenView()
                            .transition(.opacity)
                    }
                } else {
                    SplashScreenView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 1.0), value: hasFinishedSplash)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    hasFinishedSplash = true
                }
            }
        }
    }
}
