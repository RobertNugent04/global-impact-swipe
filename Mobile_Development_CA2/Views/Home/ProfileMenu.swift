//
//  ProfileMenu.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import SwiftUI

struct ProfileMenu: View {
    @EnvironmentObject private var session: SessionManager
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(session.userEmail ?? "Unknown")
                        .fontWeight(.semibold)
                    Text(session.userEmail ?? "test.user@gmail.com")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()

            Divider()

            // dark-mode toggle
            Toggle(isOn: $settings.useDarkMode) {
                Label("Dark Mode", systemImage: "moon.fill")
            }
            .padding()
            
            Divider()

            // About
            NavigationLink {
                AboutView()
            } label: {
                Label("About", systemImage: "info.circle")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }

            Divider()

            // Log-out
            Button(role: .destructive) {
                session.logoutUser()
            } label: {
                Label("Log Out", systemImage: "arrow.right.square")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .frame(minWidth: 260, idealWidth: 300, maxWidth: 340)
        .padding(.top, 8)
        .shadow(radius: 4)
    }
}

#Preview {
    ProfileMenu()
        .environmentObject(SessionManager())
        .environmentObject(AppSettings())
}
