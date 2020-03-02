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
    // The reference networking library has it at 192.268.0.11 but 268 is
    // invalid so we've corrected that typo to make it 192.168.0.11
    static let requireCredentialsServer = "192.168.0.11"
    static let unknownServer = "1.2.3.4"
    static let networkServerShortestResponseTimeSeconds = 1.0
    static let unknownUser = "unknownUser"
    static let badPassword = "badPassword"
    static let correctUsername = "vaion"
    static let correctPassword = "password"
}
