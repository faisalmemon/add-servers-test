//
//  welcomeTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

class WelcomeMock: WelcomeProtocol {
    var commenceCounter = 0
    
    func commenceAddServerWorkflow() {
        commenceCounter += 1
    }
}

class vaionWelcomeTests: XCTestCase {
    
    func testCommenceAddServerThenStop() {
        let mock = WelcomeMock()
        let viewModel = WelcomeViewModel(callbackHandler: mock)
        viewModel.addServerToClusterWasPressed()
        XCTAssert(viewModel.hasStartedAddServerWorkflow && mock.commenceCounter == 1)
        viewModel.didFinishAddServerWorkflow()
        XCTAssert(!viewModel.hasStartedAddServerWorkflow && mock.commenceCounter == 1)
    }
    
    func testCommenceAddServerDoesNotDoubleCommence() {
        let mock = WelcomeMock()
        let viewModel = WelcomeViewModel(callbackHandler: mock)
        viewModel.addServerToClusterWasPressed()
        viewModel.addServerToClusterWasPressed()
        XCTAssert(viewModel.hasStartedAddServerWorkflow && mock.commenceCounter == 1)
    }
}
