//
//  Product.swift
//  GirdView
//
//  Created by Deep Arora on 8/9/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation

struct Catalog: Codable{
    
    let products: [Product]?
    let title: String?
    let total: Int?
    let onSaleCount: Int?
    
    
    enum CodingKeys: String, CodingKey{
        
        case products
        case title
        case total
        case onSaleCount = "on_sale_count"
    }
}

struct Product: Codable {
    
    let id: Int
    let name: String?
    let description: String?
    let pricing: Pricing?
    let measure: Measure?
    let images: [Images]?
    
    enum CodingKeys : String, CodingKey{
        
        case id
        case name = "title"
        case description = "desc"
        case pricing
        case measure = "measure"
        case images = "images"
    }
}

struct Pricing: Codable {
    
    let price: Float?
    let promoPrice: Float?
    let savingsPercent: Float?
    let savingAmount: Float?
    let savingText: String?
    
    
    enum CodingKeys : String, CodingKey{
        
        case price
        case promoPrice = "promo_price"
        case savingsPercent = "savings"
        case savingAmount = "savings_amount"
        case savingText = "savings_text"
    }
}

struct Measure: Codable{
    
    let weightOrVol: String?
    let size: Int?
    
    enum CodingKeys : String, CodingKey{
        case weightOrVol = "wt_or_vol"
        case size = "size"

    }
}

struct Images: Codable{
    
    let width: Int?
    let height: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey{
        
        case width = "w"
        case height = "h"
        case name = "name"
    }
  
}


