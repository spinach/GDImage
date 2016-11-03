//
//  Guy.swift
//  GDImage
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import Foundation

public typealias CompletionHandler = ((_ image: UIImage?, _ error: Error?) -> ())

public class GDImage {
    
    private var downloadTasks: [UIImageView:URLSessionDataTask]
    private var store: ImageStore
    private var contentMode: UIViewContentMode
    private var useStore: Bool
    private let activityIndicator: UIActivityIndicatorView
    
    public init(useStore:Bool = true, contentMode: UIViewContentMode = .scaleAspectFit, activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray) {
        self.downloadTasks = [:]
        self.store = Store()
        self.useStore = useStore
        self.contentMode = contentMode
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: activityIndicatorStyle)

    }
    
    public func setImage(ofImageView imageView: UIImageView, withUrl url: URL, andCompletionHandler completionHandler: CompletionHandler? = nil) {
        imageView.contentMode = self.contentMode
        self.activityIndicator.startAnimating(inImageView: imageView)
        
        if useStore, let image = store.get(withUrlPath: url) {
            imageView.image = image
            activityIndicator.stopAnimating()
            completionHandler?(image, nil /* error */)
            return
        }
        
        self.downloadTasks[imageView] = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    self.activityIndicator.stopAnimating()
                    completionHandler?(nil, error)
                    return
                }
            
            if self.useStore {
                DispatchQueue.global(qos: .background).async {
                    self.store.save(image: image, toUrlPath:url)
                }
            }
            
            DispatchQueue.main.async() { () -> Void in
                imageView.image = image
                self.activityIndicator.stopAnimating()
            }
            
            // since done with task, remove from list of tasks
            self.downloadTasks[imageView] = nil
            completionHandler?(image, nil /* error */)
        }
        
        self.downloadTasks[imageView]?.resume()
    }
    
    public func setImage(ofImageView imageView: UIImageView, withLink link: String, andCompletionHandler completionHandler: CompletionHandler? = nil) {
        guard let url = URL(string: link) else { return }
        setImage(ofImageView: imageView, withUrl: url, andCompletionHandler: completionHandler)
    }
    
    public func cancelDownload(ofImageView imageView: UIImageView) {
        self.downloadTasks[imageView]?.cancel()
    }
}
