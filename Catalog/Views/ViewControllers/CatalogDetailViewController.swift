//
//  CatalogDetailViewController.swift
//  Catalog
//
//  Created by Deep Arora on 8/12/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//
import UIKit
import SDWebImage

class CatalogDetailViewController: UIViewController {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UITextView!
    @IBOutlet weak var imageSlider: ImageSlider!
    
    public var productInfo: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }
    
    func setData(){
        
        if let productInfo = productInfo{
            
            if let images = productInfo.images , let imageName = images[0].name {
                let imageStr = "\(EndPoints.imageBaseUrl)\(imageName)"
                self.productImage.sd_imageTransition = .fade
                self.productImage.sd_setImage(with: URL(string: imageStr), placeholderImage: nil)
            }
            
            if let name = productInfo.name{
                self.productName.numberOfLines = 0
                self.productName.sizeToFit()
                self.productName.text = name
            }
            
            if let pricing = productInfo.pricing, let price = pricing.price{
                self.productPrice.text = "$ \(price)"
            }
            
            if let desc = productInfo.description{
                self.productDesc.text = desc
            }
            
            if let measure = productInfo.measure, let quantity = measure.weightOrVol{
                self.productQuantity.text = quantity
            }
            
            if let images = productInfo.images {
                let urlList = images.map { (image) -> String in
                        return image.name!.getImageFullUrlStr()
                }
                
                self.imageSlider.loadImages(urlList)
            }
          
        }
    }
    
    @IBAction func shareBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func saveToListClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func addToCartClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    
}
