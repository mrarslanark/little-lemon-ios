//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/10/23.
//
import Foundation

struct MenuItem: Decodable {
    var id = UUID()
    let title: String
    let image: String
    let price: String
    let summary: String
    let category: MenuCategories.RawValue
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
        case image = "image"
        case summary = "description"
        case category = "category"
    }
}
