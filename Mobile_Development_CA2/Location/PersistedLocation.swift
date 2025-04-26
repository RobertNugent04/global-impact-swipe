//
//  PersistedLocation.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import Foundation
import CoreLocation

struct PersistedLocation: Codable {
    let address: String
    let latitude: Double
    let longitude: Double
}
