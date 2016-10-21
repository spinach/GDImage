//
//  ViewController.swift
//  Demo
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import UIKit
import GDImage

class ViewController: UITableViewController {

    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        self.refreshControl = self.refreshCtrl
        
        self.tableData = []
        self.cache = NSCache()
    }
    
    func refreshTableView(){
        
        let url:URL! = URL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
                do{
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                    self.tableData = dic.value(forKey : "results") as? [AnyObject]
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        let dictionary = self.tableData[(indexPath as NSIndexPath).row] as! [String:AnyObject]
        cell.textLabel!.text = dictionary["trackName"] as? String
        cell.imageView?.image = UIImage(named: "placeholder")
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // Use cache
            print("Cached image used, no need to download it")
            cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            let artworkUrl = dictionary["artworkUrl100"] as! String
            let url:URL! = URL(string: artworkUrl)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async(execute: { () -> Void in
                        // Before we assign the image, check whether the current cell is visible
                        if let updateCell = tableView.cellForRow(at: indexPath) {
                            let img:UIImage! = UIImage(data: data)
                            updateCell.imageView?.image = img
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            })
            task.resume()
        }
        return cell
    }
}

