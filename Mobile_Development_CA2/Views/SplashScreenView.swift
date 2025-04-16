//
//  SplashScreenView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 11/04/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var animateLogo = false
    @State private var showTitle = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack{
                VStack(spacing: 30) {
                    Image("sdg_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .rotationEffect(.degrees(animateLogo ? 360 : 0))
                        .animation(.easeInOut(duration: 2), value: animateLogo)
                    
                    if showTitle {
                        Text("GLOBAL IMPACT SWIPE")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .transition(.move(edge: .leading))
                            .animation(.easeInOut(duration: 2), value: showTitle)
                    }
                }
                
                Spacer()
                
            }
            .padding(.top, 170)
            
        }
        
        .onAppear {
            animateLogo = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showTitle = true
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
