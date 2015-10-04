//
//  ResponseData.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import Foundation

public class ResponseData: NSObject {
    // response data status code
    // 0 means there is no error
    public var status_code:Int
    // status message to describe the status code
    public var status_message:String
    // weather object
    public var weather: Weather
    
    // initialization
    override init() {
        self.status_code = 0
        self.status_message = "Success"
        self.weather = Weather()
        super.init()
    }
}