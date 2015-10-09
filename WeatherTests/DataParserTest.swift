//
//  NormalRequestResponse.swift
//  Weather
//
//  Created by Heru Prasetia on 10/3/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import XCTest
import Weather

class DataParserTest: XCTestCase {

    var testDataNormal:NSData!
    var testDataErrorNoLocation:NSData!
    var testDataMissingCurrentCondition:NSData!
    var testDataMissingCity:NSData!
    var testDataMissingHumidity:NSData!
    var testDataMissingTemperature:NSData!
    var testDataMissingObsTime:NSData!
    var dataParser:DataParser!
    
    override func setUp() {
        super.setUp()
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("normal_json", ofType: "json") {
            self.testDataNormal = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("error_no_location_json", ofType: "json") {
            self.testDataErrorNoLocation = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("missing_current_condition_tag_json", ofType: "json") {
            self.testDataMissingCurrentCondition = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("missing_city_json", ofType: "json") {
            self.testDataMissingCity = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("missing_humidity_json", ofType: "json") {
            self.testDataMissingHumidity = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("missing_temperature_json", ofType: "json") {
            self.testDataMissingTemperature = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        
        if let file = NSBundle(forClass:DataParserTest.self).pathForResource("missing_obs_time_json", ofType: "json") {
            self.testDataMissingObsTime = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
        self.dataParser = JSONDataParser()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNormalData() {
        // This is an example of a functional test case.
        // This function to test normal json data input output
        let result:ResponseData = self.dataParser.parse(testDataNormal)
        XCTAssertEqual(result.status, StatusCode.SUCCESS)
        XCTAssertNotEqual(result.weather, nil)
        XCTAssertEqual(result.weather.weatherIconUrl, "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0006_mist.png")
        XCTAssertEqual(result.weather.cityName, "Port Moresby, Papua New Guinea")
        XCTAssertEqual(result.weather.temp_C, 29)
        XCTAssertEqual(result.weather.humidity, 58)
        XCTAssertEqual(result.weather.weatherDesc, "Mist")
        XCTAssertEqual(result.weather.observation_time, "05:45 AM")
    }
    
    func testDataError() {
        // This function to test negative test case : unable to find weather location
        let result:ResponseData = self.dataParser.parse(self.testDataErrorNoLocation)
        XCTAssertEqual(result.status, StatusCode.E101)
        XCTAssertNotEqual(result.weather, nil)
        
        XCTAssertEqual(result.weather.weatherIconUrl, "")
        XCTAssertEqual(result.weather.cityName, "")
        XCTAssertEqual(result.weather.temp_C, 0)
        XCTAssertEqual(result.weather.humidity, 0)
        XCTAssertEqual(result.weather.weatherDesc, "")
        XCTAssertEqual(result.weather.observation_time, "")
    }
    
    func testMissingCurrentCondition() {
        // function to test missing current condition
        let result:ResponseData = self.dataParser.parse(self.testDataMissingCurrentCondition)
        XCTAssertEqual(result.status, StatusCode.E102)
    }
    
    func testMissingCity() {
        // This function to test negative test case : unable to find weather location
        let result:ResponseData = self.dataParser.parse(self.testDataMissingCity)
        XCTAssertEqual(result.status, StatusCode.E104)
        XCTAssertNotEqual(result.weather, nil)
    }
    
    func testMissingHumidity() {
        // function to test missing current condition
        let result:ResponseData = self.dataParser.parse(self.testDataMissingHumidity)
        XCTAssertEqual(result.status, StatusCode.E106)
    }
    
    func testMissingTemperature() {
        // function to test missing current condition
        let result:ResponseData = self.dataParser.parse(self.testDataMissingTemperature)
        XCTAssertEqual(result.status, StatusCode.E107)
    }
    
    func testMissingObsTime() {
        // function to test missing current condition
        let result:ResponseData = self.dataParser.parse(self.testDataMissingObsTime)
        XCTAssertEqual(result.status, StatusCode.E108)
    }
    
    func testDataEmptyJSON() {
        // function to test empty json
        let data:NSData! = ("{}" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result:ResponseData = self.dataParser.parse(data)
        XCTAssertEqual(result.status, StatusCode.E102)
    }
    
    func testDataEmpty() {
        let data:NSData! = ("" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result:ResponseData = self.dataParser.parse(data)
        XCTAssertEqual(result.status, StatusCode.E102)
    }
    
    func testDataPlainText() {
        let data:NSData! = ("Error 404" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result:ResponseData = self.dataParser.parse(data)
        XCTAssertEqual(result.status, StatusCode.E102)
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
