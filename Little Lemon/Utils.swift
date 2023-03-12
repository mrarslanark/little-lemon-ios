//
//  Utils.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/4/23.
//

import Foundation

func isEmailValid(email: String) -> Bool {
    
    let regex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let expression = try NSRegularExpression(pattern: regex)
        let parse = email as NSString
        let results = expression.matches(in: email, range: NSRange(location: 0, length: parse.length))
        
        if results.count == 0 {
            return false;
        }
    } catch let error as NSError {
        print("Invalid regex: \(error.localizedDescription)")
        return false;
    }
    
    return true;
}
