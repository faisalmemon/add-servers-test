//
//  vaionTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

struct TestData {
    // The documentation is incorrect in that it says the server is at
    // 192.168.1.10 but actually it is at 192.168.0.10
    static let noCredentialsServer = "192.168.0.10"
    // The documentation is incorrect in that it says the server is at
    // 192.168.1.11 but actually it is at 192.168.0.11
    static let requireCredentialsServer = "192.268.0.11"
}
class vaionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommenceAddServerThenStop() {
        var commenceCounter = 0
        
        let viewModel = WelcomeViewModel()
        viewModel.commenceAddServerWorkflow = {
            commenceCounter += 1
        }
        viewModel.addServerToClusterWasPressed()
        XCTAssert(viewModel.hasStartedAddServerWorkflow && commenceCounter == 1)
        viewModel.didFinishAddServerWorkflow()
        XCTAssert(!viewModel.hasStartedAddServerWorkflow && commenceCounter == 1)
    }
    
    func testCommenceAddServerDoesNotDoubleCommence() {
        var commenceCounter = 0
        
        let viewModel = WelcomeViewModel()
        viewModel.commenceAddServerWorkflow = {
            commenceCounter += 1
        }
        viewModel.addServerToClusterWasPressed()
        viewModel.addServerToClusterWasPressed()
        XCTAssert(viewModel.hasStartedAddServerWorkflow && commenceCounter == 1)
    }
    
    func testSettingIpAddress() {
        let viewModel = AddServerViewModel()
        viewModel.ipAddress = "placeholder"
        viewModel.ipAddressString(updatedWith: "1.2.3.4")
        XCTAssert(viewModel.ipAddress == "1.2.3.4")
    }
    
    func testSettingAbsentIpAddressIsEmptyString() {
        let viewModel = AddServerViewModel()
        viewModel.ipAddress = "placeholder"
        viewModel.ipAddressString(updatedWith: nil)
        XCTAssert(viewModel.ipAddress == "")
    }
    
    func testNextButtonWhenNoCredentialsRequired() {
        let viewModel = AddServerViewModel()
        var wentToSuccessScreen = false
        var wentToCredentialsScreen = false
        
        viewModel.gotoSuccessScreen = {
            wentToSuccessScreen = true
        }
        viewModel.gotoServerCredentialsScreen = {
            wentToCredentialsScreen = true
        }
        
        viewModel.ipAddressString(updatedWith: TestData.noCredentialsServer)
        
        let expectation = XCTestExpectation(description: "Login without credentials")

        viewModel.nextButtonWasPressed {
            if wentToSuccessScreen && !wentToCredentialsScreen {
            expectation.fulfill()
            } else {
                XCTFail("Did not go to the success screen")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNextButtonWhenCredentialsAreRequired() {
        let viewModel = AddServerViewModel()
        var wentToSuccessScreen = false
        var wentToCredentialsScreen = false
        
        viewModel.gotoSuccessScreen = {
            wentToSuccessScreen = true
        }
        viewModel.gotoServerCredentialsScreen = {
            wentToCredentialsScreen = true
        }
        
        viewModel.ipAddressString(updatedWith: TestData.requireCredentialsServer)
        
        let expectation = XCTestExpectation(description: "Login with credentials")

        viewModel.nextButtonWasPressed {
            if !wentToSuccessScreen && wentToCredentialsScreen {
            expectation.fulfill()
            } else {
                XCTFail("Did not go to the credentials screen")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
