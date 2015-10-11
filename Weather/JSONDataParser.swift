//
//  JSONDataParser.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

// class to handle response data parser in JSON Format

import Foundation
import SwiftyJSON

public class JSONDataParser: NSObject {
    
    // function to parse the data
    public func parse(input: NSData) -> ResponseData {
        let resp:ResponseData = ResponseData()
        let json = JSON(data: input)
        print(json)
        let data = json["data"]
        // detect data tag
        if data != nil {
            if data["error"] != nil && data["error"].count > 0 {
                resp.status = StatusCode.E101
                resp.status_message = data["error"][0]["msg"].string!
                //resp.status.rawValue = data["message"]
            } else {
                if data["current_condition"].count > 0 {
                    if data["current_condition"][0]["observation_time"] == nil {
                        resp.status = StatusCode.E108
                    } else {
                        resp.weather.observation_time = data["current_condition"][0]["observation_time"].string!
                    }
                    if data["current_condition"][0]["humidity"] == nil {
                        resp.status = StatusCode.E106
                    } else {
                        resp.weather.humidity = data["current_condition"][0]["humidity"].intValue
                    }
                    if data["current_condition"][0]["temp_C"] == nil {
                        resp.status = StatusCode.E107
                    } else {
                        resp.weather.temp_C = data["current_condition"][0]["temp_C"].intValue
                    }
                    if data["current_condition"][0]["weatherDesc"].count > 0 {
                        resp.weather.weatherDesc = data["current_condition"][0]["weatherDesc"][0]["value"].string!
                    } else {
                        resp.status = StatusCode.E103
                    }
                    print("obs time = \(resp.weather.observation_time)")
                    
                    if data["current_condition"][0]["weatherIconUrl"].count > 0 {
                        resp.weather.weatherIconUrl = data["current_condition"][0]["weatherIconUrl"][0]["value"].string!
                    } else {
                        resp.status = StatusCode.E105
                    }
                    
                    if data["request"] != nil && data["request"].count > 0 {
                        resp.weather.cityName = data["request"][0]["query"].string!
                    } else {
                        resp.status = StatusCode.E104
                    }
                }
                else {
                    resp.status = StatusCode.E102
                }
            }
        } else {
            resp.status = StatusCode.E102
        }
        return resp
    }
}