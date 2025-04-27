//
//  ProjectCard.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct ProjectCard: View {
    let project: ProjectDTO
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(
                url: URL(string:"http://localhost:4000/images/" + project.primaryImage),
                content: { $0.resizable().scaledToFill() },
                placeholder: { Color(.secondarySystemFill) }
            )
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .clipped()

            // overlay banner
            HStack(alignment: .top, spacing: 12) {
                Image("sdg\(project.sdgPrimary)")
                    .resizable().frame(width:48,height:55)
                    .shadow(radius:3)

                VStack(alignment:.leading, spacing:4) {
                    Text(project.title)
                        .font(.headline).foregroundColor(.white)
                    Text(project.description)
                        .font(.subheadline).foregroundColor(.white.opacity(0.9))
                        .lineLimit(2)
                }
            }
            .padding()
            .background(.ultraThinMaterial, in:
                RoundedRectangle(cornerRadius:12, style:.continuous))
            .padding()
        }
        .cornerRadius(20)
        .shadow(radius:5)
    }
}
