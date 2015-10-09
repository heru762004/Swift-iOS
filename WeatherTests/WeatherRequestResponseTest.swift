//
//  WeatherRequestResponseTest.swift
//  Weather
//
//  Created by Heru Prasetia on 9/10/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import XCTest
import Weather


class WeatherRequestResponseTest: XCTestCase {
    var weatherReqResp:WeatherRequestResponse?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherReqResp = WeatherRequestResponse()
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
