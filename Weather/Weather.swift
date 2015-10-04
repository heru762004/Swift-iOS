//
//  Weather.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import Foundation

public class Weather: NSObject {
    // weather icon url
    public var weatherIconUrl:String
    // city name
    public var cityName:String
    // temperature in Celcius
    public var temp_C:Int
    // humidity
    public var humidity:Int
    // weather description
    public var weatherDesc:String
    // observation time
    public var observation_time:String
    
    // initialization
    override init() {
        self.temp_C = 0
        self.humidity = 0
        self.weatherIconUrl = String()
        self.cityName = String()
        self.weatherDesc = String()
        self.observation_time = String()
    }
}