//
//  AuthManager.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 12/04/2025.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

/// Singleton that will handle Sign in with Apple with Firebase.
final class AuthManager: NSObject {

    static let shared = AuthManager()

    /// Keeps the raw (un‑hashed) nonce until we get the Apple response.
    private var currentNonce: String?
}

// MARK: - Helpers
private extension AuthManager {

    /// Generates a cryptographically secure random nonce of the given length.
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length

        while remaining > 0 {
            var random: UInt8 = 0
            let status = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            guard status == errSecSuccess else {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed.")
            }
            if random < charset.count {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
        return result
    }

    /// Returns the SHA‑256 hash of the input string as a hex‑encoded string.
    static func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
