//
//  SplashViewController.swift
//  WeatherApp
//
//  Created by Stephen Jayakar on 10/9/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

let notificationKey = "weather"

class SplashViewController: UIViewController {
    
    var currentDesc: String!
    var minutelyDesc: String!
    var precip: String!
    var rainTime: Double!
    var temp: Int!
    var locManager: CLLocationManager!
    var latitude: Double!
    var longitude: Double!
    var currentLocation: CLLocation!
    var poweredBy: UILabel!
    var logo: UIImageView!
    var notificationFinished = false


    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        setupText()
        setupBackground()
        setupLogo()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        while (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            locManager.requestWhenInUseAuthorization()
        }
        locManager.startUpdatingLocation()
    }
    
    // Setup Functions
    func setupText() {
        poweredBy = UILabel(frame: rRect(rx: 13, ry: 31, rw: 185, rh: 27))
        poweredBy.text = "Powered by Dark Sky"
        poweredBy.textColor = UIColor.white
        poweredBy.adjustsFontSizeToFitWidth = true
        view.addSubview(poweredBy)
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1.0) // #3a3a3a
    }
    
    func setupLogo() {
        logo = UIImageView(frame: rRect(rx: 13, ry: 87, rw: 350, rh: 350))
        logo.image = UIImage(named: "Logo")
        view.addSubview(logo)
    }
    
    func canWeSegue() {
        if (self.notificationFinished) {
            self.performSegue(withIdentifier: "toWeather", sender: self)
        }
    }
}

extension SplashViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        
        self.latitude = 22.68
        self.longitude = 79.5
        
        var weatherData = Alamofire.request("https://api.darksky.net/forecast/e992c804052acdd34db963b614a1b985/" + String(latitude) + "," + String(longitude)).responseJSON { response in                  // response serialization result
            if let json = response.result.value {
                let json2 = JSON(json)
        
                self.temp = Int(json2["currently"]["temperature"].double!)
                self.currentDesc = json2["currently"]["summary"].stringValue
                let iconName = json2["currently"]["icon"].stringValue
                self.precip = json2["minutely"]["data"][0]["precipType"].string
                self.rainTime = json2["minutely"]["data"][0]["time"].double
                
                if self.precip != "rain" {
                    self.minutelyDesc = "It will not rain in the next hour."
                } else {
                    self.minutelyDesc = "It will rain at " + String(describing: NSDate(timeIntervalSince1970: self.rainTime)) + "!"
                }
                
                let weather = WeatherData(temperature: self.temp, rainData: self.minutelyDesc, weatherDescription: self.currentDesc, iconName: iconName)
                // Notification manager
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: "weather"), object: nil, userInfo: ["weather": weather])
                self.notificationFinished = true
                self.locManager.stopUpdatingLocation()
                self.canWeSegue()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

