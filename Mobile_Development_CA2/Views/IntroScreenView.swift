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
                    
                    VStack{
                        VStack(spacing: 0) {
                            Text("Swipe to make an")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text("impact")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "#4CAF50"))
                            
                            Text("One project at a time")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                    .padding(.top, 50)
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
