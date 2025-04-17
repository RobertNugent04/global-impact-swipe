//
//  AccountView.swift
//  Mobile_Development_CA2
//
//  Created by Student on 17/04/2025.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct AccountView: View {
    // Hardcoded values for email, password, and confirm password
    @State private var name: String = "Patrick Kelvo"
    @State private var email: String = "user@example.com"
    @State private var phoneNumber: String = "+353851233456"
    @State private var password: String = "password123"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // E-mail Title and Field
            Text("Name")
                .font(.headline)
                .foregroundColor(.black)
            TextField("", text: $name)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .disabled(true)
            
            // E-mail Title and Field
            Text("E-mail")
                .font(.headline)
                .foregroundColor(.black)
            TextField("", text: $email)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .disabled(true)

            // Password Title and Field
            Text("Phone Number")
                .font(.headline)
                .foregroundColor(.black)
            TextField("", text: $phoneNumber)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .disabled(true)

            Text("Password")
                .font(.headline)
                .foregroundColor(.black)
            SecureField("", text: $password)
                .font(Font.system(size: 20))
                .padding(9)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .frame(width: 330)
                .disabled(true)
     
        }
        .padding()
        .padding(.top, 130)
        .padding(.bottom, 170)
    }
}

#Preview {
    AccountView()
}
