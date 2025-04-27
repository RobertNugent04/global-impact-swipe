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
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var settings     : AppSettings
    
    @EnvironmentObject private var session: SessionManager
    @State private var isLiked: Bool
    
    @State private var showPager = false
    
    @StateObject private var vm = SwipeVM()
    
    let project: ProjectDTO
    
    init(project: ProjectDTO, session: SessionManager = .shared) {
        self.project = project
        let email    = session.userEmail?.lowercased() ?? ""
        _isLiked     = State(
            initialValue: (project.likedBy ?? []).contains(email)
        )
    }
    
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
                            SwipeVM.setLike(isLiked, for: project, email: session.userEmail ?? "")
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
                                .resizable().frame(width:52,height:58)
                            ForEach(project.sdgSecondary, id:\.self) {
                                Image("sdg\($0)")
                                    .resizable().frame(width:46,height:46)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Key details of the project
                    VStack(alignment:.leading,spacing:8) {
                        label("Location", "\(project.city), \(project.country)")
                        label("Status", project.status.capitalized)
                        label("Start", pretty(project.startDate))
                        label("Organizer", project.organizer)
                    }
                    .padding(.horizontal)
                    
                    // Funding progress bar made with progress view
                    VStack(alignment:.leading,spacing:6){
                        Text("Funding")
                            .font(.headline)
                        ProgressView(value: fundingRatio)
                            .tint(Color(hex:"#4CAF50"))
                        Text("€\(project.fundingRaised.formatted()) of €\(project.fundingGoal.formatted()) raised")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Contact
                    VStack(alignment:.leading,spacing:10) {
                        Button {
                            call(project.contactNumber)
                        } label: {
                            Label(project.contactNumber,systemImage:"phone.fill")
                                .foregroundColor(Color(hex:"#4CAF50"))
                        }
                        Link(destination: URL(string:project.contactUrl)!) {
                            Label("Visit website",systemImage:"globe")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Gallery of remaining images
                    if project.images.count > 1 {
                        ThumbStrip(images: Array(project.images),
                                   onTap: { showPager = true })
                        .sheet(isPresented: $showPager) {
                            FullPager(images: project.images)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Map snapshot with the lat and lon
                    Map(initialPosition: .region(.init(
                            center: location,
                            span: .init(latitudeDelta: 0.15, longitudeDelta: 0.15))))
                        .frame(height:180)
                        .clipShape(RoundedRectangle(cornerRadius:12))
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                    
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
        .preferredColorScheme(settings.useDarkMode ? .dark : nil)
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
    
    private func call(_ number:String) {
        let digits = number.filter(\.isNumber)
        if let u = URL(string:"tel://"+digits) { openURL(u) }
    }
}


// MARK: – Gallery components ---------------------------------------------
private struct ThumbStrip: View {
    let images: [String]
    let onTap : ()->Void
    var body: some View {
        ScrollView(.horizontal,showsIndicators:false){
            HStack(spacing:12){
                ForEach(images,id:\.self){ path in
                    AsyncImage(url: URL(string:"http://localhost:4000/images/"+path)) {
                        $0.resizable().scaledToFill()
                    } placeholder: {
                        Color(.secondarySystemFill)
                    }
                    .frame(width:90,height:70)
                    .clipped()
                    .cornerRadius(8)
                }
            }
            .onTapGesture { onTap() }
        }
    }
}

private struct FullPager: View {
    let images:[String]
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack(alignment: .topTrailing){
            TabView{
                ForEach(images,id:\.self){ path in
                    AsyncImage(url: URL(string:"http://localhost:4000/images/"+path)) {
                        $0.resizable().scaledToFit()
                    } placeholder: { Color(.secondarySystemFill) }
                    .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode:.automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            Button {
                dismiss()
            } label: {
                Image(systemName:"xmark.circle.fill")
                    .font(.system(size:30))
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}


#Preview {
    ProjectDetailView(project: ProjectDTO(
        id: "1",
        title: "Sample Project Title",
        status: "active",
        primaryImage: "projects/dublin_main.jpg",
        images: ["projects/wexford_1.jpg", "projects/wexford_2.jpeg", "projects/wexford_3.jpg"],
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
        fundingRaised: 25000,
        likedBy: []
    ))
    .environmentObject(SessionManager())
    .environmentObject(LocationStore())
    .environmentObject(AppSettings())
}
