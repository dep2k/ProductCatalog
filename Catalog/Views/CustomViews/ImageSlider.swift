//
//  ImageSlider.swift
//  PageControl
//
//  Created by Deep Arora on 8/13/18.
//  Copyright © 2018 Apple, Inc. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageSlider: UIView, UIScrollViewDelegate{
    
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var imageUrls: [String]?
    
    var numPages = 0
    var pages = [UIView?]()
    var transitioning = false
   
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadImages(_ urls:[String]){
        self.imageUrls = urls
        self.numPages = urls.count
        self.setupInitialPages()
    }
    
    func setupInitialPages(){
       
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.isScrollEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
       // self.scrollView.backgroundColor = UIColor.red
        self.addSubview(scrollView)
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        self.addSubview(pageControl)
        self.pageControl.center = CGPoint(x: self.frame.width/2, y: self.frame.height * 1.1)
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        pages = [UIView?](repeating: nil, count: numPages)
        pageControl.numberOfPages = numPages
        pageControl.currentPage = 0
   
    
        adjustScrollView()
        
        // Pages are created on demand, load the visible page and next page.
        loadPage(0)
        loadPage(1)
    
    }
    
   
    fileprivate func adjustScrollView() {
        scrollView.contentSize =
            CGSize(width: scrollView.frame.width * CGFloat(numPages),
                   height: scrollView.frame.height)
    }
    
    
    fileprivate func loadPage(_ page: Int) {
        if (page > self.imageUrls!.count - 1)  {return}
        guard page < numPages && page != -1 else { return }
        
        if pages[page] == nil {
                let imageStr = self.imageUrls![page]
                // Load the image from our bundle.
                let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height * 0.8))
                newImageView.contentMode = .scaleAspectFit
                newImageView.sd_setImage(with: URL(string: imageStr), placeholderImage: nil)
                
                /**
                 Setup the canvas view to hold the image.
                 Its frame will be the same as the scroll view's frame.
                 */
                var frame = scrollView.frame
                // Offset the frame's X origin to its correct page offset.
                frame.origin.x = frame.width * CGFloat(page)
                // Set frame's y origin value to take into account the top layout guide.
             //   frame.origin.y = -self.topLayoutGuide.length
              //  frame.size.height += self.topLayoutGuide.length
                let canvasView = UIView(frame: frame)
                scrollView.addSubview(canvasView)
                
                // Setup the imageView's constraints to snap to all sides of its superview (canvasView).
                newImageView.translatesAutoresizingMaskIntoConstraints = false
                canvasView.addSubview(newImageView)
                
                NSLayoutConstraint.activate([
                    (newImageView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor)),
                    (newImageView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor)),
                    (newImageView.topAnchor.constraint(equalTo: canvasView.topAnchor)),
                    (newImageView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor))
                    ])
                
                pages[page] = canvasView
            }
        
    }
    
    fileprivate func loadCurrentPages(page: Int) {
        // Load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling).
        
        // Don't load if we are at the beginning or end of the list of pages.
        guard (page > 0 && page + 1 < numPages) || transitioning else { return }
        
        // Remove all of the images and start over.
       // removeAnyImages()
        pages = [UIView?](repeating: nil, count: numPages)
        
        // Load the appropriate new pages for scrolling.
        loadPage(Int(page) - 1)
        loadPage(Int(page))
        loadPage(Int(page) + 1)
    }
    
    fileprivate func gotoPage(page: Int, animated: Bool) {
        loadCurrentPages(page: page)
        
        // Update the scroll view scroll position to the appropriate page.
        var bounds = scrollView.bounds
        bounds.origin.x = bounds.width * CGFloat(page)
        bounds.origin.y = 0
        scrollView.scrollRectToVisible(bounds, animated: animated)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Switch the indicator when more than 50% of the previous/next page is visible.
        let pageWidth = scrollView.frame.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        pageControl.currentPage = Int(page)
        
        loadCurrentPages(page: pageControl.currentPage)
    }
    
    // MARK: - PageController Click Action
    
    @IBAction func gotoPage(_ sender: UIPageControl) {
        // User tapped the page control at the bottom, so move to the newer page, with animation.
        gotoPage(page: sender.currentPage, animated: true)
    }
    
}
