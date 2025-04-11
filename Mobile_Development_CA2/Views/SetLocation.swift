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
        VStack(spacing: 0) {

            NavbarView()
            
            SearchBarView(text: $searchText)

            MapView(coordinate: coordinate)
                .edgesIgnoringSafeArea(.bottom)
        }

    }
}

#Preview {
    SetLocationView()
}
