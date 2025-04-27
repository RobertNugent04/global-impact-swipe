//
//  HomeView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 14/04/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var locationStore: LocationStore
    @EnvironmentObject private var settings     : AppSettings
    @EnvironmentObject private var session      : SessionManager
    
    @StateObject private var vm = HomepageVM()
    @State private var showSetLocation = false
    @State private var showMenu = false
    
    private var buttonTitle: String{
        locationStore.selectedAddress ?? "Set Location"
    }
    
    var body: some View {
        ScrollView {
            header
                .zIndex(3)
            
            if let p = vm.project {
                ProjectCarousel(project: p)
                    .padding(.top, 20)
            } else if vm.isBusy{
                ProgressView().frame(maxWidth:.infinity)
            }
            
//            Divider().padding(.vertical,8)
            Rectangle()
                .fill(.secondary)
                .frame(height: 2)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            
            if let t = vm.tip {
                Text("Tip of the Day 🧠")
                    .font(.headline).padding(.horizontal,20).frame(maxWidth:.infinity,alignment:.leading)
                TipCard(tip:t).padding(.horizontal,16)
            }
            
            
        }
        .task { await vm.load() }
        .alert("Error", isPresented: Binding(get:{vm.error != nil},
                                             set:{ _ in vm.error=nil })) {
            Button("OK",role:.cancel){}
        } message:{ Text(vm.error ?? "") }
        .onTapGesture { showMenu=false }
        .preferredColorScheme(settings.useDarkMode ? .dark : nil)
    }
    
    private var header: some View {
        HStack {
            Button { showSetLocation = true } label:{
                HStack(spacing: 10) {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color(hex: "#4CAF50"))
                        .padding(8)
                        .background(Circle().fill(Color.white))

                    Text(buttonTitle)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 180, alignment: .leading)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(Color.black)
                .cornerRadius(30)
            }
            
            Spacer()
            
            //Avatar and pop over menu
            Button{showMenu.toggle()} label: {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            }
            .padding(8)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.45), radius: 4, y: 2)
            .overlay(alignment: .topTrailing) {
                if showMenu {
                    ProfileMenu()
                        .environmentObject(settings)
                        .environmentObject(session)
                        .offset(y: 50)
                        .zIndex(5)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            
        }
        .padding(.top, 2)
        .padding(.horizontal, 20)
        .navigationDestination(isPresented: $showSetLocation) {
            SetLocationView()
        }
    }
}

// project Carousel
private struct ProjectCarousel: View {
    let project: ProjectDTO
    var body: some View {
        VStack(alignment:.leading,spacing:10){
            ImageCarousel(urls: project.images, placeholder:"default_image")
                .frame(height:290)
                .clipShape(RoundedRectangle(cornerRadius:8))
            
            HStack(alignment:.top){
                VStack(alignment:.leading,spacing:4){
                    Text(project.title).font(.headline)
                    Text(project.description).font(.subheadline)
                        .foregroundColor(.secondary).lineLimit(2)
                        .padding(.bottom, 6)
                    Text(project.startDate).font(.caption)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                }
                Spacer()
                Image("sdg\(project.sdgPrimary)")
                    .resizable().frame(width:70,height:70)
            }
            .padding(.horizontal,4)
        }
        .padding(.horizontal,16)
    }
}


#Preview {
    HomeView()
        .environmentObject(LocationStore())
        .environmentObject(AppSettings())
        .environmentObject(SessionManager.shared)
}
