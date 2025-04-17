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
