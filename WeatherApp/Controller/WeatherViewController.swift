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
    var weather: WeatherData!
    
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
        temperatureLabel = UILabel(frame: rRect(rx: 89, ry: 145,
                                                rw: 197, rh: 133))
        temperatureLabel.text = "200"
        temperatureLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(temperatureLabel)
        
        rainLabel = UILabel(frame: rRect(rx: 90, ry: 300,
                                         rw: 300, rh: 50))
        rainLabel.text = "it's raining !"
        rainLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(rainLabel)
        
        weatherDescription = UILabel(frame: rRect(rx: 90, ry: 400,
                                                  rw: 300, rh: 50))
        weatherDescription.text = "i love the sun"
        view.addSubview(weatherDescription)
        weatherDescription.text = "moo"
    }
    
    func updateText() {
        // change all the labels
        temperatureLabel.text = String(weather.temperature)
        rainLabel.text = weather.rainData
        weatherDescription.text = weather.weatherDescription
        
    }
    
    // Weather notification received
    func weatherInfoReceived(_ notification: Notification) {
        weather = notification.userInfo!["weather"] as! WeatherData
        print(weather.rainData)
        updateText()
    }
}

