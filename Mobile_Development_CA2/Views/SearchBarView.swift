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
                .padding(.leading, 40)
                .padding(.vertical, 20)
                .background(Color(.white))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 25)
                        Spacer()
                    }
                )
            
        }
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
