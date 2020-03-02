//
//  VaionAppDelegateTests.swift
//  vaionTests
//
//  Created by Faisal Memon on 02/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import XCTest
@testable import vaion

class AppDelegateMock: AppDelegateProtocol {
    var didEnumerateInputModes = false
    
    func getActiveInputModes() -> [UITextInputMode] {
        didEnumerateInputModes = true
        return []
    }
}

class VaionAppDelegateTests: XCTestCase {

    func testAppDelegateDisablesHardwareKeyboardOnSimulator() {
        let mock = AppDelegateMock()
        let viewModel = AppDelegateViewModel(callbackHandler: mock)
        viewModel.didFinishLaunching()
        #if targetEnvironment(simulator)
        XCTAssert(mock.didEnumerateInputModes)
        #else
        XCTAssertFalse(mock.didEnumerateInputModes)
        #endif
    }

}
