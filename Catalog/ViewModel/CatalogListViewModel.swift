//
//  GridViewVM.swift
//  GirdView
//
//  Created by Deep Arora on 8/10/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation


class CatalogListViewModel: NSObject {
    
    var isSearching = false
    var pageNo: Int = 0
    var apiClient: HttpClient
    
    init(httpClient: HttpClient){
        self.apiClient = httpClient
    }
    
    //Dependency: Session, HTTPClient, searchUrl
    public func searchProducts(searchUrl: String, onCompletion:  @escaping (Error?,
        [Product]?) -> ()) {
        
        guard self.isSearching == false else{
            onCompletion(nil,nil) 
            return
        }
        
        guard searchUrl == searchUrl else{
            let error = NSError(domain: "", code: -1, userInfo: nil)
            onCompletion(error, nil)
            return
        }
        
        self.isSearching = true
        let fullUrl = "\(searchUrl)&page=\(pageNo)"
        
        self.apiClient.getProducts(urlStr: fullUrl) {[weak self] (error, searchResult) in
            self?.isSearching = false
            guard let searchResult = searchResult, error == nil else{
                onCompletion(error,nil)
                return
            }
            // Success
            self?.pageNo += 1
            let products = searchResult.products
            onCompletion(nil,products)
         
        }
         
    }
    
}
