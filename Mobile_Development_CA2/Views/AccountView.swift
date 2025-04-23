//
//  AccountView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 17/04/2025.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

struct AccountView: View {
    // Hardcoded values for email, password, and confirm password
    @State private var name: String = ""
    @State private var email: String = "user@example.com"
    @State private var phoneNumber: String = "+353851233456"
    @State private var password: String = "**********"
    @State private var showAlert = false
    @State private var saveMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack {
                Text("Edit Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#333333"))

                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFit()

                    Image(systemName: "camera.fill")
                        .padding(6)
                    
                        .font(.system(size: 25))
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: 5, y: 5)
                }
                .frame(width: 150, height: 150)
            }
            .frame(maxWidth: .infinity)


            
            // E-mail Title and Field
            Text("Name")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
   
            TextField("Enter your name", text: $name)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .frame(maxWidth: .infinity)
            
            
            // E-mail Title and Field
            Text("E-mail")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
            TextField("Enter your e-mail", text: $email)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .frame(maxWidth: .infinity)
                

            // Password Title and Field
            Text("Phone Number")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
            TextField("Enter your phone number", text: $phoneNumber)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .frame(maxWidth: .infinity)

            Text("Password")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
            SecureField("", text: $password)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .disabled(true)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 20) {
                Button(action: {
                    // Save Changes
                    saveUserData()
                }) {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Button(action: {
                    // Cancel Changes
                    loadUserData()
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
            .frame(width: 330)
            .padding(.top, 10)
            .padding(.leading, 22)

     
        }
        .padding()
        .padding(.top, 130)
        .padding(.bottom, 170)
        .onAppear {
            loadUserData()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Save Status"),
                message: Text(saveMessage),
                dismissButton: .default(Text("OK"))
            )
        }

        
    }
    
    func loadUserData() {
        if let user = Auth.auth().currentUser {
            email = user.email ?? "No email"

            let uid = user.uid
            let db = Firestore.firestore()

            db.collection("users").document(uid).getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    name = data?["name"] as? String ?? ""
                    phoneNumber = data?["phoneNumber"] as? String ?? ""
                    
                }
            }
        }
    }
    
    //Reference for following code: https://stackoverflow.com/questions/64652736/how-do-i-add-data-to-current-users-uid-in-firestore-swift-ios
    func saveUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "name": name,
            "phoneNumber": phoneNumber
        ], merge: true) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
                saveMessage = "Failed to save changes."
            } else {
                saveMessage = "Changes saved successfully!"
            }
            showAlert = true
        }
    }

    
}

#Preview {
    AccountView()
}
