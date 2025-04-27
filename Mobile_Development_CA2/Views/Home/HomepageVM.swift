//
//  HomepageVM.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

@MainActor
final class HomepageVM: ObservableObject {
    @Published var project : ProjectDTO?
    @Published var tip     : TipDTO?
    @Published var isBusy  = false
    @Published var error   : String?
    
    private let repo = HomeRepository()
    
    func load() async {
        isBusy = true ; defer { isBusy = false }
        async let p = repo.randomProject()
        async let t = repo.randomTip()
        project = await p
        tip     = await t
        if project == nil || tip == nil {
            error = "Couldn’t load homepage content."
        }
    }
}
