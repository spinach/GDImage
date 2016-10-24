//
//  Guy.swift
//  GDImage
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public class GDImage {
    
    private var downloadTasks: [UIImageView:URLSessionDataTask]
    
    public init() {
        self.downloadTasks = [:]
    }
    
    public func setImage(ofImageView imageView: UIImageView?, withUrl url: URL) {
        imageView?.contentMode = .scaleAspectFit
        
        if let imageView = imageView {
            self.downloadTasks[imageView] = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { () -> Void in
                    imageView.image = image
                    self.downloadTasks[imageView] = nil
                }
            }
            
            self.downloadTasks[imageView]?.resume()
        }
    }
    
    public func setImage(ofImageView imageView: UIImageView?, withLink link: String) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url)
    }
    
    public func cancelDownload(ofImageView imageView: UIImageView) {
        self.downloadTasks[imageView]?.cancel()
    }
}
