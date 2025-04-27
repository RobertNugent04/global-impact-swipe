//
//  MatchesVM.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation

@MainActor
final class MatchesVM: ObservableObject {
    @Published var projects : [ProjectDTO] = []
    @Published var isBusy   = false
    @Published var error    : String?
    
    func fetch(email: String) async {
        isBusy = true
        defer { isBusy = false }
        do {
            projects = try await APIClient.shared.likedProjects(for: email)
        } catch {
            self.error = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
    }
}
