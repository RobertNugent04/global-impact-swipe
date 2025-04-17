//
//  SetLocation.swift
//  Mobile_Development_CA2
//
//  Created by Student on 11/04/2025.
//

import SwiftUI
import MapKit

struct SetLocationView: View {
    
    //Default coordinates if none selected
    @State var coordinate = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
    
    @State private var searchText = ""

    //Location Manger for permissions
    @StateObject private var locationManager = LocationManager()
    
    //Autcomplete for search bar
    @StateObject private var autocomplete = AutocompleteViewModel()

    var body: some View {
        ZStack() {
            
            VStack(spacing: 0) {
                
                NavbarView()
                
                SearchBarView(text: $searchText)
                    .onChange(of: searchText) { oldValue, newValue in
                        if newValue.isEmpty {
                            autocomplete.suggestions = []
                        } else {
                            autocomplete.updateSearch(query: newValue)
                        }
                    }

                // Suggestions List
                if !autocomplete.suggestions.isEmpty && !searchText.isEmpty {
                    ScrollView {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            // Loop through each suggestion in the autocomplete results
                            ForEach(autocomplete.suggestions, id: \.self) { suggestion in
                                
                                //Reference: https://developer.apple.com/documentation/mapkit/mklocalsearch/request
                                
                                Button(action: {
                                    // Combine the suggestion's title and subtitle to create a full query string
                                    let fullQuery = "\(suggestion.title), \(suggestion.subtitle)"
                                    
                                    searchText = fullQuery
                                    
                                    // Clear the current autocomplete suggestions after selection
                                    autocomplete.suggestions = []

                                    let request = MKLocalSearch.Request()
                                    request.naturalLanguageQuery = fullQuery
                                    
                                    let search = MKLocalSearch(request: request)
                                    
                                    search.start { response, error in
                                        // Safely unwrap the first result (if any) from the response
                                        guard let item = response?.mapItems.first else { return }
                                        coordinate = item.placemark.coordinate
                                    }
                                }) {
                                    VStack(alignment: .leading) {
                                        Text(suggestion.title)
                                            .fontWeight(.medium)
                                        if !suggestion.subtitle.isEmpty {
                                            Text(suggestion.subtitle)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                }
                            }
                        }
                    }
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .zIndex(1)
                }

                MapView(coordinate: coordinate)
                    .edgesIgnoringSafeArea(.bottom)
            }

            VStack {
                Spacer()
                Button(action: {
                    // Set the location of the user
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
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}

#Preview {
    SetLocationView()
}
