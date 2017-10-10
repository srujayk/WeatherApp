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

let notificationKey = "weather"


class SplashViewController: UIViewController {
    
    var current_desc: String!
    var minutely_desc: String!
    var precip: Int!
    var rain_time: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // needs to segue after like a second
        
        var weatherData = Alamofire.request("https://api.darksky.net/forecast/e992c804052acdd34db963b614a1b985/37.8267,-122.4233").responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                let json2 = JSON(json)
                
                self.current_desc = json2["currently"]["summary"].stringValue
                self.minutely_desc = json2["minutely"]["summary"].stringValue
                self.precip = json2["minutely"]["data"][0]["precipProbability"].int
                self.rain_time = json2["minutely"]["data"][0]["time"].int
                
                print(self.current_desc)
                print(self.minutely_desc)
                print(self.precip)
                print(self.rain_time)
                // Notification manager
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: "weather"), object: self)
            }
        }
    }
}
