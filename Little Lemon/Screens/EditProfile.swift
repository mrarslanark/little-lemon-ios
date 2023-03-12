//
//  EditProfile.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/13/23.
//

import SwiftUI

struct EditProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var firstName: String = UserDefaults.standard.string(forKey: "first name key") ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: "last name key") ?? ""
    @State var emailAddress: String = UserDefaults.standard.string(forKey: "email address key") ?? ""
    @State var phoneNumber: String = UserDefaults.standard.string(forKey: "phone number key") ?? ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Edit Profile")
                    .font(.custom("MarkaziText-Regular", size: 40))
                
                HStack {
                    Button {
                        // TODO: Enable profile picture change
                        print("Update Profile Picture")
                    } label: {
                        Image("ProfileImagePlaceholder")
                            .resizable()
                            .frame(maxWidth: 75, maxHeight: 75)
                            .cornerRadius(.infinity)
                    }
                    Spacer()
                    Button {
                        // TODO: Enable profile picture update
                    } label: {
                        Text("Update")
                            .font(.custom("Karla-Medium", size: 18))
                    }
                    Spacer()
                    Button {
                        // TODO: Enable profile picture update
                    } label: {
                        Text("Remove")
                            .font(.custom("Karla-Medium", size: 18))
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }
                
                VStack(spacing: 24) {
                    
                    HStack(spacing: 18) {
                        // First Name Input
                        VStack(alignment: .leading, spacing: 0) {
                            Text("First Name")
                                .font(.custom("Karla-Medium", size: 16))
                                .foregroundColor(Color(.gray))
                            TextField("Enter First Name", text: $firstName)
                                .autocorrectionDisabled(true)
                                .keyboardType(.default)
                                .font(.custom("Karla-Regular", size: 16))
                                .padding(16)
                                .background(Color("Secondary Color 3"))
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("Primary Color 1"))
                        }
                        
                        // Last Name Input
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Last Name")
                                .font(.custom("Karla-Medium", size: 16))
                                .foregroundColor(Color(.gray))
                            TextField("Enter Last name", text: $lastName)
                                .autocorrectionDisabled(true)
                                .keyboardType(.default)
                                .font(.custom("Karla-Regular", size: 16))
                                .padding(16)
                                .background(Color("Secondary Color 3"))
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("Primary Color 1"))
                        }
                    }
                    
                    // Email Address Input
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Email Address")
                            .font(.custom("Karla-Medium", size: 16))
                            .foregroundColor(Color(.gray))
                        TextField("Enter Email Address", text: $emailAddress)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .font(.custom("Karla-Regular", size: 16))
                            .padding(16)
                            .background(Color("Secondary Color 3"))
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("Primary Color 1"))
                    }
                    
                    // Phone Number Input
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Phone Number (Optional)")
                            .font(.custom("Karla-Medium", size: 16))
                            .foregroundColor(Color(.gray))
                        TextField("Enter Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .font(.custom("Karla-Regular", size: 16))
                            .padding(16)
                            .background(Color("Secondary Color 3"))
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("Primary Color 1"))
                    }
                }
                
                Spacer()
                
                Button(action: updateProfile, label: {
                    Text("Update")
                        .font(.custom("Karla-Medium", size: 18))
                        .padding([.top, .bottom], 16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(Color("Primary Color 2"))
                        .cornerRadius(12)
                }).disabled(firstName.isEmpty || lastName.isEmpty || emailAddress.isEmpty)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing], 25)
            .padding([.top, .bottom], 16)
        }
        
    }
    
    func updateProfile() {
        
        let currentFirstName = UserDefaults.standard.string(forKey: "first name key")
        let currentLastName = UserDefaults.standard.string(forKey: "last name key")
        let currentEmailAddress = UserDefaults.standard.string(forKey: "email address key")
        let currentPhoneNumber = UserDefaults.standard.string(forKey: "phone number key")
        
        if firstName != currentFirstName {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
        }
        
        if lastName != currentLastName {
            UserDefaults.standard.set(lastName, forKey: kLastName)
        }
        
        if emailAddress != currentEmailAddress {
            UserDefaults.standard.set(emailAddress, forKey: kEmailAddress)
        }
        
        if phoneNumber != currentPhoneNumber {
            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
        }
        
        presentation.wrappedValue.dismiss()
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
