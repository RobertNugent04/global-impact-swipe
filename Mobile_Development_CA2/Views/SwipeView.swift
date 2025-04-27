//
//  SwipeView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 14/04/2025.
//


import SwiftUI

struct SwipeView: View {
    @EnvironmentObject private var locationStore: LocationStore
    @EnvironmentObject private var session     : SessionManager
    
    @StateObject private var vm               = SwipeVM()

    @State private var dragOffset: CGSize     = .zero
    @State private var showDetail             = false
    @State private var tappedProject: ProjectDTO?

    private var currentProject: ProjectDTO? {
        guard vm.currentIndex < vm.projects.count else { return nil }
        return vm.projects[vm.currentIndex]
    }

    var body: some View {
        ZStack {
            if let p = currentProject {
                ProjectCard(project: p)
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in dragOffset = value.translation }
                            .onEnded   { value in handleDrag(value) }
                    )
                    .onTapGesture(count:2) {
                        tappedProject = p
                        showDetail    = true
                    }
                    .overlay(likeDislikeOverlay, alignment: .center)
                    .animation(.spring(), value: dragOffset)
            } else if vm.isBusy {
                ProgressView()
            } else {
                Text("No projects in your area!")
                    .font(.title3).foregroundColor(.secondary)
            }
        }
        .task {
            let country = locationStore.selectedAddress?
                .split(separator: ",").last?
                .trimmingCharacters(in:.whitespacesAndNewlines) ?? "Ireland"
            await vm.fetch(for: country)
        }
        .navigationDestination(isPresented: $showDetail) {
//            ProjectDetailView(project: tappedProject!)
            if let tapped = tappedProject {
                    ProjectDetailView(project: tapped)
                } else {
                    Text("No Project Selected")
                        .font(.title)
                        .foregroundColor(.red)
                }
        }
    }

    // MARK: - Gestures
    private func handleDrag(_ value: DragGesture.Value) {
        let thresh: CGFloat = 100
        if value.translation.width < -thresh {
            animateOffScreen(to: -500) {
                if let proj = currentProject {
                    SwipeVM.setLike(false, for: proj, email: session.userEmail ?? "")
                }
            }
        } else if value.translation.width > thresh {
            animateOffScreen(to: 500) {
                if let proj = currentProject {
                    SwipeVM.setLike(true, for: proj, email: session.userEmail ?? "")
                }
            }
        } else {
            dragOffset = .zero
        }
    }

    private func animateOffScreen(to x: CGFloat, after: @escaping ()->Void) {
        withAnimation(.easeIn(duration:0.25)) {
            dragOffset = .init(width:x, height:0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) {
            dragOffset = .zero
            vm.currentIndex += 1
            after()
        }
    }

    // MARK: - Overlays
    @ViewBuilder private var likeDislikeOverlay: some View {
        if dragOffset.width > 60 {
            indicator(symbol:"heart.fill",color:.red)
        } else if dragOffset.width < -60 {
            indicator(symbol:"xmark",color:Color(hex: "#2C3E50"))
        }
    }
    private func indicator(symbol:String,color:Color)->some View {
        Image(systemName: symbol)
            .font(.system(size: 80, weight:.bold))
            .foregroundColor(color.opacity(0.85))
            .shadow(radius:6)
            .scaleEffect(1.2)
    }
}


#Preview {
    SwipeView()
        .environmentObject(LocationStore())
        .environmentObject(SessionManager())
}
