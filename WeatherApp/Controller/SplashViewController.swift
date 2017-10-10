//
//  ViewController.swift
//  WeatherApp
//
//  Created by Stephen Jayakar on 10/9/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit

// Will only appear for around a second, then auto segue -> weathervc
class SplashViewController: UIViewController {
    var poweredByMessage: UILabel!
    // api key e992c804052acdd34db963b614a1b985
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupText()
    }
    
    func setupText() {
        poweredByMessage = UILabel(frame: rRect(rx: 20, ry: 20,
                                                rw: 100, rh: 30))
    }
}

