//
//  FileHelpers.swift
//  Mobile_Development_CA2
//
//  Created by Student on 23/04/2025.
//

//Reference used for following functions: https://cocoacasts.com/fm-1-how-to-get-documents-directory-in-swift?utm_source=chatgpt.com

import Foundation

func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func getProfileImagePath(for uid: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent("\(uid)_profile.jpg")
}

func saveImageLocally(_ data: Data, uid: String) {
    let url = getProfileImagePath(for: uid)
    do {
        try data.write(to: url)
        print("Saved image to \(url)")
    } catch {
        print("Failed to save image: \(error)")
    }
}

func loadImageLocally(uid: String) -> Data? {
    let url = getProfileImagePath(for: uid)
    if FileManager.default.fileExists(atPath: url.path) {
        return try? Data(contentsOf: url)
    }
    return nil
}
