//
//  SwipeVM.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class SwipeVM: ObservableObject {

    @Published private(set) var projects: [ProjectDTO] = []
    @Published private(set) var isBusy   = false
    @Published var currentIndex         = 0

    private var cancellables = Set<AnyCancellable>()

    func fetch(for country: String) async {
        isBusy = true
        defer { isBusy = false }

        guard let url = URL(string:
            "http://localhost:4000/projects?country=\(country)"
        ) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let list = try JSONDecoder().decode([ProjectDTO].self, from: data)
            projects = list.shuffled()
            currentIndex = 0
        } catch {
            print("SwipeVM fetch error:", error)
        }
    }

    // toggle like / unlike on backend
    static func setLike(_ like: Bool, for project: ProjectDTO, email: String) {
        guard let url = URL(string:
            "http://localhost:4000/projects/\(project.id)/\(like ? "like" : "unlike")"
        ) else { return }

        var req = URLRequest(url: url)
        req.httpMethod = "PATCH"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(["email": email])

        URLSession.shared.dataTask(with: req) { _, _, _ in
            
            // After request finishes, schedule notification if the project was liked
            if like {
                if let container = try? ModelContainer(for: AppNotification.self) {
                    let ctx = ModelContext(container)
                    Task {
                        await NotificationManager.shared.scheduleLike(
                            for: project,
                            context: ctx
                        )
                    }
                }
            }
        }.resume()
    }
}
