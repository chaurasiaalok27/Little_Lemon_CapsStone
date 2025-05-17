import SwiftUI

struct OnBoarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    @State var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")

    
    var body: some View {
        NavigationView {
            VStack {
                // Fix: NavigationLink wrapped with hidden view
                NavigationLink(destination: Home().navigationBarBackButtonHidden(true),
                               isActive: $isLoggedIn) {
                    Text("") // must be a view
                }
                               .hidden() // make it invisible but layout-safe
                
                Form {
                    Group {
                        HStack {
                            Text("First Name:")
                                .font(.subheadline)
                            TextField("Your name...", text: $firstName)
                        }
                        HStack {
                            Text("Last Name:")
                                .font(.subheadline)
                            TextField("Your name...", text: $lastName)
                        }
                        HStack {
                            Text("Email:")
                                .font(.subheadline)
                            TextField("Your email...", text: $email)
                                .keyboardType(.emailAddress)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            validateForm()
                        }) {
                            Text("Submit")
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
                
                .alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                    Button("OK", role: .cancel) { }
                }, message: {
                    Text(self.errorMessage)
                })
            }
           
        } .onAppear {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                isLoggedIn = true
            }
            
        }
        
    }
    
    private func validateForm() {
        if email.isEmpty || firstName.isEmpty || lastName.isEmpty {
            showFormInvalidMessage = true
            errorMessage = "All fields are required"
            return
        }
        
        // Save to UserDefaults
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        showFormInvalidMessage = false
        isLoggedIn = true
    }
}

#Preview {
    OnBoarding()
}
