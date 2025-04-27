//
//  MatchesView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 18/04/2025.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject private var session: SessionManager
    @EnvironmentObject private var settings     : AppSettings
    @StateObject private var vm = MatchesVM()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isBusy {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if vm.projects.isEmpty {
                    ContentUnavailableView(
                        "No matches yet",
                        systemImage: "heart.slash"
                    )
                } else {
                    ScrollView {
                        Text("Project Matches")
                            .font(.title).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 8)

                        LazyVStack(spacing: 14) {
                            ForEach(vm.projects) { p in
                                NavigationLink(value: p) {
                                    MatchCard(project: p)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
//            .navigationTitle("Matches")
            .navigationDestination(for: ProjectDTO.self) { p in
                ProjectDetailView(project: p)
            }
            .task {
                if let email = session.userEmail {
                    await vm.fetch(email: email)
                }
            }
            .alert("Error",
                   isPresented: Binding(
                        get: { vm.error != nil },
                        set: { _ in vm.error = nil })
            ) { Button("OK", role: .cancel) {} }
            message: { Text(vm.error ?? "")
            }
            .preferredColorScheme(settings.useDarkMode ? .dark : nil)
        }
    }
}

#Preview {
    MatchesView()
        .environmentObject(SessionManager())
        .environmentObject(AppSettings())
        .environmentObject(LocationStore())
}
