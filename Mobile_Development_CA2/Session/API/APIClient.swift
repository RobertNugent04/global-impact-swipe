//
//  APIClient.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 27/04/2025.
//

import Foundation

enum APIError: Error { case badURL, decoding }

actor APIClient {
    static let shared = APIClient()
    private let base  = "http://localhost:4000"
    
    func get<T: Decodable>(_ path: String) async throws -> T {
        guard let url = URL(string: base + path) else { throw APIError.badURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
