//
//  Mobile_Development_CA2App.swift
//  Mobile_Development_CA2
//
//  Created by Student on 10/03/2025.
//

import SwiftUI
import Firebase



@main
struct Mobile_Development_CA2App: App {
    @StateObject var session = SessionManager.shared
    @StateObject private var locationStore = LocationStore()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .environmentObject(locationStore)
        }
    }
}
