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


class SplashViewController: UIViewController {
    
    var current_desc: String!
    var minutely_desc: String!
    var rain_time: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // needs to segue after like a second
        
        var weatherData = Alamofire.request("https://api.darksky.net/forecast/e992c804052acdd34db963b614a1b985/37.8267,-122.4233").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = JSON(response.result.value) {
                //print("JSON: \(json)") // serialized json response
                
                current_desc = json["currently"]["summary"].stringValue
                minutely_desc = json["minutely"]["summary"].stringValue
                rain_time = json["minutely"]["data"]["time"]
                
                print(current_desc)
                print(minutely_desc)
                print(rain_time)
                
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
