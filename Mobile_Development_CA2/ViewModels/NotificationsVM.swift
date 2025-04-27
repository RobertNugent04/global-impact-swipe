//
//  NotificationsVM.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation
import SwiftData

@MainActor
final class NotificationsVM: ObservableObject {
    @Published var notes: [AppNotification] = []

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetch()
    }

    func fetch() {
        let desc = FetchDescriptor<AppNotification>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        notes = (try? context.fetch(desc)) ?? []
    }

    func markRead(_ note: AppNotification) {
        note.isRead = true
        try? context.save()
        fetch()
    }
}
