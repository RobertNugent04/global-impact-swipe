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
                .frame(height: 70)
                .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
                .padding(.horizontal, 15)

            // SDG logo in the center
            Button {
                selection = .home
            } label: {
                Image("sdg_logo")
                    .resizable()
                    .frame(width: 52, height: 52)
                    .background(Circle().fill(Color.white))
                    .clipShape(Circle())
            }
            .offset(y: -45)

            // icons
            HStack(spacing: 57) {
                ForEach(TabBarItem.allCases.filter {$0 != .home}, id: \.self) { item in
                    Button {
                        selection = item
                    } label: {
                        Image(systemName: item.icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(selection == item ? Color(hex: "#4CAF50") : .white)
                            .background(
                                Circle()
                                    .fill(selection == item ? Color.white : Color.clear)
                                    .frame(width: 40, height: 40)
                            )
                            .padding(10)
                            
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
}
