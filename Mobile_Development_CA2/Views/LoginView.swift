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
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Placeholder for Logo
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Username", text: $username)
                    .font(Font.system(size: 20))
                    .padding(9)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .frame(width: 330, height: 100)
                
                SecureField("Password", text: $password)
                    .font(Font.system(size: 20))
                    .padding(9)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .frame(width: 330)
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Forgot Password?")
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
                
                HStack {
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(Color.gray)
                    
                    Text("OR")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(Color.gray)
                }
                
                
                
                SignInWithAppleButton(
                    onRequest: { request in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    },
                    onCompletion: { result in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    }
                )
                .frame(width: 325,height: 50)
                .padding(.top, 20)
                .padding(.bottom)
                
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
                .padding(.top, 110)
                
            }
            .frame(alignment: .center)
            .padding()
            .padding(.top, 130)
            .padding(.bottom, 20)
        }
    }
        
}
    

#Preview {
    LoginView()
}



