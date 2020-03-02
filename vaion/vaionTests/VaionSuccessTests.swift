//
//  VaionSuccessTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 02/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

class SuccessMock: SuccessProtocol {
    
    let welcomeViewModel: WelcomeViewModel
    let addServerViewModel: AddServerViewModel
    var successDetailLabel = ""
    var didPerformDismiss = false
    
    init(welcomeViewModel welcome: WelcomeViewModel, addServerViewModel addServer: AddServerViewModel) {
        welcomeViewModel = welcome
        addServerViewModel = addServer
    }
    
    func getAddServerViewModel() -> AddServerViewModel {
        return addServerViewModel
    }
    
    func getWelcomeViewModel() -> WelcomeViewModel {
        return welcomeViewModel
    }
    
    func successLabel(updateWith text: String) {
        successDetailLabel = text
    }
    
    func performDismiss() {
        didPerformDismiss = true
        welcomeViewModel.didFinishAddServerWorkflow()
    }
}



class VaionSuccessTests: XCTestCase {
    
    func testPressingOkButtonCompletesTheWorkflow() {
        let welcomeMock = WelcomeMock()
        let welcomeViewModel = WelcomeViewModel(callbackHandler: welcomeMock)
        let addServerMock = AddServerMock()
        let addServerViewModel = AddServerViewModel(callbackHandler: addServerMock)
        let successMock = SuccessMock(welcomeViewModel: welcomeViewModel,
                                      addServerViewModel: addServerViewModel)
        let successViewModel = SuccessViewModel(callbackHandler: successMock)
        
        welcomeViewModel.addServerToClusterWasPressed()
        XCTAssert(welcomeViewModel.hasStartedAddServerWorkflow)

        successViewModel.okButtonWasPressed()
        XCTAssertFalse(welcomeViewModel.hasStartedAddServerWorkflow)
    }
}
