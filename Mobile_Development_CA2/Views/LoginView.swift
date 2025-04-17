//
//  ContentView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 10/03/2025.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userIsLoggedIn = false
    @State private var isPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    var body: some View {
        if userIsLoggedIn{
            //Go to home page
        }
        else{
            content
        }
    }
    
    var content: some View{
        NavigationView {
            VStack {
                
                VStack {
                    Image("sdg_logo")
                        .resizable()
                        .frame(width: 175, height: 175)
                        .scaledToFit()
                    
                    Text("Global Impact Swipe")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "#333333"))
                }
                .padding(.top, 35)
                
                VStack(alignment: .leading, spacing: -15) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(.leading, 6)
                    
                    TextField("Enter your email", text: $email)
                        .font(Font.system(size: 17))
                        .padding(14)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .frame(width: 330, height: 100)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
                .frame(width: 330)
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding(.leading, 6)
                    
                    HStack{
                        Group{
                            if isPasswordVisible {
                                TextField("Enter password", text: $password)
                            }else{
                                SecureField("Enter password", text: $password)
                            }
                        }.font(Font.system(size: 17))
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
                .frame(width: 330)
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 325, height: 50)
                        .background(Color(hex: "#4CAF50"))
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .padding(.bottom,10)
                
                HStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    Text("OR")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)

                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                SignInWithAppleButton(
                    onRequest: { request in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    },
                    onCompletion: { result in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    }
                )
                .signInWithAppleButtonStyle(.white)
                .frame(width: 325, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                VStack{
                    Spacer()
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray)
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Don't have an Account?")
                            .foregroundColor(.gray)
                        
                            NavigationLink(destination: RegisterView()) {
                                Text("Sign Up")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 150)
                
            }
            .frame(alignment: .center)
            .padding()
            .padding(.top, 130)
            .padding(.bottom, 20)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(isSuccess ? "Success" : "Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
//            .onAppear{
//                Auth.auth().addStateDidChangeListener { auth, user in
//                    if user != nil {
//                        userIsLoggedIn.toggle()
//                    }}
//            }
        }
    }
    
    func login() {
        guard Validators.isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            isSuccess = false
            showAlert = true
            return
        }

        guard Validators.isValidPassword(password) else {
            alertMessage = "Password must be at least 6 characters."
            isSuccess = false
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = error.localizedDescription
                isSuccess = false
            } else {
                alertMessage = "Login successful!"
                isSuccess = true
                // userIsLoggedIn = true
            }
            showAlert = true
        }
    }
        
}
    

#Preview {
    LoginView()
}



