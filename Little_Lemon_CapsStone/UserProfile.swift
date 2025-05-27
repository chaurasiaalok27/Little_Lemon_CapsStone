//
//  UserProfile.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 25/05/25.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: "firstName") ?? "First Name"
    let lastName = UserDefaults.standard.string(forKey: "lastName") ?? "Last Name"
    let email = UserDefaults.standard.string(forKey: "email") ?? "Email"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Personal information") .font(.largeTitle)
                .fontWeight(.bold)
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")
            Spacer()
            
            Button(action: {
                // Clear saved data
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.set("", forKey: "firstName")
                UserDefaults.standard.set("", forKey: "lastName")
                UserDefaults.standard.set("", forKey: "email")
                
                // Dismiss to go back to onboarding
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Logout")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            
        }
        .padding()
        
        
    }
}

#Preview {
    UserProfile()
}
