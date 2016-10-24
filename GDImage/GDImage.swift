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
    private var store: Store
    
    public init() {
        self.downloadTasks = [:]
        self.store = Store()
    }
    
    public func setImage(ofImageView imageView: UIImageView, withUrl url: URL) {
        imageView.contentMode = .scaleAspectFit
        
        if let image = store.get(withUrlPath: url) {
            imageView.image = image
            return
        }
        
        self.downloadTasks[imageView] = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            self.store.save(image: image, toUrlPath:url)
            
            DispatchQueue.main.async() { () -> Void in
                imageView.image = image
                // since done with task, remove from list of tasks
                self.downloadTasks[imageView] = nil
                
            }
        }
        
        self.downloadTasks[imageView]?.resume()
        
    }
    
    public func setImage(ofImageView imageView: UIImageView, withLink link: String) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url)
    }
    
    public func cancelDownload(ofImageView imageView: UIImageView) {
        self.downloadTasks[imageView]?.cancel()
    }
}
