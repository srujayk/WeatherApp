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
    var rainTime: Int!
    var temp: Int!
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
        
                self.temp = Int(json2["currently"]["temperature"].double!)
                self.currentDesc = json2["currently"]["summary"].stringValue
                self.minutelyDesc = json2["minutely"]["summary"].stringValue
                self.precip = json2["minutely"]["data"][0]["precipType"].string
                self.rainTime = json2["minutely"]["data"][0]["time"].int
                
                if self.precip != "rain" {
                    self.rainTime = 0
                    self.minutelyDesc = "It will not rain in the next hour."
                } else {
                    self.minutelyDesc = self.minutelyDesc + " It will rain at " + String(self.rainTime)
                }
        
                print(self.currentDesc)
                print(self.minutelyDesc)
                print(self.precip)
                print(self.rainTime)
                
                let weather = WeatherData(temperature: self.temp, rainData: self.minutelyDesc, weatherDescription: self.currentDesc)
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

