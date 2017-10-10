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
        
        setupText()
        setupNotificationCenter()
        
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
        temperatureLabel.text = ""
        temperatureLabel.textAlignment = .center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(temperatureLabel)
        
        rainLabel = UILabel(frame: rRect(rx: 39, ry: 364,
                                         rw: 298, rh: 27))
        rainLabel.text = ""
        rainLabel.textAlignment = .center
        rainLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(rainLabel)
        
        weatherDescription = UILabel(frame: rRect(rx: 50, ry: 315,
                                                  rw: 275, rh: 27))
        weatherDescription.text = ""
        weatherDescription.textAlignment = .center
        view.addSubview(weatherDescription)
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

extension UIViewController {
    func rRect(rx: CGFloat, ry: CGFloat,
               rw: CGFloat, rh: CGFloat) -> CGRect {
        // magic numbers for iPhone 6/7 relative coords
        let w: CGFloat = 375
        let h: CGFloat = 667
        let x: CGFloat = (rx / w) * view.frame.width
        let y: CGFloat = (ry / h) * view.frame.height
        let width: CGFloat = (rw / w) * view.frame.width
        let height: CGFloat = (rh / h) * view.frame.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

