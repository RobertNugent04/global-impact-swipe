//
//  SessionManager.swift
//  Mobile_Development_CA2
//
//  Created by Patrick Orjieh on 15/04/2025.
//

import Foundation
import FirebaseAuth

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var userEmail: String? = nil
    
    private let userDefaultsEmailKey = "currentUserEmail"
    private let userDefaultsLoginTimeKey = "currentUserLoginTime"
    private let sessionExpiryDuration: TimeInterval = 60 * 60 * 24 * 30 // 30 days
    
    init(){
        checkLoginStatus()
    }
    
    func loginUser(email: String){
        let now = Date()
        self.userEmail = email
        self.isLoggedIn = true
        
        UserDefaults.standard.set(email, forKey: userDefaultsEmailKey)
        UserDefaults.standard.set(now, forKey: userDefaultsLoginTimeKey)
    }
    
    func logoutUser(){
        try? Auth.auth().signOut()
        self.userEmail = nil
        self.isLoggedIn = false
        
        UserDefaults.standard.removeObject(forKey: userDefaultsEmailKey)
        UserDefaults.standard.removeObject(forKey: userDefaultsLoginTimeKey)
    }
    
    func checkLoginStatus() {
        guard let email = UserDefaults.standard.string(forKey: userDefaultsEmailKey),
              let loginTime = UserDefaults.standard.object(forKey: userDefaultsLoginTimeKey) as? Date else {
            isLoggedIn = false
            userEmail = nil
            return
        }

        let now = Date()
        let timeElapsed = now.timeIntervalSince(loginTime)

        if timeElapsed <= sessionExpiryDuration {
            self.userEmail = email
            self.isLoggedIn = true
        } else {
            // Session has expired
            logoutUser()
        }
    }
}
