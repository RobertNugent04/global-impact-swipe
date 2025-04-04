//
//  ContentView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 10/03/2025.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

//Code from https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                .padding(.top, 35)
                
                TextField("E-mail", text: $email)
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
                .padding(.top, 10)
                
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
                .padding(.top, 50)
                .padding(.bottom, 150)
                
            }
            .frame(alignment: .center)
            .padding()
            .padding(.top, 130)
            .padding(.bottom, 20)
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }}
    }
        
}
    

#Preview {
    LoginView()
}



