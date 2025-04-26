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
    
    @State private var showSetLocation = false
    @State private var showMenu = false
    
    private var buttonTitle: String{
        locationStore.selectedAddress ?? "Set Location"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(isPresented: $showSetLocation) {
            SetLocationView()
        }
        .preferredColorScheme(settings.useDarkMode ? .dark : nil)
        .onTapGesture { if showMenu { showMenu = false } }
    }
}


#Preview {
    HomeView()
        .environmentObject(LocationStore())
        .environmentObject(AppSettings())
        .environmentObject(SessionManager.shared)
}
