//
//  ViewController.swift
//  Demo
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import UIKit
import GDImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gdImage = GDImage()
        gdImage.setImage(ofImageView: self.imageView, withLink: "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg")
        
        if let url = URL(string: "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg") {
            self.imageView.setImage(withUrl: url)
            self.imageView.cancelImageDownload()
            self.imageView.setImage(withUrl: url)
        }
    }
}

