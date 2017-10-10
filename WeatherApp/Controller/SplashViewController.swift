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
    
    var current_desc: String!
    var minutely_desc: String!
    var precip: Int!
    var rain_time: Int!
    var temp: Double!
    var locManager: CLLocationManager!
    var latitude: Double!
    var longitude: Double!
    var currentLocation: CLLocation!


    override func viewDidLoad() {
        super.viewDidLoad()

        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewDidAppear(_ animated: Bool) {
        while (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            locManager.requestWhenInUseAuthorization()
        }
        locManager.startUpdatingLocation()
    }
}

extension SplashViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        
        var weatherData = Alamofire.request("https://api.darksky.net/forecast/e992c804052acdd34db963b614a1b985/" + String(latitude) + "," + String(longitude)).responseJSON { response in                  // response serialization result
            if let json = response.result.value {
                let json2 = JSON(json)
        
                self.temp = json2["currently"]["temperature"].double
                self.current_desc = json2["currently"]["summary"].stringValue
                self.minutely_desc = json2["minutely"]["summary"].stringValue
                self.precip = json2["minutely"]["data"][0]["precipType"].string
                self.rain_time = json2["minutely"]["data"][0]["time"].int
                
                if self.precip != "rain" {
                    self.rain_time = 0
                    self.minutely_desc = "It will not rain in the next hour."
                } else {
                    self.minutely_desc = minutely_desc + " It will rain at " + String(rain_time)
                }
        
                print(self.current_desc)
                print(self.minutely_desc)
                print(self.precip)
                print(self.rain_time)
                
                let weather = WeatherData(temperature: self.temp, rainData: minutely_desc, weatherDescription: current_desc, rainTime: rainTime)
                // Notification manager
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: "weather"), object: nil, userInfo: ["weather": weather])
                self.performSegue(withIdentifier: "toWeather", sender: self)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

