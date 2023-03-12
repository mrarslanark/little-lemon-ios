//
//  ContentView.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/1/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmailAddress = "email address key"
let kPhoneNumber = "phone number key"
let kIsLoggedIn = "kIsLoggedIn"

struct Registration: View {
    
    @State var firstName: String =  ""
    @State var lastName: String = ""
    @State var emailAddress: String = ""
    @State var phoneNumber: String = ""
    
    @State var areFieldsValidated: Bool = false;
    @State var navigateToHome: Bool = false;
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationBar()
                    
                    VStack(alignment: .leading) {
                        Text("Little Lemon")
                            .font(.custom("MarkaziText-Medium", size: 48))
                            .foregroundColor(Color("Primary Color 2"))
                        Text("Chicago")
                            .font(.custom("MarkaziText-Regular", size: 30))
                    }
                    .padding(EdgeInsets(top: 12, leading: 25, bottom: 12, trailing: 25))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .foregroundColor(Color.white)
                    .background(Color("Primary Color 1"))
                    
                    Text("Registeration".uppercased())
                        .font(.custom("Karla-ExtraBold", size: 20))
                        .padding(EdgeInsets(top: 16, leading: 25, bottom: 16, trailing: 25))
                    
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
                    .padding([.leading, .trailing], 25)
                    
                    Spacer()
                    
                    Button(action: submitForm, label: {
                        Text("Register")
                            .font(.custom("Karla-Medium", size: 18))
                            .padding([.top, .bottom], 16)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("Secondary Color 4"))
                            .background(Color("Primary Color 2"))
                            .cornerRadius(12)
                    })
                    .navigationDestination(isPresented: $navigateToHome, destination: {
                        Home()
                    })
                    .alert(isPresented: $areFieldsValidated) {
                        Alert(
                            title: Text("Incomplete/Incorrect Fields"),
                            message: Text("Kindly complete all fields or check the email address to proceed"),
                            dismissButton: .default(
                                Text("Ok")
                            )
                        )
                    }.padding(EdgeInsets(top: 12, leading: 25, bottom: 0, trailing: 25))
                    
                }
                .fullScreenCover(isPresented: $shouldShowOnboarding) {
                    OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .onAppear {
                let isUserLoggedIn = UserDefaults.standard.bool(forKey: "kIsLoggedIn")
                if isUserLoggedIn {
                    navigateToHome = true
                }
            }
        }
    }
    
    func submitForm() {
        if firstName.isEmpty || lastName.isEmpty || emailAddress.isEmpty {
            areFieldsValidated = true
            return;
        }
        
        if !isEmailValid(email: emailAddress) {
            areFieldsValidated = true
            return;
        }
        areFieldsValidated = false;
        
        // Set User Defaults
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(emailAddress, forKey: kEmailAddress)
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
        
        if !phoneNumber.isEmpty {
            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
        } else {
            UserDefaults.standard.set("", forKey: kPhoneNumber)
        }
        
        navigateToHome = true;
    }
    
}

struct OnboardingView: View {
    
    @Binding var shouldShowOnboarding: Bool
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            OnboardingPageView(
                title: "Reservation Management",
                subtitle: "A convenient and easy-to-use tool that allows customers to make reservations for a table at the restaurant through their website or mobile app. This feature streamlines the reservation process and eliminates the need for customers to call the restaurant to make a reservation.",
                imageName: "ReservationManagement",
                showsDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding,
                tabIndex: $currentTab
            )
            .tag(0)
            
            OnboardingPageView(
                title: "Online Ordering",
                subtitle: "The online ordering feature allows customers to conveniently place orders for pickup or delivery through the restaurant's website or mobile app. Customers can browse the menu, select items, and customize their orders according to their preferences.",
                imageName: "OnlineOrdering",
                showsDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding,
                tabIndex: $currentTab
            )
            .tag(1)
            
            OnboardingPageView(
                title: "Menu and Pricing",
                subtitle: "Little Lemon Chicago's menu and pricing feature is available on its website and mobile app. The menu includes a variety of options, including salads, sandwiches, bowls, and sides, with detailed descriptions of each item and pricing.",
                imageName: "MenuAndPricing",
                showsDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding,
                tabIndex: $currentTab
            )
            .tag(2)
            
            OnboardingPageView(
                title: "Lemon Rewards",
                subtitle: "Customers can earn points for each purchase made through the website or mobile app, which can be redeemed for discounts or free items. The program also offers exclusive promotions and offers to its members, including early access to new menu items and special events.",
                imageName: "LemonRewards",
                showsDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding,
                tabIndex: $currentTab
            )
            .tag(3)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
    
}

struct OnboardingPageView: View {
    
    let title: String
    let subtitle: String
    let imageName: String
    let showsDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack(alignment: .center) {
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: 250)
            
            Divider().frame(width: 250)
            
            VStack(spacing: 0) {
                Text(title)
                    .font(.custom("MarkaziText-Regular", size: 32))
                Text(subtitle)
                    .font(.custom("Karla-Regular", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.secondaryLabel))
                    .padding()
            }
            .padding([.leading, .trailing], 25)
                        
            Spacer()
            if showsDismissButton {
                Button {
                    shouldShowOnboarding = false
                } label: {
                    Text("Get Started")
                        .font(.custom("Karla-Medium", size: 18))
                        .padding([.top, .bottom], 16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("Secondary Color 4"))
                        .background(Color("Primary Color 2"))
                        .cornerRadius(12)

                }.padding(EdgeInsets(top: 12, leading: 25, bottom: 0, trailing: 25))
            } else {
                HStack {
                    Circle()
                        .fill(tabIndex == 0 ? Color("Primary Color 1") : Color(.systemGray5))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(tabIndex == 1 ? Color("Primary Color 1") : Color(.systemGray5))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(tabIndex == 2 ? Color("Primary Color 1") : Color(.systemGray5))
                        .frame(width: 10, height: 10)
                    Circle()
                        .fill(tabIndex == 3 ? Color("Primary Color 1") : Color(.systemGray5))
                        .frame(width: 10, height: 10)
                }
            }
        }
        .padding([.top, .bottom], 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
