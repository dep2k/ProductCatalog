//
//  SessionManager.swift
//  GirdView
//
//  Created by Deep Arora on 8/10/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation

class SessionManager: NSObject, URLSessionDelegate {
    
  
    lazy var dataSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
    }()
   
    //MARK: URLSessinDelegates
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        //log message
    }
}
