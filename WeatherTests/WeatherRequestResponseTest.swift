//
//  WeatherRequestResponseTest.swift
//  Weather
//
//  Created by Heru Prasetia on 9/10/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import XCTest
import Weather
import OHHTTPStubs

class WeatherRequestResponseTest: XCTestCase, WeatherRequestResponseCallback {
    var weatherReqResp:WeatherRequestResponse?
    var weatherData:Weather!
    var expectation:XCTestExpectation!
    var errorMessage:String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherReqResp = WeatherRequestResponse()
        self.weatherReqResp?.delegate = self
        XCTAssertNotNil(self.weatherReqResp)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    // test whether weatherReqResp is created or not
    func testThatWeatherReqRespCreated() {
        XCTAssertNotNil(self.weatherReqResp?.dataParser)
    }
    
    // test normal request response on weatherrequestResponse
    func testNormalRequestResponse() {
        // stub and mock alamofire request
        OHHTTPStubs.stubRequestsPassingTest({
            (request: NSURLRequest) -> Bool in
            return request.URL!.absoluteString == "http://api.worldweatheronline.com/free/v1/weather.ashx?key=vzkjnx2j5f88vyn5dhvvqkzc&q=Port%20Moresby&fx=yes&format=json"
            }, withStubResponse: {
                (request: NSURLRequest) -> OHHTTPStubsResponse in
                //return OHHTTPStubsResponse(JSONObject: obj, statusCode:200, headers:nil)
                return OHHTTPStubsResponse(fileAtPath: OHPathForFile("normal_json.json", self.dynamicType)!, statusCode: 200, headers: ["Content-Type":"application/json"])
        })
        // define expectation to wait
        self.expectation = self.expectationWithDescription("WeatherReqRespWait")
        self.weatherReqResp?.load_data("Port Moresby")
        self.waitForExpectationsWithTimeout(500, handler: {error in
            if error == nil {
                XCTAssertNotNil(self.weatherData)
                XCTAssertEqual(self.weatherData.cityName, "Port Moresby, Papua New Guinea")
            }
        })
    }

    // test normal request response on weatherrequestResponse
    func testFailedRequestResponse() {
        // stub and mock alamofire request
        OHHTTPStubs.stubRequestsPassingTest({
            (request: NSURLRequest) -> Bool in
            return request.URL!.absoluteString == "http://api.worldweatheronline.com/free/v1/weather.ashx?key=vzkjnx2j5f88vyn5dhvvqkzc&q=ABCDEF&fx=yes&format=json"
            }, withStubResponse: {
                (request: NSURLRequest) -> OHHTTPStubsResponse in
                //return OHHTTPStubsResponse(JSONObject: obj, statusCode:200, headers:nil)
                return OHHTTPStubsResponse(fileAtPath: OHPathForFile("error_no_location_json.json", self.dynamicType)!, statusCode: 200, headers: ["Content-Type":"application/json"])
        })
        // define expectation to wait
        self.expectation = self.expectationWithDescription("WeatherReqRespWait")
        self.weatherReqResp?.load_data("ABCDEF")
        self.waitForExpectationsWithTimeout(500, handler: {error in
            if error == nil {
                XCTAssertNotNil(self.errorMessage)
                XCTAssertEqual(self.errorMessage, "Unable to find any matching weather location to the query submitted!")
            }
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // called when the app retrieved weather data successfully
    func onRequestFinished(data: Weather) {
        self.weatherData = data
        self.expectation.fulfill()
    }
    
    
    // called when there is an error during weather data retrieval
    func onRequestError(errorMessage: String) {
        self.errorMessage = errorMessage
        self.expectation.fulfill()
    }
}
