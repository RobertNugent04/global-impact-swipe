//
//  TipCard.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct TipCard: View {
    let tip: TipDTO
    var body: some View {
        HStack(alignment:.top,spacing:12){
            AsyncImage(url: URL(string:"http://localhost:4000/"+tip.image)){ phase in
                (phase.image ?? Image("default_image"))
                    .resizable().scaledToFill()
            }
            .frame(width:80,height:80)
            .clipShape(RoundedRectangle(cornerRadius:6))
            
            VStack(alignment:.leading,spacing:4){
                Text(tip.text)
                    .font(.subheadline)
                Link(destination: URL(string: tip.source)!) {
                    Text("Learn More")
                        .font(.caption).padding(.horizontal,10).padding(.vertical,4)
                        .background(Color(hex:"#4CAF50"))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.top,4)
            }
            Spacer()
        }
        .padding(12)
    }
}
