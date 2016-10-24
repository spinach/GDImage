//
//  Store.swift
//  GDImage
//
//  Created by Guy Daher on 10/23/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public class Store {
        
    public static func save(image: UIImage, toUrlPath urlPath:URL) {
        guard let path = getEscapedString(fromUrlPath: urlPath) else {return}
        
        if let data = UIImageJPEGRepresentation(image, 1) {
            print("saving image to path: \(path)")
            let filename = getDocumentsDirectory().appendingPathComponent(path)
            try? data.write(to: filename)
        }
    }
    
    public static func loadImage(fromUrlPath urlPath: URL) -> UIImage? {
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
    
    static func getEscapedString(fromUrlPath urlPath:URL) -> String? {
        return urlPath.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
