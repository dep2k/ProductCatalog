//
//  ViewController.swift
//  Catalog
//
//  Created by Deep Arora on 8/12/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import UIKit
import SDWebImage



class CatalogListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var products:[Product] = [Product]()
    let catalogListVM: CatalogListViewModel = CatalogListViewModel(httpClient: HttpClient(session: SessionManager.instance.dataSession))
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Products"
        self.collectionView.setEstimatedSizeOfCell()
        self.searchProducts()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
  
    func searchProducts(){
        
        self.view.showLoader()
        self.catalogListVM.searchProducts(searchUrl: EndPoints.searchProducts, onCompletion:  { (error, products) in
            self.view.hideLoader()
            guard let products = products, error == nil else {
                //Display error alert
                return;
            }
            self.products += products
            self.collectionView.reloadData()
        })
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.products.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if (indexPath.row == self.products.count - 3 * 5 ){
            self.searchProducts()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = self.products[indexPath.row]
        cell.setData(product: product)
        return cell
    }
    
    // MARK: Delegates
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let selectedProduct = self.products[indexPath.row]
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! CatalogDetailViewController
        detailVC.productInfo = selectedProduct
        self.navigationController?.present(detailVC, animated: true, completion: {})
    }
    
}


extension UICollectionView {
    
    func setEstimatedSizeOfCell(){
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout{
            var numCols:CGFloat = 3
            var availableWidth  = self.frame.size.width - 30
            if UIDevice.current.userInterfaceIdiom == .pad {
                numCols = 4
                availableWidth  = self.frame.size.width - 30
            }
            let cellWidth =  Int(floor (availableWidth / numCols))
            let cellHeight = 290
            flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
