//
//  ProjectCard.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct ProjectCard: View {
    let project: ProjectDTO

    private var cardSize: CGSize {
        let w = UIScreen.main.bounds.width - 32
        let h = UIScreen.main.bounds.height * 0.75
        return .init(width: w, height: h)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // primary image
            AsyncImage(
                url: URL(string:"http://localhost:4000/images/" + project.primaryImage),
                content: {
                    $0.resizable()
                      .scaledToFill()
                      .frame(width: cardSize.width, height: cardSize.height)
                },
                placeholder: { Color(.secondarySystemFill) }
            )
            .clipped()

            // glass-blur banner
            HStack(alignment: .top, spacing: 12) {
                Image("sdg\(project.sdgPrimary)")
                    .resizable().frame(width:48,height:60)
                    .shadow(radius:3)

                VStack(alignment:.leading, spacing:4) {
                    Text(project.title)
                        .font(.headline).foregroundColor(.white)

                    Text(project.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                }
            }
            .padding()
            .background(.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius:12))
            .padding()
        }
        .frame(width: cardSize.width, height: cardSize.height)
        .cornerRadius(20)
        .shadow(radius:5)
        .offset(y: -30)
    }
}
