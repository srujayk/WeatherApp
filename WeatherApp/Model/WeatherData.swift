//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Stephen Jayakar on 10/10/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//


struct WeatherData {
    var temperature: Int!
    // If it's empty, no rain; otherwise, it will be in minutes until it rains
    var rainData: String!
    var weatherDescription: String!
    
    init(temperature: Int, rainData: String, weatherDescription: String) {
        self.temperature = temperature
        self.rainData = rainData
        self.weatherDescription = weatherDescription
    }
}
