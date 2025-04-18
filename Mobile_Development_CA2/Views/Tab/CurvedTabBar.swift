//
//  CurvedTabBar.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 13/04/2025.
//

import SwiftUI

struct CurvedTabBar: View {
    @Binding var selection: TabBarItem

    var body: some View {
        ZStack {
            // background
            TabBarBackground()
                .fill(Color(hex: "#4CAF50"))
                .frame(height: 80)
                .shadow(color: .black.opacity(0.15), radius: 4, y: 2)

            // SDG logo in the center
            Button {
                selection = .home
            } label: {
                Image("sdg_logo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .background(Circle().fill(Color.white))
                    .clipShape(Circle())
            }
            .offset(y: -20)

            // icons
            HStack(spacing: 40) {
                ForEach(TabBarItem.allCases, id: \.self) { item in
                    Button {
                        selection = item
                    } label: {
                        Image(systemName: item.icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
}
