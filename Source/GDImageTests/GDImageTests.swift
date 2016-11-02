//
//  GDImageTests.swift
//  GDImageTests
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import XCTest
@testable import GDImage

class GDImageTests: XCTestCase {
    
    let URLString1 = "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg"
    var bundle: Bundle!
    
    override func setUp() {
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadImageSucceeds() {
        let expectation = self.expectation(description: "wait for downloading image")
        let gdImage = GDImage(useStore: false)
        let expectedImage = UIImage(named: "algolia-logo.jpg", in: bundle, compatibleWith: nil)
        let imageView = UIImageView()
        gdImage.setImage(ofImageView: imageView, withLink: URLString1) { (actualImage, error) in
            expectation.fulfill()
            XCTAssert(self.image(image1: expectedImage!, isEqualTo: actualImage!))
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadImageFails() {
        let expectation = self.expectation(description: "wait for downloading image")
        let gdImage = GDImage(useStore: false)
        let imageView = UIImageView()
        gdImage.setImage(ofImageView: imageView, withLink: URLString1 + "random") { (imageResponse, error) in
            expectation.fulfill()
            XCTAssertNil(imageResponse)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCancelDownload() {
        let gdImage = GDImage(useStore: false)
        let imageView = UIImageView()
        gdImage.setImage(ofImageView: imageView, withLink: URLString1)
        gdImage.cancelDownload(ofImageView: imageView)
        XCTAssertNil(imageView.image)
    }
    
    func image(image1: UIImage, isEqualTo image2: UIImage) -> Bool {
        let data1: NSData = UIImagePNGRepresentation(image1)! as NSData
        let data2: NSData = UIImagePNGRepresentation(image2)! as NSData
        return data1.isEqual(data2)
    }
}
