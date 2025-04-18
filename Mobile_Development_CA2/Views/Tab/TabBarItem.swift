//
//  TabBarItem.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 13/04/2025.
//

import SwiftUI

enum TabBarItem: Hashable, CaseIterable {
    case swipe, matches, notifications, profile
    
    var icon: String {
        switch self {
        case .swipe:
            return "arrow.left.arrow.right"
        case .matches:
            return "doc.on.doc"
        case .notifications:
            return "bell"
        case .profile:
            return "person"
        }
    }
}
