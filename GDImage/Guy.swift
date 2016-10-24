//
//  Guy.swift
//  GDImage
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public class GDImage {
    
    public init() {}
    
    public func setImage(ofImageView imageView: UIImageView?, withUrl url: URL) {
        imageView?.contentMode = .scaleAspectFit
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                imageView?.image = image
            }
        }.resume()
    }
    
    public func setImage(ofImageView imageView: UIImageView?, withLink link: String) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url)
    }
}

extension UIImageView {
    
    public func setImage(withUrl url: URL) {
        let gdImage = GDImage()
        gdImage.setImage(ofImageView: self, withUrl: url)
    }
    
    public func setImage(withLink link: String) {
        let gdImage = GDImage()
        gdImage.setImage(ofImageView: self, withLink: link)
    }
    
    public func cancelImageDownload() {
        
    }
}
