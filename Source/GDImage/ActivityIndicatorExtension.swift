//
//  ActivityIndicatorExtension.swift
//  GDImage
//
//  Created by Guy Daher on 10/30/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

extension UIActivityIndicatorView {
    public func startAnimating(inImageView imageView: UIImageView) {
        self.frame = imageView.frame
        self.center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
        imageView.addSubview(self)
        self.startAnimating()
    }
}
