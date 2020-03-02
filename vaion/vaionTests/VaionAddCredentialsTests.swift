//
//  VaionAddCredentialsTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

class AddCredentialsMock: AddCredentialsProtocol, AddServerProtocol {

    var wentToSuccessScreen = false
    var wentToCredentialsScreen = false
    var wentToReportError = false
    var showingSpinner = false
    var showedSpinnerAtLeastOnce = false
    var numberOfTimesAtSuccessScreen = 0
    
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
    
    func gotoServerCredentialsScreen() {
        wentToCredentialsScreen = true
    }
    
    func getAddServerViewModel() -> AddServerViewModel {
        let addServerViewModel = AddServerViewModel(callbackHandler: self)
        addServerViewModel.ipAddressString(updatedWith: TestData.requireCredentialsServer)
        return addServerViewModel
    }
}

class VaionAddCredentialsTests: XCTestCase {

    
    func testNextButtonWhenUserUnknown() {
        let mock = AddCredentialsMock()
        let viewModel = AddCredentialsViewModel(callbackHandler: mock)
        viewModel.username(updatedWith: TestData.unknownUser)
        
        viewModel.nextButtonWasPressed {
            if mock.wentToReportError && !mock.wentToSuccessScreen && !mock.wentToCredentialsScreen {
                // good path
            } else {
                XCTFail("Did not go to the error screen")
            }
        }
    }
    
    func testNextButtonWhenPasswordUnknown() {
        let mock = AddCredentialsMock()
        let viewModel = AddCredentialsViewModel(callbackHandler: mock)
        viewModel.password(updatedWith: TestData.badPassword)
        
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
