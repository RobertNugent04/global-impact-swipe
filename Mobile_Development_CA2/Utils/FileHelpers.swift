//
//  FileHelpers.swift
//  Mobile_Development_CA2
//
//  Created by Student on 23/04/2025.
//

import Foundation

func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func getProfileImagePath() -> URL {
    getDocumentsDirectory().appendingPathComponent("profile.jpg")
}

func saveImageLocally(_ data: Data) {
    let url = getProfileImagePath()
    do {
        try data.write(to: url)
    } catch {
        print("Failed to save image: \(error)")
    }
}

func loadImageLocally() -> Data? {
    let url = getProfileImagePath()
    return try? Data(contentsOf: url)
}
