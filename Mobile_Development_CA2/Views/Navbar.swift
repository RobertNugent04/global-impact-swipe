//
//  Navbar.swift
//  Mobile_Development_CA2
//
//  Created by Student on 11/04/2025.
//

import SwiftUI

struct NavbarView: View {
    
    var body: some View {
        
        HStack {
            Image("logo-no-background")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .padding(.bottom, 10)
            
            Spacer()
            
            Button(action: {
                //Navigate to map view
            }) {
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
            }
            .padding(.trailing, 20)
            .padding(.bottom, 10)
            
            Button(action: {
                // Navigate to profile view
            }) {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
            }
            .padding(.trailing, 16)
            .padding(.bottom, 10)

        }
        .background(Color(hex: "#4CAF50"))
        .frame(maxWidth: .infinity, alignment: .top)
        
    }
    
}

#Preview {
    NavbarView()
}
