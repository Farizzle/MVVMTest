//
//  PulseLiveUITests.swift
//  PulseLiveUITests
//
//  Created by Metricell Developer on 09/03/2019.
//  Copyright © 2019 Metricell Developer. All rights reserved.
//

import XCTest

class PulseLiveUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArticle3UIElements(){
        let app = XCUIApplication()
        // Find the cell relative to Article 3 and select it
        let article3Cell = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Article 3").element
        XCTAssertTrue(article3Cell.exists)
        article3Cell.tap()
        // Find and confirm the correct title for Article 3
        let article3Title = app.staticTexts["Article 3"]
        XCTAssertTrue(article3Title.exists)
        // Find and confirm the correct subtitle for Article 3
        let article3SubTitle = app.staticTexts["Article 3 subtitle with placeholder text"]
        XCTAssertTrue(article3SubTitle.exists)
        // Find and confirm the correct date for Article 3
        let article3Date = app.staticTexts["13/04/2013 11:48"]
        XCTAssertTrue(article3Date.exists)
        // Find and confirm the correct body for Article 3
        let predicate = NSPredicate(format: "label LIKE 'Article 3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Article 3'")
        let article3Body = app.staticTexts.element(matching: predicate)
        XCTAssertTrue(article3Body.exists)
        // Find and confirm the correct ID for Article 3
        let articleID = app.staticTexts["31"]
        XCTAssertTrue(articleID.exists)
        // Return to collectionView
        app.navigationBars["Article 3"].buttons["Content List"].tap()
    }

}
