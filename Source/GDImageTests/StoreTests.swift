//
//  GDImageTests.swift
//  StoreTests
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import XCTest
@testable import GDImage

class StoreTests: XCTestCase {
    
    var store: Store!
    var bundle: Bundle!
    let URLString1 = "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg"
    let URLString2 = "https://s3.amazonaws.com/dummy-images-guy/another-logo.jpg"
    
    
    override func setUp() {
        super.setUp()
        
        store = Store()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testCacheMiss() {
        let randomImageToPut = UIImage(named: "Windows-10.jpg", in: bundle, compatibleWith: nil)
        store.putInCache(image: randomImageToPut!, forKey: URL(string: URLString2)!)
        
        let image = store.getFromCache(withUrlPath: URL(string: URLString1)!)
        XCTAssertNil(image, "cache miss should lead to the image being nil")
    }
    
    func testCacheHit() {
        let imageToPut = UIImage(named: "Windows-10.jpg", in: bundle, compatibleWith: nil)
        let anotherImage = UIImage(named: "algolia-logo.jpg", in: bundle, compatibleWith: nil)
        store.putInCache(image: imageToPut!, forKey: URL(string: URLString1)!)
        let imageFromCache = store.getFromCache(withUrlPath: URL(string: URLString1)!)
        XCTAssertNotNil(imageFromCache, "cache hit should lead to the image not being nil")
        XCTAssertEqual(imageToPut, imageFromCache, "inserted image should be the same as cache result")
        XCTAssertNotEqual(anotherImage, imageFromCache, "2 different images should not be equal")
    }
}
