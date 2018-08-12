//
//  Endpoints.swift
//  GirdView
//
//  Created by Deep Arora on 8/10/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation

class EndPoints {
    
    static let baseUrl = "https://api.redmart.com/v1.6.0"
    static let imageBaseUrl = "http://media.redmart.com/newmedia/200p"
    static let searchProducts = "\(baseUrl)/catalog/search?theme=all-sales&pageSize=30"
    static let productDetail = "\(baseUrl)/products"
}


