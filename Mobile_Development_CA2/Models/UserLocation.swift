//
//  UserLocation.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import Foundation
import SwiftData

@Model
final class UserLocation {
    var address   : String
    var latitude  : Double
    var longitude : Double
    var savedAt   : Date

    init(address: String,
         latitude: Double,
         longitude: Double,
         savedAt:   Date = .now) {

        self.address   = address
        self.latitude  = latitude
        self.longitude = longitude
        self.savedAt   = savedAt
    }
}
