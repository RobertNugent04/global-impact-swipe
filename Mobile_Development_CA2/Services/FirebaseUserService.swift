//
//  FirebaseUserService.swift
//  Mobile_Development_CA2
//
//  Created by Student on 23/04/2025.
//

import FirebaseAuth
import FirebaseFirestore

enum FirebaseUserHelper {
    
    static func loadUserData(
        // Use @escaping so the closures can be called after the Firestore operation completes.
        email: @escaping (String) -> Void,
        updateUserData: @escaping (UserData) -> Void
    ) {
        if let user = Auth.auth().currentUser {
            email(user.email ?? "No email")

            let uid = user.uid
            let db = Firestore.firestore()

            db.collection("users").document(uid).getDocument { document, error in
                if let document = document, document.exists,
                   let data = document.data() {
                    
                    let userData = UserData(
                        name: data["name"] as? String ?? "",
                        phoneNumber: data["phoneNumber"] as? String ?? ""
                    )
                    updateUserData(userData)
                }
            }
        }
    }
    
    //Reference for following code: https://stackoverflow.com/questions/64652736/how-do-i-add-data-to-current-users-uid-in-firestore-swift-ios
    static func saveUserData(
        userData: UserData,
        //Use @escaping to return success or failure after Firestore completes saving.
        onResult: @escaping (Bool, String) -> Void
    ) {
        guard let uid = Auth.auth().currentUser?.uid else {
            onResult(false, "User not found.")
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "name": userData.name,
            "phoneNumber": userData.phoneNumber,
        ], merge: true) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
                onResult(false, "Failed to save changes.")
            } else {
                onResult(true, "Changes saved successfully!")
            }
        }
    }
}
