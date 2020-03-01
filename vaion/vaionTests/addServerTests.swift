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
    
    func gotoServerCredentialsScreen() {
        wentToCredentialsScreen = true
    }
    
    func gotoSuccessScreen() {
        wentToSuccessScreen = true
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
