//
//  Guy.swift
//  GDImage
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

class GDImage {
    
    private var downloadTask: URLSessionDataTask?
    
    init() {
        self.downloadTask = nil
    }
    
    func setImage(ofImageView imageView: UIImageView?, withUrl url: URL) {
        imageView?.contentMode = .scaleAspectFit
        
        self.downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                imageView?.image = image
            }
        }
        
        self.downloadTask?.resume()
    }
    
    func setImage(ofImageView imageView: UIImageView?, withLink link: String) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url)
    }
    
    func cancelImageDownload() {
        self.downloadTask?.cancel()
    }
}

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
