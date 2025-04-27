//
//  AppNotification.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation
import SwiftData

@Model
final class AppNotification: Identifiable {
    var id          : UUID
    var title       : String
    var body        : String
    var projectID   : String
    var createdAt   : Date
    var isRead      : Bool = false

    init(title: String,
         body:  String,
         projectID: String)
    {
        self.id        = .init()
        self.title     = title
        self.body      = body
        self.projectID = projectID
        self.createdAt = .now
    }
}
