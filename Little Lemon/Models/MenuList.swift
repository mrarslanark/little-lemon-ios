//
//  MenuList.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/10/23.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
