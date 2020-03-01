//
//  addServerTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

class AddServerMock: AddServerProtocol {
    var wentToSuccessScreen = false
    var wentToCredentialsScreen = false
    var wentToReportError = false
    var showingSpinner = false
    var showedSpinnerAtLeastOnce = false
    var numberOfTimesAtSuccessScreen = 0
    
    func gotoServerCredentialsScreen() {
        wentToCredentialsScreen = true
    }
    
    func gotoSuccessScreen() {
        wentToSuccessScreen = true
        numberOfTimesAtSuccessScreen += 1
    }
    
    func reportError(message: String) {
        wentToReportError = true
    }
    
    func spinner(show: Bool) {
        if show {
            showedSpinnerAtLeastOnce = true
        }
        showingSpinner = show
    }
}

class VaionAddServerTests: XCTestCase {
    
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
    
    func testNextButtonProcessedOnceOnlyWhenDoublePressed() {
        let mock = AddServerMock()
        let viewModel = AddServerViewModel(callbackHandler: mock)
        viewModel.ipAddressString(updatedWith: TestData.noCredentialsServer)
        viewModel.nextButtonWasPressed()
        viewModel.nextButtonWasPressed() {
            XCTAssert(mock.numberOfTimesAtSuccessScreen == 1)
        }
    }
}
