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
}
