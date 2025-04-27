//
//  ProjectDetailView.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

struct ProjectDetailView: View {
    let project: ProjectDTO
    var body: some View {
        Text("Project Detail: \(project.title)")
            .font(.largeTitle).padding()
    }
}
