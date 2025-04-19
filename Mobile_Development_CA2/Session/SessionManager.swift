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
    
    private let userDefaultsKey = "currentUserEmail"
    
    init(){
        checkLoginStatus()
    }
    
    func loginUser(email: String){
        self.userEmail = email
        self.isLoggedIn = true
        UserDefaults.standard.set(email, forKey: userDefaultsKey)
    }
    
    func logoutUser(){
        try? Auth.auth().signOut()
        self.userEmail = nil
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    func checkLoginStatus() {
        if let email = UserDefaults.standard.string(forKey: userDefaultsKey) {
            self.userEmail = email
            self.isLoggedIn = true
        }
    }
}
