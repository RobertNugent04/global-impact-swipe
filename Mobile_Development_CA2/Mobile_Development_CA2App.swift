//
//  Mobile_Development_CA2App.swift
//  Mobile_Development_CA2
//
//  Created by Student on 10/03/2025.
//

import SwiftUI
import Firebase
import SwiftData


@main
struct Mobile_Development_CA2App: App {
    @StateObject var session = SessionManager.shared
    @StateObject private var settings = AppSettings()
    
    private let container: ModelContainer = {
        let schema = Schema([UserLocation.self])
        return try! ModelContainer(for: schema)
    }()

    private var locationStore: LocationStore {
        LocationStore(context: container.mainContext)
    }
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .environmentObject(locationStore)
                .environmentObject(settings)
                .modelContainer(container)
        }
    }
}
