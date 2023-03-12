//
//  Profile.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/4/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    var firstName: String {
        UserDefaults.standard.string(forKey: "first name key") ?? ""
    }
    var lastName: String {
        UserDefaults.standard.string(forKey: "last name key") ?? ""
    }
    var email: String {
        UserDefaults.standard.string(forKey: "email address key") ?? ""
    }
    var phoneNumber: String {
        UserDefaults.standard.string(forKey: "phone number key") ?? ""
    }
    
    @State private var toggleOrderStatues: Bool = false
    @State private var togglePasswordChanges: Bool = false
    @State private var toggleSpecialOffers: Bool = false
    @State private var toggleNewsletter: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Personal Information")
                    .font(.custom("MarkaziText-Regular", size: 40))
                HStack(alignment: .top, spacing: 16) {
                    Button {
                        // TODO: Enable profile picture change
                        print("Update Profile Picture")
                    } label: {
                        VStack {
                            Image("ProfileImagePlaceholder")
                                .resizable()
                                .frame(maxWidth: 75, maxHeight: 75)
                                .cornerRadius(.infinity)
                            Text("Edit")
                                .font(.custom("Karla-Medium", size: 18))
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(firstName) \(lastName)".uppercased())
                            .font(.custom("Karla-ExtraBold", size: 20))
                        Text(email)
                            .font(.custom("Karla-Regular", size: 16))
                        Text(phoneNumber)
                            .font(.custom("Karla-Regular", size: 16))
                    }
                }
                VStack(alignment: .leading) {
                    Text("Email Notifications")
                        .font(.custom("Karla-Bold", size: 18))
                    VStack(alignment: .leading, spacing: 24) {
                        Toggle(isOn: $toggleOrderStatues) {
                            Text("Order Statuses")
                                .font(.custom("Karla-Regular", size: 18))
                        }.toggleStyle(CheckboxStyle())
                        Toggle(isOn: $togglePasswordChanges) {
                            Text("Password Changes")
                                .font(.custom("Karla-Regular", size: 18))
                        }.toggleStyle(CheckboxStyle())
                        Toggle(isOn: $toggleSpecialOffers) {
                            Text("Special Offers")
                                .font(.custom("Karla-Regular", size: 18))
                        }.toggleStyle(CheckboxStyle())
                        Toggle(isOn: $toggleNewsletter) {
                            Text("Newsletter")
                                .font(.custom("Karla-Regular", size: 18))
                        }.toggleStyle(CheckboxStyle())
                    }.padding([.top, .bottom], 16)
                }
                .padding([.top, .bottom], 18)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                Spacer()
                HStack {
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Logout")
                            .font(.custom("Karla-Medium", size: 18))
                            .padding([.top, .bottom], 16)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Primary Color 1"))
                            .cornerRadius(12)
                    })
                    NavigationLink(destination: EditProfile(), label: {
                        Text("Edit")
                            .font(.custom("Karla-Medium", size: 18))
                            .padding([.top, .bottom], 16)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("Secondary Color 4"))
                            .background(Color("Primary Color 2"))
                            .cornerRadius(12)
                    })
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding([.leading, .trailing], 25)
            .padding([.top, .bottom], 16)
        }
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(maxWidth: 20, maxHeight: 20)
                .foregroundColor(Color("Primary Color 1"))
            configuration.label
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
