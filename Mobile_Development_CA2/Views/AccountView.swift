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
    @EnvironmentObject private var session     : SessionManager
    @EnvironmentObject private var settings     : AppSettings
    
    // Hardcoded values for email, password, and confirm password
    @State private var email: String = "user@example.com"
    @State private var password: String = "**********"
    @State private var showAlert = false
    @State private var saveMessage: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImageData: Data?
    @State private var userData = UserData()
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 15) {
                
                VStack {
                    Text("Edit Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    ZStack(alignment: .bottomTrailing) {
                        
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
                                    .background(Color(.systemBackground))
                                    .clipShape(Circle())
                                    .offset(x: 5, y: 5)
                                    .foregroundColor(Color(hex: "#242760"))
                            }
                            .onChange(of: selectedItem) {
                                guard let newItem = selectedItem else { return }
                                
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self),
                                       let uid = Auth.auth().currentUser?.uid {
                                        profileImageData = data
                                        saveImageLocally(data, uid: uid)
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
                    .foregroundColor(.primary)
                    .padding(.leading, 22)
                
                ZStack{
                    
                    TextField("Enter your name", text: $userData.name)
                        .font(Font.system(size: 20))
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 330)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                    
                }
                
                // E-mail Title and Field
                Text("E-mail")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 22)
                
                ZStack{
                    
                    TextField("Enter your e-mail", text: $email)
                        .font(Font.system(size: 20))
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 330)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                        .disabled(true)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "lock.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                    
                }
                
                // Phone number Title and Field
                Text("Phone Number")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 22)
                
                ZStack{
                    
                    TextField("Enter your phone number", text: $userData.phoneNumber)
                        .font(Font.system(size: 20))
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 330)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                }
                
                //Password Title and Field
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 22)
                
                ZStack{
                    
                    SecureField("", text: $password)
                        .font(Font.system(size: 20))
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 330)
                        .disabled(true)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "lock.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                    
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Save Changes
                        saveUserData()
                    }) {
                        Text("Save Changes")
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#4CAF50"))
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
            .padding(.bottom, 20)
            .onAppear {
                loadUserData()
                
                if let uid = Auth.auth().currentUser?.uid {
                    let url = getProfileImagePath(for: uid)
                    if FileManager.default.fileExists(atPath: url.path),
                       let data = try? Data(contentsOf: url) {
                        profileImageData = data
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Save Status"),
                    message: Text(saveMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .preferredColorScheme(settings.useDarkMode ? .dark : nil)
        
    }
    
    func loadUserData() {
        FirebaseUserHelper.loadUserData(
            email: { email = $0 },
            updateUserData: { userData = $0 }
        )
    }
    
    func saveUserData() {
        FirebaseUserHelper.saveUserData(
            userData: userData
        ) { success, message in
            saveMessage = message
            showAlert = true
        }
    }
}
    
    //References for following function (load image from Firebase Storage):
    //https://firebase.google.com/docs/storage/ios/download-files
    //https://stackoverflow.com/questions/55201668/how-to-retrieve-image-from-firebase-storage-swift-4-ios
//    func loadProfileImage(from urlString: String) {
//        // Convert the string URL to a valid URL
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL string")
//            return
//        }
//
//        // Create a reference to Firebase Storage
//        let storageRef = Storage.storage().reference(forURL: url.absoluteString)
//        
//        // Download the data from Firebase Storage
//        storageRef.getData(maxSize: Int64(10 * 1024 * 1024)) { data, error in
//            if let error = error {
//                print("Error loading image from Firebase Storage: \(error.localizedDescription)")
//            } else {
//                // Successfully loaded image data
//                if let imageData = data {
//                    profileImageData = imageData
//                }
//            }
//        }
//    }
    
//}

#Preview {
    AccountView()
        .environmentObject(SessionManager())
        .environmentObject(AppSettings())
}
