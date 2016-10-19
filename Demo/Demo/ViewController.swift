//
//  ViewController.swift
//  Demo
//
//  Created by Guy Daher on 10/18/16.
//  Copyright © 2016 guydaher. All rights reserved.
//

import UIKit
import GDImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guy = Guy()
        print(guy.sum(a: 3, b: 5))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

