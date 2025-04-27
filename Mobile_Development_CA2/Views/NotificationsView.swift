//
//  NotificationsView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 14/04/2025.
//

import SwiftUI
import SwiftData

struct NotificationsView: View {
    @EnvironmentObject private var session     : SessionManager
    @EnvironmentObject private var settings     : AppSettings
    
    @Environment(\.modelContext) private var ctx
    @StateObject private var vm = NotificationsVM(
        context: ModelContext(
            (try? ModelContainer(for: AppNotification.self))!
        )
    )

    var body: some View {
        NavigationStack {
            Group {
                if vm.notes.isEmpty {
                    ContentUnavailableView("No notifications yet",
                                           systemImage: "bell.slash")
                } else {
                    List {
                        ForEach(vm.notes) { n in
                            NotificationRow(note: n)
                                .onTapGesture { vm.markRead(n) }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Notifications")
        }
        .preferredColorScheme(settings.useDarkMode ? .dark : nil)
    }
}

private struct NotificationRow: View {
    let note: AppNotification
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "bell.fill")
                .foregroundColor(Color(hex:"#4CAF50"))
            VStack(alignment: .leading, spacing: 4) {
                Text(note.title).fontWeight(.semibold).foregroundColor(.primary)
                Text(note.body).font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if !note.isRead {
                Circle().fill(Color.blue).frame(width:8,height:8)
            }
        }
        .padding(.vertical,6)
    }
}
