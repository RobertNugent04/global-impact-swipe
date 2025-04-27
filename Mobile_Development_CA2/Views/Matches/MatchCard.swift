//
//  MatchCard.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct MatchCard: View {
    let project: ProjectDTO
    
    var body: some View {
        HStack(spacing:12){
            AsyncImage(url: url(for: project.primaryImage)) {
                $0.resizable().scaledToFill()
            } placeholder: {
                Color(.secondarySystemFill)
            }
            .frame(width:110,height:90)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment:.leading, spacing:4){
                Text(project.title)
                    .font(.headline).lineLimit(2)
                    .foregroundColor(.black)
                Text(project.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth:.infinity,alignment:.leading)

            Image("sdg\(project.sdgPrimary)")
                .resizable().frame(width:34,height:40)
        }
        .padding(12)
        .background(Color(.systemBackground),in:RoundedRectangle(cornerRadius:12))
        .shadow(radius:2,y:2)
    }
    
    private func url(for path:String)->URL? {
        URL(string:"http://localhost:4000/images/"+path)
    }
}
