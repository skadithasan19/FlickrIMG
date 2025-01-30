//
//  FlickrIMGUITests.swift
//  FlickrIMGUITests
//
//  Created by Adit Hasan on 1/18/25.
//

import XCTest

final class FlickrIMGUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }

    func testSearchAndTapOnGridItem() throws {
        // 1. Verify the search bar exists
        let searchBar = app.textFields["Search Bar"]
        XCTAssertTrue(searchBar.exists, "The search bar does not exist.")
        
        // 2. Perform a search
        searchBar.tap()
        searchBar.typeText("Nature")
        app.keyboards.buttons["return"].tap()
        
        // 3. Wait for grid items to load
        let firstGridItem = app.buttons["GridItem_0"]
        XCTAssertTrue(firstGridItem.waitForExistence(timeout: 5), "The first grid item did not appear.")
        
        // 4. Tap on the first grid item
        firstGridItem.tap()
        
        let backButton = app.buttons["BackButton"]
        XCTAssertTrue(backButton.exists, "Back button does not exist.")
        backButton.tap()
    }
}
