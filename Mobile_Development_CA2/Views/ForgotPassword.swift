//
//  ForgotPassword.swift
//  Mobile_Development_CA2
//
//  Created by Student on 24/03/2025.
//

import SwiftUI
import AuthenticationServices

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    Image("logo-no-background")
                        .resizable()
                        .frame(width: 325, height: 175)
                        .scaledToFit()
                    
                    Text("Global Impact Swipe")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#333333"))
                }
                .padding(.bottom, 35)
                
                Text("Please enter your e-mail address")
                    .font(Font.system(size: 20))
                    .padding(.top, 30)
                
                TextField("E-Mail", text: $email)
                    .font(Font.system(size: 20))
                    .padding(9)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .frame(width: 330, height: 100)
                
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 325, height: 50)
                        .background(Color(hex: "#4CAF50"))
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Password Reset"),
                                          message: Text("A password reset email has been sent. Please check your inbox."),
                                          dismissButton: .default(Text("OK")))
                                }


            }
            .frame(alignment: .center)
            .padding()
            .padding(.bottom, 240)
        }
    }
        
}
    

#Preview {
    ForgotPasswordView()
}
