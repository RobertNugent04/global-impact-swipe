//
//  HomeView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 14/04/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var locationStore: LocationStore
    @State private var showSetLocation = false
    
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
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(Color.black)
                    .cornerRadius(30)
                }
                
                Spacer()
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(isPresented: $showSetLocation) {
            SetLocationView()
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(LocationStore())
}
