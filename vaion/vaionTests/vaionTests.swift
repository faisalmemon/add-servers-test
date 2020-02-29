//
//  vaionTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

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
}
