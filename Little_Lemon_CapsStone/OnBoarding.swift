import SwiftUI

struct OnBoarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
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
                
                ZStack{
                    HStack( spacing: 10){
                        Spacer()
                        Image("littleLemonLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.leading)
                        Spacer()
                    }
                    HStack( spacing: 10){
                        Spacer()
                        Image("profile-image-placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }.padding(.horizontal)
                    .frame(height: 60)
                
                
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Little Lemon")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex:"F4CE14"))
                        
                        Text("Chicago")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        
                        Text("We serve delicious Mediterranean food made with the freshest ingredients.").foregroundColor(.white)
                    }
                    
                    Image("topDish")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "#495E57"))
                
                Form {
                    Group {
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
        if email.isEmpty || firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty {
            showFormInvalidMessage = true
            errorMessage = "All fields are required"
            return
        }
        
        // Save to UserDefaults
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        showFormInvalidMessage = false
        isLoggedIn = true
    }
}

#Preview {
    OnBoarding()
}
