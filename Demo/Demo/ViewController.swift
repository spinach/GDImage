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
    @IBOutlet weak var imageView2: UIImageView!
    
    let URL1 = "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg"
    let URL2 = "https://s3.amazonaws.com/dummy-images-guy/IGC1.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        let gdImage = GDImage()
        gdImage.setImage(ofImageView: imageView, withLink: URL1)
        
        if let url = URL(string: URL2) {
            self.imageView2.setImage(withUrl: url)
            self.imageView2.cancelImageDownload()
            print("canceled image download for second ImageView")
        }
    }
    
    @IBAction func buttonClicked(_ sender: AnyObject) {
        if let url = URL(string: URL2) {
            self.imageView2.setImage(withUrl: url)
        }
    }
}

