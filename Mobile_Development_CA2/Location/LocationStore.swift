//
//  LocationStore.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import Foundation
import SwiftData
import CoreLocation

@MainActor
final class LocationStore: ObservableObject {

    @Published var selectedAddress   : String?
    @Published var selectedCoordinate: CLLocationCoordinate2D?

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        hydrateFromStore()
    }

    // Preview only convenience
    convenience init() {
        let schema = Schema([UserLocation.self])
        let memCfg = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: memCfg)
        self.init(context: container.mainContext)
    }

    func setLocation(address: String, coordinate: CLLocationCoordinate2D) {
        // keep only the latest row
        let fetch = FetchDescriptor<UserLocation>()
        if let old = try? context.fetch(fetch) {
            old.forEach { context.delete($0) }
        }

        let loc = UserLocation(address: address,
                               latitude: coordinate.latitude,
                               longitude: coordinate.longitude)
        context.insert(loc)
        try? context.save()

        selectedAddress    = address
        selectedCoordinate = coordinate
    }

    func clear() {
        let fetch = FetchDescriptor<UserLocation>()
        if let rows = try? context.fetch(fetch) {
            rows.forEach { context.delete($0) }
        }
        try? context.save()
        selectedAddress    = nil
        selectedCoordinate = nil
    }

    private func hydrateFromStore() {
        var fetch = FetchDescriptor<UserLocation>(
            sortBy: [SortDescriptor(\.savedAt, order: .reverse)]
        )
        fetch.fetchLimit = 1

        if let first = (try? context.fetch(fetch))?.first {
            selectedAddress    = first.address
            selectedCoordinate = .init(latitude: first.latitude,
                                       longitude: first.longitude)
        }
    }
}
