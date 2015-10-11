//
//  WeatherDataHandler.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

// This class to handle connection with the backend and retrieve the weather information
// using alamofire to handle the http connection

import Foundation
import Alamofire

// protocol to callback the requestor
public protocol WeatherRequestResponseCallback {
    // called when the app retrieved weather data successfully
    func onRequestFinished(data: Weather)
    // called when there is an error during weather data retrieval
    func onRequestError(errorMessage: String)
}

public class WeatherRequestResponse: NSObject {
    
    let URL_START: String = "http://api.worldweatheronline.com/free/v1/weather.ashx?key=vzkjnx2j5f88vyn5dhvvqkzc&q="
    let URL_END: String = "&fx=yes&format=json"
    
    // object to store the response from server
    var data:NSMutableData!
    // callback protocol object
    public var delegate:WeatherRequestResponseCallback?
    // class to handle the response data parser
    public var dataParser:JSONDataParser
    
    // initialization
    override public init() {
        self.data = nil;
        self.dataParser = JSONDataParser()
    }
    
    // function handle weather data retrieval
    public func load_data(cityName: String) {
        // construct the url and put the cityname into the url
        // the city name also converted to URL encoding format
        let finalURL:String! = URL_START + cityName.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())! + URL_END
        print(finalURL);
        
        // request data to server using Alamofire
        Alamofire.request(.GET, finalURL).response { request, response, data, error in
            print(request)
            print("Response : \(response)")
            if error != nil {
                // if there is an error, throw callback using onRequestError
                let status:StatusCode = StatusCode.E109
                self.delegate?.onRequestError(status.rawValue)
                return
            } else {
                // parse response data using data parser class
                let respData:ResponseData = self.dataParser.parse(data!)
                if(respData.status == StatusCode.SUCCESS) {
                    // if no error during parsing, call onRequestFinished
                    self.delegate?.onRequestFinished(respData.weather)
                } else {
                    // if there is an error, throw callback using onRequestError
                    // if there is an error from server, return status message error
                    if respData.status == StatusCode.E101 {
                        self.delegate?.onRequestError(respData.status_message)
                    } else {
                        self.delegate?.onRequestError(respData.status.rawValue)
                    }
                }
            }
            
            
        }
    }
}