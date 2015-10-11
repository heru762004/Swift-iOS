//
//  DataStorageTest.swift
//  Weather
//
//  Created by Heru Prasetia on 10/3/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import XCTest
import Weather

class DataStorageTest: XCTestCase {
    var cityNameStorage:CityNameStorageHandler!
    
    override func setUp() {
        super.setUp()
        self.cityNameStorage = CityNameStorageHandler()
        // remove all the data first
        self.cityNameStorage.removeAllCityNames()
        // reset max num of city to default (10)
        self.cityNameStorage.resetMaxNumOfCityToDefault()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddDuplicateCityName() {
        // This is an example of a functional test case.
        self.cityNameStorage.addCityName("Berlin")
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 1)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), ["Berlin"])
        
        self.cityNameStorage.addCityName("Berlin")
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 1)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), ["Berlin"])
    }
    
    // it keeps return 10 data (city names) and remove the old city name
    func testAddManyCityName() {
        self.cityNameStorage.addCityName("Singapore")
        self.cityNameStorage.addCityName("Bali")
        self.cityNameStorage.addCityName("Jakarta")
        self.cityNameStorage.addCityName("Batam")
        self.cityNameStorage.addCityName("Ho Chi Minh")
        self.cityNameStorage.addCityName("Tokyo")
        self.cityNameStorage.addCityName("Kuala Lumpur")
        self.cityNameStorage.addCityName("Sarawak")
        self.cityNameStorage.addCityName("Kuching")
        self.cityNameStorage.addCityName("Penang")
        self.cityNameStorage.addCityName("California")
        
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 10)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), ["Bali", "Jakarta", "Batam", "Ho Chi Minh", "Tokyo", "Kuala Lumpur", "Sarawak", "Kuching", "Penang", "California"])
    }
    
    func testAddEmptyCityName() {
        self.cityNameStorage.addCityName("")
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 0)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), [])
    }
    
    // test set maximum number of city to 5
    func testSetMaximumNumberOfCityStorage() {
        self.cityNameStorage.setMaxNumOfCity("5")
        self.cityNameStorage.addCityName("Singapore")
        self.cityNameStorage.addCityName("Bali")
        self.cityNameStorage.addCityName("Jakarta")
        self.cityNameStorage.addCityName("Batam")
        self.cityNameStorage.addCityName("Ho Chi Minh")
        self.cityNameStorage.addCityName("Tokyo")
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 5)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), ["Bali", "Jakarta", "Batam", "Ho Chi Minh", "Tokyo"])
    }
    
    // test set maximum number of city to empty
    func testSetMaximumNumberOfCityEmpty() {
        self.cityNameStorage.setMaxNumOfCity("")
        self.cityNameStorage.addCityName("Singapore")
        self.cityNameStorage.addCityName("Bali")
        self.cityNameStorage.addCityName("Jakarta")
        self.cityNameStorage.addCityName("Batam")
        self.cityNameStorage.addCityName("Ho Chi Minh")
        self.cityNameStorage.addCityName("Tokyo")
        XCTAssertEqual(self.cityNameStorage.cityNameDataCount(), 6)
        XCTAssertEqual(self.cityNameStorage.getAllCitiesName(), ["Singapore", "Bali", "Jakarta", "Batam", "Ho Chi Minh", "Tokyo"])

    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
