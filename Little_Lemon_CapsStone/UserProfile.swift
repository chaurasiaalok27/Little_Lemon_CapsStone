import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    @State private var firstName = UserDefaults.standard.string(forKey: "firstName") ?? "First Name"
    @State private var lastName = UserDefaults.standard.string(forKey: "lastName") ?? "Last Name"
    @State private var email = UserDefaults.standard.string(forKey: "email") ?? "Email"
    @State private var phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? "(217) 555-0113"
    
    @State private var orderStatuses = UserDefaults.standard.bool(forKey: "orderStatuses")
    @State private var passwordChanges = UserDefaults.standard.bool(forKey: "passwordChanges")
    @State private var specialOffers = UserDefaults.standard.bool(forKey: "specialOffers")
    @State private var newsletter = UserDefaults.standard.bool(forKey: "newsletter")
    
    @State private var showDiscardAlert = false
    @State private var showSavedAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Personal information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Avatar")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    Button(action: {
                        // Handle avatar change
                    }) {
                        Text("Change")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 100)
                            .background(Color(hex: "#495E57"))
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    Button(action: {
                        // Handle avatar removal
                    }) {
                        Text("Remove")
                            .foregroundColor(Color(hex: "#495E57"))
                            .padding()
                            .frame(width: 100)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#495E57"), lineWidth: 1)
                            )
                            .padding()
                    }
                }
                
                // First name
                VStack(alignment: .leading, spacing: 4) {
                    Text("First name")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    TextField("", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                // Last name
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last name")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    TextField("", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Email
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    TextField("", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                }
                
                // Phone Number
                VStack(alignment: .leading, spacing: 4) {
                    Text("Phone number")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    TextField("", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                }
                
                // Email notifications section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email notifications")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Toggle("Order statuses", isOn: $orderStatuses)
                    Toggle("Password changes", isOn: $passwordChanges)
                    Toggle("Special offers", isOn: $specialOffers)
                    Toggle("Newsletter", isOn: $newsletter)
                }
                Spacer()
                
                Button(action: {
                    // Clear saved data
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    UserDefaults.standard.set("", forKey: "firstName")
                    UserDefaults.standard.set("", forKey: "lastName")
                    UserDefaults.standard.set("", forKey: "email")
                    UserDefaults.standard.set("", forKey: "phoneNumber")
                    UserDefaults.standard.set(false, forKey: "orderStatuses")
                    UserDefaults.standard.set(false, forKey: "passwordChanges")
                    UserDefaults.standard.set(false, forKey: "specialOffers")
                    UserDefaults.standard.set(false, forKey: "newsletter")
                    
                    // Dismiss to go back to onboarding
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .cornerRadius(12)
                }
                
                HStack {
                    Button(action: {
                        // Reset to UserDefaults values
                        firstName = UserDefaults.standard.string(forKey: "firstName") ?? "First Name"
                        lastName = UserDefaults.standard.string(forKey: "lastName") ?? "Last Name"
                        email = UserDefaults.standard.string(forKey: "email") ?? "Email"
                        phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? "(217) 555-0113"
                        orderStatuses = UserDefaults.standard.bool(forKey: "orderStatuses")
                        passwordChanges = UserDefaults.standard.bool(forKey: "passwordChanges")
                        specialOffers = UserDefaults.standard.bool(forKey: "specialOffers")
                        newsletter = UserDefaults.standard.bool(forKey: "newsletter")
                        showDiscardAlert.toggle()
                       
                    }) {
                        Text("Discard Changes")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 180)
                            .background(Color(hex: "#495E57"))
                            .cornerRadius(10)
                    }
                    .alert("Changes Discarded!",
                           isPresented: $showDiscardAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Save changes to UserDefaults
                        UserDefaults.standard.set(firstName, forKey: "firstName")
                        UserDefaults.standard.set(lastName, forKey: "lastName")
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                        UserDefaults.standard.set(orderStatuses, forKey: "orderStatuses")
                        UserDefaults.standard.set(passwordChanges, forKey: "passwordChanges")
                        UserDefaults.standard.set(specialOffers, forKey: "specialOffers")
                        UserDefaults.standard.set(newsletter, forKey: "newsletter")
                        showSavedAlert.toggle()
                    }) {
                        Text("Save Changes")
                            .foregroundColor(Color(hex: "#495E57"))
                            .padding()
                            .frame(width: 160)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#495E57"), lineWidth: 1)
                            )
                    }
                    
                    .alert("Changes Saved!",
                           isPresented: $showSavedAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
