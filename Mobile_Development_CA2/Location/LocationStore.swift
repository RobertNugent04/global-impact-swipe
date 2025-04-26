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
    
    private let defaultsKey = "persistedLocation-v1"
    
    init() {
        loadFromDefaults()
    }
    
    func setLocation(address: String, coordinate: CLLocationCoordinate2D) {
        selectedAddress = address
        selectedCoordinate = coordinate
        saveToDefaults(address: address, coordinate: coordinate)
    }
    
    func clearLocation() {
        selectedAddress = nil
        selectedCoordinate = nil
        UserDefaults.standard.removeObject(forKey: defaultsKey)
    }
    
    private func saveToDefaults(address: String, coordinate: CLLocationCoordinate2D) {
        let payload = PersistedLocation(address: address,
                                        latitude: coordinate.latitude,
                                        longitude: coordinate.longitude)
        if let data = try? JSONEncoder().encode(payload) {
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
    }
    
    private func loadFromDefaults() {
        guard
            let data   = UserDefaults.standard.data(forKey: defaultsKey),
            let saved  = try? JSONDecoder().decode(PersistedLocation.self, from: data)
        else { return }
        
        selectedAddress = saved.address
        selectedCoordinate = CLLocationCoordinate2D(latitude: saved.latitude,
                                                    longitude: saved.longitude)
    }
}
