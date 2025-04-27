//
//  ImageCarousel.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct ImageCarousel: View {
    let urls: [String]
    let placeholder: String
    
    var body: some View {
        TabView {
            ForEach(urls, id:\.self){ path in
                AsyncImage(url: URL(string:"http://localhost:4000/images/"+path)) { phase in
                    switch phase {
                    case .success(let image): image
                            .resizable().scaledToFill()
                    default: Image(placeholder)
                            .resizable().scaledToFill()
                    }
                }
                .frame(maxWidth:.infinity,maxHeight:.infinity)
                .clipped()
            }
        }
        .tabViewStyle(.page(indexDisplayMode:.automatic))
    }
}
