//
//  AccountView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 17/04/2025.
//

import SwiftUI
import PhotosUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct AccountView: View {
    // Hardcoded values for email, password, and confirm password
    @State private var email: String = "user@example.com"
    @State private var password: String = "**********"
    @State private var showAlert = false
    @State private var saveMessage: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImageData: Data?
    @State private var profileImageURL: String?
    @State private var userData = UserData()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack {
                Text("Edit Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#333333"))

                ZStack(alignment: .bottomTrailing) {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .frame(width: 150, height: 150)
//                        .scaledToFit()
//
//                    Image(systemName: "camera.fill")
//                        .padding(6)
//                    
//                        .font(.system(size: 25))
//                        .background(Color.white)
//                        .clipShape(Circle())
//                        .offset(x: 5, y: 5)
                    
                    // Show the selected profile image if available
                    if let data = profileImageData, let image = UIImage(data: data) {
                          Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    }

                    //Some code for PhotosPicker taken from the following sources:
                    //https://developer.apple.com/documentation/photokit/bringing-photos-picker-to-your-swiftui-app
                    //https://stackoverflow.com/questions/57110290/how-to-pick-image-from-gallery-in-swiftui
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Image(systemName: "camera.fill")
                                .padding(6)
                                .font(.system(size: 25))
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: 5, y: 5)
                    }
                        .onChange(of: selectedItem) {
                            guard let newItem = selectedItem else { return }

                            Task {
                                if let data = try? await newItem.loadTransferable(type: Data.self) {
                                    profileImageData = data
                                }
                            }
                    }
                }
                .frame(width: 150, height: 150)
            }
            .frame(maxWidth: .infinity)


            
            // Name Title and Field
            Text("Name")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
   
            TextField("Enter your name", text: $userData.name)
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
                

            // Phone number Title and Field
            Text("Phone Number")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.leading, 22)
            TextField("Enter your phone number", text: $userData.phoneNumber)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .frame(maxWidth: .infinity)

            //Password Title and Field
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
                    guard profileImageData != nil else {
                            saveMessage = "Please wait for the image to finish loading."
                            showAlert = true
                            return
                        }
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
                    userData.name = data?["name"] as? String ?? ""
                    userData.phoneNumber = data?["phoneNumber"] as? String ?? ""
                    userData.profileImageUrl = data?["profileImageUrl"] as? String
                    if let profileImageUrl = userData.profileImageUrl {
                        loadProfileImage(from: profileImageUrl)
                    }
                }
            }
        }
    }
    
    //Reference for following code: https://stackoverflow.com/questions/64652736/how-do-i-add-data-to-current-users-uid-in-firestore-swift-ios
    func saveUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
//        uploadProfileImage { imageUrl in
//            guard let imageUrl = imageUrl else {
//                print("Image URL is nil after upload.")
//                saveMessage = "Failed to upload image."
//                showAlert = true
//                return
//            }
            
            userData.profileImageUrl = imageUrl
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "name": userData.name,
                "phoneNumber": userData.phoneNumber,
                "profileImageUrl": userData.profileImageUrl ?? ""
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
    
    //References for following function:
    //https://firebase.google.com/docs/storage/ios/download-files
    //https://stackoverflow.com/questions/55201668/how-to-retrieve-image-from-firebase-storage-swift-4-ios
    func loadProfileImage(from urlString: String) {
        // Convert the string URL to a valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            return
        }

        // Create a reference to Firebase Storage
        let storageRef = Storage.storage().reference(forURL: url.absoluteString)
        
        // Download the data from Firebase Storage
        storageRef.getData(maxSize: Int64(10 * 1024 * 1024)) { data, error in
            if let error = error {
                print("Error loading image from Firebase Storage: \(error.localizedDescription)")
            } else {
                // Successfully loaded image data
                if let imageData = data {
                    profileImageData = imageData
                }
            }
        }
    }
    
 

    
}

#Preview {
    AccountView()
}
