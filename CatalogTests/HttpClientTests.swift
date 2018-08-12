//
//  HttpClientTests.swift
//  GirdViewTests
//
//  Created by Deep Arora on 8/12/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import XCTest
@testable import Catalog

class HttpClientTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    func testJSONMapping() throws {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Catalog", withExtension: "json") else {
            XCTFail("Missing file: Catalog.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let catalog: Catalog? = try? JSONDecoder().decode(Catalog.self, from: json)
        
        XCTAssertNotNil(catalog, "Catalog is nil")
        XCTAssertNotNil(catalog?.products, "No Products in the catalog")
        XCTAssertNotNil(catalog?.title, "Title is nil")
        XCTAssertNotNil(catalog?.total, "Total value nil")
        XCTAssertNotNil(catalog?.onSaleCount, "OnSaleCount value nil")
        
        XCTAssertEqual(catalog?.products?.count, 30, "Product count not correct")
        XCTAssertEqual(catalog?.title!, "All Sales", "Incorrect title")
        XCTAssertEqual(catalog?.total!, 36695, "Incorrect total count")
        XCTAssertEqual(catalog?.onSaleCount!, 36701, "Incorrect sale Count")
        
        //XCTAssertEqual(user.age, 29)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    
}
