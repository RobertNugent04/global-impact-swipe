//
//  HomeRepository.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import SwiftUI

@MainActor
final class HomeRepository {
    private let cacheKeyProject = "cached_project"
    private let cacheKeyTip     = "cached_tip"
    
    // MARK: fetch online and fall back to last cache
    func randomProject() async -> ProjectDTO? {
        if let p: ProjectDTO = try? await APIClient.shared.get("/homepage/project") {
            cache(p, under: cacheKeyProject)
            return p
        }
        return read(ProjectDTO.self, key: cacheKeyProject)
    }
    
    func randomTip() async -> TipDTO? {
        if let t: TipDTO = try? await APIClient.shared.get("/homepage/tip") {
            cache(t, under: cacheKeyTip)
            return t
        }
        return read(TipDTO.self, key: cacheKeyTip)
    }
    
    private func cache<T:Codable>(_ obj:T, under key:String){
        if let data = try? JSONEncoder().encode(obj) {
            UserDefaults.standard.set(data, forKey:key)
        }
    }
    private func read<T:Codable>(_ type:T.Type, key:String)->T?{
        guard let data = UserDefaults.standard.data(forKey:key)
        else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
