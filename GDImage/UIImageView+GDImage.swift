//
//  UIImageView+GDImage.swift
//  GDImage
//
//  Created by Guy Daher on 10/23/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

private var gdImageAssociationKey: UInt8 = 0

extension UIImageView {
    
    var gdImage: GDImage? {
        get {
            return objc_getAssociatedObject(self, &gdImageAssociationKey) as? GDImage
        }
        set(newValue) {
            objc_setAssociatedObject(self, &gdImageAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func setImage(withUrl url: URL) {
        if (gdImage == nil) { gdImage = GDImage()}
        gdImage?.setImage(ofImageView: self, withUrl: url)
    }
    
    public func setImage(withLink link: String) {
        if (gdImage == nil) { gdImage = GDImage()}
        gdImage?.setImage(ofImageView: self, withLink: link)
    }
    
    public func cancelImageDownload() {
        gdImage?.cancelImageDownload()
    }
}
