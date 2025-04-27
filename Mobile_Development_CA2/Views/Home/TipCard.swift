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
        HStack(alignment: .bottom, spacing: 12) {
            AsyncImage(url: URL(string:"http://localhost:4000/images/"+tip.image)) { phase in
                (phase.image ?? Image("default_image"))
                    .resizable().scaledToFill()
            }
            .frame(width: 120, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 6) {
                Spacer(minLength: 0)

                Text(tip.text)
                    .font(.subheadline)

                HStack {
                    Spacer()
                    Link(destination: URL(string: tip.source)!) {
                        Text("Learn More")
                            .font(.caption2).bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(hex: "#4CAF50"))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .bottomLeading)
        .padding(12)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
