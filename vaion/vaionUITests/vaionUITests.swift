//
//  vaionUITests.swift
//  vaionUITests
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest

/// Peform UI Testing.  Requires simulator to not have a connected hardware keyboard.  This is ensured by `AppDelegateViewModel::disableHardwareKeyboardOnSimulator`
class vaionUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrivialProgramLaunch() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddServer() {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().buttons["Add Server to Cluster"].tap()
        
    }
    
    func testAddCredentials() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Add Server to Cluster"].tap()
        
        let textField = app.textFields["1.2.3.4"]
        textField.tap()
        textField.typeText("192.168.0.11")
        app.staticTexts["Next"].tap()

        let usernameField = app.textFields["User name"]
        XCTAssert(usernameField.waitForExistence(timeout: 5))

        usernameField.tap()
        usernameField.typeText("vaion")
        let mypasswordSecureTextField = app.secureTextFields["Password"]
        mypasswordSecureTextField.tap()
        mypasswordSecureTextField.typeText("password")
        app.staticTexts["Next"].tap()
    }

}
