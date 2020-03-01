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
    static let unknownServer = "1.2.3.4"
    static let networkServerShortestResponseTimeSeconds = 1.0
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
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        viewModel.ipAddress = "placeholder"
        viewModel.ipAddressString(updatedWith: "1.2.3.4")
        XCTAssert(viewModel.ipAddress == "1.2.3.4")
    }
    
    func testSettingAbsentIpAddressIsEmptyString() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        viewModel.ipAddress = "placeholder"
        viewModel.ipAddressString(updatedWith: nil)
        XCTAssert(viewModel.ipAddress == "")
    }
    
    func testNextButtonWhenNoCredentialsRequired() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        
        viewModel.ipAddressString(updatedWith: TestData.noCredentialsServer)
        
        viewModel.nextButtonWasPressed {
            if mock.wentToSuccessScreen && !mock.wentToCredentialsScreen {
                // good path
            } else {
                XCTFail("Did not go to the success screen")
            }
        }
    }
    
    func testNextButtonWhenCredentialsAreRequired() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        
        viewModel.ipAddressString(updatedWith: TestData.requireCredentialsServer)
        
        viewModel.nextButtonWasPressed {
            if !mock.wentToSuccessScreen && mock.wentToCredentialsScreen {
                // good path
            } else {
                XCTFail("Did not go to the credentials screen")
            }
        }
    }
    
    func testNextButtonWhenServerUnknown() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        viewModel.ipAddressString(updatedWith: TestData.unknownServer)
        
        viewModel.nextButtonWasPressed {
            if mock.wentToReportError && !mock.wentToSuccessScreen && !mock.wentToCredentialsScreen {
                // good path
            } else {
                XCTFail("Did not go to the error screen")
            }
        }
    }
    
    func testNextButtonSpinnerAppears() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
                
        viewModel.delayTimeoutSecond = TestData.networkServerShortestResponseTimeSeconds / 10.0
        
        viewModel.ipAddressString(updatedWith: TestData.noCredentialsServer)
        
        viewModel.nextButtonWasPressed() {
            XCTAssert(mock.showedSpinnerAtLeastOnce)
        }
    }
}
