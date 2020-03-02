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

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func reachAddServerToCluster() {
        app.buttons["Add Server to Cluster"].tap()
    }
    func reachNextScreen() {
        app.staticTexts["Next"].tap()

    }
    func supplyServerAddress(_ address: String) {
        let textField = app.textFields["1.2.3.4"]
        textField.tap()
        textField.typeText(address)
    }
    
    func supplyUsername(_ username: String) {
        let usernameField = app.textFields["User name"]
        XCTAssert(usernameField.waitForExistence(timeout: 5))
        usernameField.tap()
        usernameField.typeText(username)
    }
    
    func supplyPassword(_ password: String) {
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText(password)
    }
    
    func testAddServer() {
        reachAddServerToCluster()
    }
    
    func testAddCredentials() {
        reachAddServerToCluster()
        supplyServerAddress(TestData.requireCredentialsServer)
        reachNextScreen()
        supplyUsername(TestData.correctUsername)
        supplyPassword(TestData.correctPassword)
        reachNextScreen()
    }
    
    func testAddServerWithoutCredentials() {
        reachAddServerToCluster()
        supplyServerAddress(TestData.noCredentialsServer)
        reachNextScreen()
        // TODO check that the success server ip address is correct when
        // implemented
        let successTitle = app.staticTexts["Success"]
        XCTAssert(successTitle.waitForExistence(timeout: 5))
    }

}
