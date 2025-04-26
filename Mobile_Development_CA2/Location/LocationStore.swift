//
//  LocationStore.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import Foundation
import MapKit

final class LocationStore: ObservableObject {
    @Published var selectedAddress: String?
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    
    func setLocation(address: String, coordinate: CLLocationCoordinate2D) {
        selectedAddress = address
        selectedCoordinate = coordinate
    }
    
    func clearLocation() {
        selectedAddress = nil
        selectedCoordinate = nil
    }
}
