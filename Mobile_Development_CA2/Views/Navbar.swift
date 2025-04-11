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
            Spacer()
        }
        .background(Color(hex: "#4CAF50"))
        .frame(maxWidth: .infinity, alignment: .top)
        
    }
    
}

#Preview {
    NavbarView()
}
