//
//  SetLocation.swift
//  Mobile_Development_CA2
//
//  Created by Student on 11/04/2025.
//

import SwiftUI
import MapKit

struct SetLocationView: View {
    @State var coordinate = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
    
    @State private var searchText = ""

    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                NavbarView()
                
                SearchBarView(text: $searchText)
                
                MapView(coordinate: coordinate)
                    .edgesIgnoringSafeArea(.bottom)
            }

            // Set Location Button
            VStack {
                Spacer()
                Button(action: {
                    //Set the location of the user
                }) {
                    Text("Set Location")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#2196F3"))
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    SetLocationView()
}
