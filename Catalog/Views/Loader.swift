//
//  ViewExtensions.swift
//  GirdView
//
//  Created by Deep Arora on 8/10/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import Foundation
import UIKit

fileprivate let loaderViewTag = 1111
fileprivate let loaderIndicatorTag = 1112

extension UIView {
    
    func showLoader(){
        
        if let loaderView = self.viewWithTag(loaderViewTag) {
            loaderView.isHidden = false
            let av = loaderView.viewWithTag(loaderIndicatorTag) as! UIActivityIndicatorView
            av.startAnimating()
            return;
        }
        
        let loaderView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        loaderView.backgroundColor = UIColor.black
        loaderView.alpha = 0.8
        loaderView.tag = loaderViewTag
        loaderView.layer.cornerRadius = 15
        self.addSubview(loaderView)
        loaderView.center = CGPoint(x: self.center.x, y: self.center.y * 0.75)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: loaderView.frame.size.height/2, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        loadingIndicator.startAnimating();
        loadingIndicator.tag = loaderIndicatorTag
        loadingIndicator.center = CGPoint(x: 25, y: loaderView.frame.size.height/2)
        loaderView.addSubview(loadingIndicator)
        
        let loadingText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        loadingText.text = "Loading..."
        loadingText.textColor = UIColor.lightGray
        loadingText.center = CGPoint(x: loaderView.frame.size.width/2 + 20, y: loaderView.frame.size.height/2)
        loaderView.addSubview(loadingText)
        
      
    }
    
    func hideLoader(){
        
        if let loaderView = self.viewWithTag(loaderViewTag) {
            let av = loaderView.viewWithTag(loaderIndicatorTag) as! UIActivityIndicatorView
            av.stopAnimating()
            loaderView.isHidden = true
        }
        
    }
    
    
}
