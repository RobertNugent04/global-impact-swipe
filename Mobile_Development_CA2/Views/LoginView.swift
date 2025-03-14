//
//  ContentView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 10/03/2025.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            
            //Placeholder for Logo
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Spacer()
                Button(action: {
                
                }) {
                    Text("Forgot Password?")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 325, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)

            Divider()
            
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
            .frame(width: 325,height: 50)
            .padding(.top, 30)
        }
        .frame(alignment: .center)
        .padding()
    }
    
}

#Preview {
    LoginView()
}



