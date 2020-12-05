//
//  ArrowUITests.swift
//  ArrowUITests
//
//  Created by David Williams on 11/14/20.
//  Copyright © 2020 David Williams. All rights reserved.
//

import XCTest

class ArrowUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
        //
        // Test changing settings
        //
        let app = XCUIApplication()
        let settingsButton = app.buttons["Settings"]
        let tablesQuery = app.tables

        //
        // Animation board
        //
        settingsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Board"]/*[[".cells[\"Board\"].buttons[\"Board\"]",".buttons[\"Board\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Board number 2"]/*[[".cells[\"Board number 2\"].buttons[\"Board number 2\"]",".buttons[\"Board number 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Settings"].buttons["Done"].tap()
        
        //
        // Animation speed
        //
        settingsButton.tap()
        let animationIntervalSlider = app.tables/*@START_MENU_TOKEN@*/.sliders["Animation interval"]/*[[".cells[\"Interval, Animation interval\"].sliders[\"Animation interval\"]",".sliders[\"Animation interval\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        animationIntervalSlider.swipeLeft()
        app.navigationBars["Settings"].buttons["Done"].tap()

        settingsButton.tap()
        animationIntervalSlider.swipeRight()
        app.navigationBars["Settings"].buttons["Done"].tap()

        //
        // Select theme
        //
        settingsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Theme"]/*[[".cells[\"Theme\"].buttons[\"Theme\"]",".buttons[\"Theme\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.buttons["Theme number 1"].tap()
        app.navigationBars["Settings"].buttons["Done"].tap()

        //
        // Custom theme
        //
        settingsButton.tap()
        let customizeButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Customize…"]/*[[".cells[\"Customize…\"].buttons[\"Customize…\"]",".buttons[\"Customize…\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        customizeButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Add Theme…"]/*[[".cells[\"Add Theme…\"].buttons[\"Add Theme…\"]",".buttons[\"Add Theme…\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.otherElements["Bulb On"]/*[[".cells.otherElements[\"Bulb On\"]",".otherElements[\"Bulb On\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.otherElements["cyan blue 50"].tap()
        
        let closeButton = elementsQuery.buttons["close"]
        closeButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.otherElements["Bulb Off"]/*[[".cells.otherElements[\"Bulb Off\"]",".otherElements[\"Bulb Off\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        elementsQuery.otherElements["gray 44"].tap()
        closeButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.otherElements["Background"]/*[[".cells.otherElements[\"Background\"]",".otherElements[\"Background\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        elementsQuery.otherElements["dark cyan blue 18"].tap()
        closeButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.otherElements["Control"]/*[[".cells.otherElements[\"Control\"]",".otherElements[\"Control\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element.tap()
        elementsQuery.otherElements["gray 84"].tap()
        closeButton.tap()
        app.navigationBars["New Theme"].buttons["Add"].tap()
        
        let settingsButton2 = app.navigationBars["Custom Themes"].buttons["Settings"]
        settingsButton2.tap()
        app.navigationBars["Settings"].buttons["Done"].tap()

        settingsButton.tap()
        customizeButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Trash theme number 10"]/*[[".cells[\"Theme number 10, Trash theme number 10\"].buttons[\"Trash theme number 10\"]",".buttons[\"Trash theme number 10\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        settingsButton2.tap()
        app.navigationBars["Settings"].buttons["Done"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric(waitUntilResponsive: true)]) {
                XCUIApplication().launch()
            }
        }
    }
}
