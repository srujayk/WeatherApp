//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Stephen Jayakar on 10/9/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    var temperatureLabel: UILabel!
    var rainLabel: UILabel!
    var weatherDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationCenter()
        setupText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup Functions
    func setupNotificationCenter() {
        let nc: NotificationCenter = NotificationCenter.default
        nc.addObserver(self, selector: #selector(weatherInfoReceived(_ :)), name: NSNotification.Name(rawValue: "weather"), object: nil)
    }
    
    func setupText() {
        temperatureLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 50, height: 40))
        temperatureLabel.text = "200"
        temperatureLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(temperatureLabel)
        
        rainLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 50, height: 40))
        rainLabel.text = "ITS FUCKING RAINING"
        rainLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(rainLabel)
        
        weatherDescription = UILabel(frame: CGRect(x: 10, y: 90, width: 50, height: 40))
        weatherDescription.text = "Fuck the weather"
        view.addSubview(weatherDescription)
    }
    
    // Weather notification received
    func weatherInfoReceived(_ notification: Notification) {
        print(notification.object as! String)
        print("data received")
    }
}

