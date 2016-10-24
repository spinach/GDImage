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
    private var cache: NSCache<NSString, UIImage>
    
    public init() {
        self.downloadTasks = [:]
        self.cache = NSCache()
    }
    
    public func setImage(ofImageView imageView: UIImageView, withUrl url: URL) {
        imageView.contentMode = .scaleAspectFit
        
        if let image = self.cache.object(forKey: url.absoluteString as NSString) {
            imageView.image = image
            return
        }
        
        let escapedString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if let image = loadImageFromPath(path: escapedString!) {
            print("from disk!")
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
            
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            
            let escapedString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            self.save(image: image, toPath: escapedString!)
            
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
    
    public func save(image: UIImage, toPath path:String) {
        if let data = UIImageJPEGRepresentation(image, 1) {
            print("got data, now saving")
            let filename = getDocumentsDirectory().appendingPathComponent(path)
            try? data.write(to: filename)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        print("Loading image from path: \(path)")
        let filename = getDocumentsDirectory().appendingPathComponent(path)
        
        do {
            let imageData = try Data(contentsOf: filename)
            let image = UIImage(data: imageData)
            return image
        } catch {
            return nil
        }
    }
}
