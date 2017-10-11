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
    var weather = WeatherData(temperature: 0, rainData: "It will not rain in the next hour.", weatherDescription: "Partly Cloudy", iconName: "partly-cloudy-day")
    var icon: UIImageView!
    var iconMap = ["clear-day": "clear-day",
                   "clear-night": "clear-night",
                   "rain": "rain",
                   "snow": "snow",
                   "sleet": "snow",
                   "wind": "wind",
                   "fog": "partly-cloudy-day",
                   "cloudy": "partly-cloudy-day",
                   "partly-cloudy-day": "partly-cloudy-day",
                   "partly-cloudy-night": "partly-cloudy-night"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupText()
        setupNotificationCenter()
        setupIcon()
        self.updateText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup Functions
    func setupBackground() {
        view.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1.0) // #3a3a3a
    }
    func setupNotificationCenter() {
        let nc: NotificationCenter = NotificationCenter.default
        nc.addObserver(self, selector: #selector(weatherInfoReceived(_ :)), name: NSNotification.Name(rawValue: "weather"), object: nil)
    }
    
    func setupText() {
        temperatureLabel = UILabel(frame: rRect(rx: 59, ry: 127,
                                                rw: 258, rh: 186))
        temperatureLabel.text = "0"
        temperatureLabel.textAlignment = .center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textColor = UIColor.white
        temperatureLabel.font = UIFont(name: "Helvetica", size: 140)
        view.addSubview(temperatureLabel)
        
        rainLabel = UILabel(frame: rRect(rx: 39, ry: 364,
                                         rw: 298, rh: 27))
        rainLabel.text = "It will not rain in the next hour."
        rainLabel.textAlignment = .center
        rainLabel.adjustsFontSizeToFitWidth = true
        rainLabel.textColor = UIColor.white
        view.addSubview(rainLabel)
        
        weatherDescription = UILabel(frame: rRect(rx: 50, ry: 315,
                                                  rw: 275, rh: 27))
        weatherDescription.text = "Partly Cloudy"
        weatherDescription.textAlignment = .center
        weatherDescription.textColor = UIColor.white
        view.addSubview(weatherDescription)
    }
    
    func setupIcon() {
        icon = UIImageView(frame: rRect(rx: 112, ry: 451, rw: 147, rh: 147))
        icon.image = UIImage(named: "partly-cloudy")
        icon.contentMode = .scaleAspectFit
        view.addSubview(icon)
    }
    
    func updateText() {
        // change all the labels
        temperatureLabel.text = String(weather.temperature)
        rainLabel.text = weather.rainData
        weatherDescription.text = weather.weatherDescription
        // update image
        let image = UIImage(named: iconMap[weather.iconName]!)
        icon.image = image
    }
    
    // Weather notification received
    func weatherInfoReceived(_ notification: Notification) {
        print("Notification received!")
        self.weather = notification.userInfo!["weather"] as! WeatherData
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

