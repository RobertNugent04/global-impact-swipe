//
//  AboutView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 26/04/2025.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject private var session     : SessionManager
    @EnvironmentObject private var settings     : AppSettings
    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {

                Text("About Global Impact Swipe")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                Group {
                    Text("Who built this?")
                        .font(.title2.weight(.semibold))

                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 16) {
                            Image("patrick")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text("Patrick Orjieh")
                                    .font(.headline)
                                Text("Student No. D00251785")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                        HStack(spacing: 16) {
                            Image("robert")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text("Robert Nugent")
                                    .font(.headline)
                                Text("Student No. D00244618")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Text("Dr.")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                )

                            VStack(alignment: .leading) {
                                Text("Dr. Ruth McKeever")
                                    .font(.headline)
                            }
                        }
                    }
                }

                Group {
                    Text("Why did we build it?")
                        .font(.title2.weight(.semibold))

                    Text("""
                        The assignment brief asked us to build an app that produces a \
                        *net positive impact* on the world.  
                        We centred our solution around the **United Nations \
                        Sustainable Development Goals (SDGs)** — 17 goals that act as \
                        a blueprint for a more sustainable future.
                        """)
                }

                Group {
                    Text("What does the app do?")
                        .font(.title2.weight(.semibold))

                    Text("""
                        *Global Impact Swipe* connects you with real-world projects \
                        that advance one or more SDGs.

                        • **Discover** — the Home screen shows a random project and a \
                        daily sustainability tip.  
                        • **Swipe** — like or pass on projects Tinder-style.  
                        • **Matches** — view a list of projects you have liked.  
                        • **Details** — deep-dive into a project, view funding \
                        progress, organiser details, location map and more.  
                        • **Set location** — filter projects by your country.  
                        • **Light / Dark mode** toggle in the profile menu.
                        """)
                }

                Group {
                    Text("How to interact with the app")
                        .font(.title2.weight(.semibold))

                    Text("""
                        1. **Set your location** on the Home screen.  
                        2. **Swipe** right ❤️ to like, left ✕ to skip.  
                        3. **Double-tap** a card for full details.  
                        4. In the detail view you can  
                           • tap the **heart** to like / unlike,  
                           • tap **Call** to phone the organiser (iOS will ask for \
                             permission),  
                           • tap **Visit website** to open the organiser’s URL.  
                        5. All liked projects appear under **Matches**; tap any card \
                           to reopen its details.
                        """)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Learn more about the SDGs")
                        .font(.headline)
                    Button {
                        openURL(URL(string:"https://sdgs.un.org/goals")!)
                    } label: {
                        Text("Visit un.org/sdgs")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex:"#4CAF50"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { AboutView()
        .environmentObject(SessionManager())
        .environmentObject(AppSettings())
}
