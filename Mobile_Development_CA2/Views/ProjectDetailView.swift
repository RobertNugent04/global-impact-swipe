//
//  ProjectDetailView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI
import MapKit

struct ProjectDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var session: SessionManager
    @State private var isLiked = false
    
    let project: ProjectDTO
    
    // helpers
    private var fundingRatio: Double {
        Double(project.fundingRaised) / Double(project.fundingGoal)
    }
    private var location: CLLocationCoordinate2D {
        .init(latitude: project.lat, longitude: project.lon)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Title
                    Text(project.title)
                        .font(.title).fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    // Primary image and like
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(
                            url: URL(string:"http://localhost:4000/images/"+project.primaryImage),
                            content:{ $0.resizable().scaledToFill() },
                            placeholder:{ Color(.secondarySystemFill) }
                        )
                        .frame(maxWidth:.infinity, maxHeight: 280)
                        .clipped()
                        .cornerRadius(12)
                        
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .font(.system(size: 26, weight:.bold))
                                .foregroundColor(isLiked ? .red : .white)
                                .padding(14)
                                .background(.ultraThinMaterial,in:Circle())
                        }
                        .padding(18)
                    }
                    .padding(.horizontal)
                    
                    // Description and the SDGs
                    VStack(alignment:.leading, spacing:12) {
                        Text(project.description)
                        HStack(spacing:12) {
                            Image("sdg\(project.sdgPrimary)")
                                .resizable().frame(width:42,height:48)
                            ForEach(project.sdgSecondary, id:\.self) {
                                Image("sdg\($0)")
                                    .resizable().frame(width:30,height:36)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
            }
            
            // close button bottom left
            Button {
                dismiss()
            } label: {
                Image(systemName:"xmark")
                    .font(.system(size:20,weight:.bold))
                    .foregroundColor(.white)
                    .padding(14)
                    .background(Color.black.opacity(0.75),in:Circle())
            }
            .padding([.leading,.bottom],24)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func label(_ title:String,_ value:String)->some View {
        HStack {
            Text(title + ":").foregroundColor(.secondary)
            Text(value)
        }
    }
    
    private func pretty(_ iso:String)->String {
        ISO8601DateFormatter().date(from: iso)?
            .formatted(date:.abbreviated,time:.omitted) ?? iso
    }
}

#Preview {
    ProjectDetailView(project: ProjectDTO(
        id: "1",
        title: "Sample Project Title",
        status: "active",
        primaryImage: "projects/dublin_main.jpg",
        images: ["sample_image1.jpg", "sample_image2.jpg"],
        description: "This is a sample project description. It should be long enough to see how it behaves in the UI.",
        startDate: "2025-05-01",
        sdgPrimary: 13,
        sdgSecondary: [7],
        country: "Ireland",
        city: "Dublin",
        lat: 53.3498,
        lon: -6.2603,
        organizer: "Sample Organizer",
        contactUrl: "https://example.com",
        contactNumber: "+353123456789",
        fundingGoal: 50000,
        fundingRaised: 25000
    ))
    .environmentObject(SessionManager())
}

