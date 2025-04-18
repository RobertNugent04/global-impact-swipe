//
//  HomeTabView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 14/04/2025.
//

import SwiftUI

struct HomeTabView: View {
    @State private var selection: TabBarItem = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // switch on selection
            Group {
                switch selection {
                case .home:         HomeView()
                case .swipe:         SwipeView()
                case .matches:       MatchesView()
                case .notifications: NotificationsView()
                case .profile:       ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CurvedTabBar(selection: $selection)
                .padding(.bottom, 10)
        }
        // To avoid the keyboard covering the tab bar
        .ignoresSafeArea(.keyboard)
    }
}
