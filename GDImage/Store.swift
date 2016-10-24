//
//  Store.swift
//  GDImage
//
//  Created by Guy Daher on 10/23/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public class Store {
    
    private var cache: NSCache<NSString, UIImage>
    
    init() {
        self.cache = NSCache()
    }
    
    public func get(withUrlPath urlPath:URL) -> UIImage? {
        if let image = getFromCache(withUrlPath: urlPath) {
            print("Got image from cache")
            return image
        }
        
        if let image = getFromDocumentsFolder(withUrlPath: urlPath){
            print("Got image from documents folder")
            return image
        }
        
        return nil
    }
    
    public func save(image: UIImage, toUrlPath url:URL) {
        putInCache(image: image, forKey: url)
        putInDocumentsFolder(image: image, toUrlPath: url)
    }
    
    func getFromCache(withUrlPath urlPath:URL) -> UIImage? {
        return self.cache.object(forKey: urlPath.absoluteString as NSString)
    }
    
    func getFromDocumentsFolder(withUrlPath urlPath: URL) -> UIImage? {
        guard let path = getEscapedString(fromUrlPath: urlPath) else {return nil}
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
    
    func putInCache(image: UIImage, forKey url: URL) {
        self.cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func putInDocumentsFolder(image: UIImage, toUrlPath url: URL) {
        guard let path = getEscapedString(fromUrlPath: url) else {return}
        
        if let data = UIImageJPEGRepresentation(image, 1) {
            print("saving image to path: \(path)")
            let filename = getDocumentsDirectory().appendingPathComponent(path)
            try? data.write(to: filename)
        }
    }
    
    func getEscapedString(fromUrlPath urlPath:URL) -> String? {
        return urlPath.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
