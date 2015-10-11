//
//  ResponseData.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import Foundation

public enum StatusCode: String {
    case SUCCESS = "Success"
    case E101 = "Error from server"
    case E102 = "Invalid JSON response"
    case E103 = "Cannot get weather description"
    case E104 = "Cannot get city name"
    case E105 = "Cannot get weather icon data"
    case E106 = "Cannot get humidity"
    case E107 = "Cannot get temperature"
    case E108 = "Cannot get observation time"
    case E109 = "Cannot establish connection to server"
}

public class ResponseData: NSObject {
    // response data status
    public var status:StatusCode
    // response status message from server
    public var status_message:String
    // weather object
    public var weather: Weather
    
    // initialization
    override init() {
        status = StatusCode.SUCCESS
        status_message = StatusCode.SUCCESS.rawValue
        self.weather = Weather()
        super.init()
    }
}