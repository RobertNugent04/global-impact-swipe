//
//  HomepageModels.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation

struct ProjectDTO: Codable, Identifiable {
    let id               : String
    let title            : String
    let status           : String
    let primaryImage     : String
    let images           : [String]
    let description      : String
    let startDate        : String
    let sdgPrimary       : Int
    let sdgSecondary     : [Int]
    let country, city    : String
    let lat, lon         : Double
    let organizer        : String
    let contactUrl       : String
    let contactNumber    : String
    let fundingGoal      : Int
    let fundingRaised    : Int
}

struct TipDTO:     Codable, Identifiable {
    let id       : String
    let image    : String
    let text     : String
    let source   : String
    let sdg      : Int
}
