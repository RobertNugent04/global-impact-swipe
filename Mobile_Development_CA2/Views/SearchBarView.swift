//
//  SearchBarView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 11/04/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search for a location", text: $text)
                .padding(.leading, 35)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                    }
                )
            
        }
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
