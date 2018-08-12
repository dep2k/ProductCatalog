//
//  CatalogTests.swift
//  CatalogTests
//
//  Created by Deep Arora on 8/12/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import XCTest
@testable import Catalog
//@testable import CatalogListViewModel

class CatalogListTests: XCTestCase{
    
    var viewModel: CatalogListViewModel = CatalogListViewModel(httpClient: HttpClient(session: SessionManager().dataSession))
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testIfSearchURLEmptyGivesError() {
        
        viewModel.searchProducts(searchUrl: "",onCompletion:  { (error, result) in
            XCTAssertNotNil(error, "No Error return when search Url is empty")
        })
        
    }
    
    func testIfSuccessfulSearchIncreasesTheNextPageValue(){
        
        let previousPage = viewModel.pageNo
        let urlStr = "https://api.redmart.com/v1.6.0/catalog/search?theme=all-sales&pageSize=30&page=0"
        self.viewModel.searchProducts(searchUrl: urlStr) { (error, result) in
            let newPage = self.viewModel.pageNo
            XCTAssertEqual(previousPage + 1, newPage, "PageNo not updated after response received")
        }
    }
    
    
    func testThatLastPageSearchShouldNotIncreaseNextPageValue(){
        
        
    }
    
}
