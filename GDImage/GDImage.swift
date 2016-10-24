//
//  Guy.swift
//  GDImage
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public class GDImage {
    
    private var downloadTask: URLSessionDataTask?
    
    public init() {
        self.downloadTask = nil
    }
    
    public func setImage(ofImageView imageView: UIImageView?, withUrl url: URL) {
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
    
    public func setImage(ofImageView imageView: UIImageView?, withLink link: String) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url)
    }
    
    public func cancelImageDownload() {
        self.downloadTask?.cancel()
    }
}
