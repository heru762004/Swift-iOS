//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import UIKit
import XCTest


class WeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // normal flow test
    func testNormalFlow() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.textFields["Enter City Name"].tap()
        app.textFields["Enter City Name"].typeText("Singapore")
        app.typeText("\n")
        app.buttons["Search"].tap()
        app.navigationBars["Singapore, Singapore"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.textFields["Enter City Name"].tap()
        let table2 = app.tables.elementBoundByIndex(0)
        XCTAssertEqual(table2.exists, true)
        XCTAssertEqual(table2.staticTexts["Singapore"].exists, true)
    }
    
    // test select city from table
    func testSelectFromTableSuggestion() {
        
        let app = XCUIApplication()
        app.textFields["Enter City Name"].tap()
        app.tables.staticTexts["Singapore"].tap()
        app.navigationBars["Singapore, Singapore"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.textFields["Enter City Name"].tap()
        let table2 = app.tables.elementBoundByIndex(0)
        XCTAssertEqual(table2.exists, true)
        XCTAssertEqual(table2.staticTexts["Singapore"].exists, true)
    }
    
}
