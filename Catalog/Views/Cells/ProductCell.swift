//
//  ProductInfoCell.swift
//  GirdView
//
//  Created by Deep Arora on 8/9/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var  productImageView: UIImageView!
    @IBOutlet weak var  productNameLabel: UITextView!
    @IBOutlet weak var  productQuantityLabel: UILabel!
    @IBOutlet weak var  productPriceLabel: UILabel!
    
    
    public func setData(product: Product){
        
        if let images = product.images , let imageName = images[0].name {
            let imageStr = "\(EndPoints.imageBaseUrl)\(imageName)"
            self.productImageView.sd_imageTransition = .fade
            self.productImageView.sd_setImage(with: URL(string: imageStr), placeholderImage: nil)
        }
        
        if let name = product.name {
            self.productNameLabel.text = name
        }
        
        if let measure = product.measure, let quantity = measure.weightOrVol{
            self.productQuantityLabel.text = quantity
        }
        
        if let pricing = product.pricing, let price = pricing.price{
            self.productPriceLabel.text = "$ \(price)"
        }
    }
}
