//
//  UserManagement.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/12/23.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case kFirstName = "first name key"
        case kLastName = "last name key"
        case kEmailAddress = "email address key"
        case kPhoneNumber = "phone number key"
        case kIsLoggedIn = "kIsLoggedIn"
    }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
}
