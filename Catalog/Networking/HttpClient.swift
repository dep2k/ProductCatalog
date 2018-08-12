//
//  API.swift
//  GirdView
//
//  Created by Deep Arora on 8/9/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation

class HttpClient {
    
    private var urlSession: URLSession
    
    init(session: URLSession){
        self.urlSession = session
    }
    
    public func getProducts(urlStr: String, completion:  @escaping (Error?,
        Catalog?) -> ()) {
        
        let url = URL(string: urlStr)
        if let url = url {
            let request = URLRequest(url: url)
            let dataTask = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(error,nil)
                    return
                }
                
                let catalog: Catalog? = try? JSONDecoder().decode(Catalog.self, from: data)
                completion(nil, catalog )
            }
            dataTask.resume()
        } else{
            fatalError()
        }
     
    }
    
    
    
}



