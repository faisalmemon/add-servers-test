//
//  AddServerViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

class AddServerViewModel {
    
    //MARK: - State
    
    var delayTimeoutSecond: TimeInterval = 5
    var shouldShowSpinner = false
    var ipAddress = ""
    
    //MARK: - User Interface Callbacks

    var gotoServerCredentialsScreen: (() -> Void)?
    var gotoSuccessScreen: (() -> Void)?
    var reportError: ((String) -> Void)?
    var setSpinnerCallback:((Bool) -> Void)?

    //MARK: - Internal Logic
    
    func showSpinner() {
        if shouldShowSpinner {
            if let spinner = setSpinnerCallback {
                spinner(true)
            }
        }
    }
    
    func hideSpinner() {
        if !shouldShowSpinner {
            if let spinner = setSpinnerCallback {
                spinner(false)
            }
        }
    }
    
    func handleServerResponse(_ response: NetworkingResponse) {
        self.shouldShowSpinner = false
        self.hideSpinner()
        
        if response.success {
            if let successScreen = self.gotoSuccessScreen {
                successScreen()
            }
        } else if response.code == 401 {
            if let credentialsScreen = self.gotoServerCredentialsScreen {
                credentialsScreen()
            }
        } else {
            if let doErrorReport = self.reportError {
                /*
                 Don't leak details of error to user in case of a malicous user was attempting
                 to crack the login.
                 */
                doErrorReport(NSLocalizedString("Server error", comment: ""))
            }
        }
    }
    
    //MARK: - API

    func ipAddressString(updatedWith ipAddressString: String?) {
        ipAddress = ipAddressString ?? ""
    }
    
    func nextButtonWasPressed() {
        shouldShowSpinner = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTimeoutSecond) {
            self.showSpinner()
        }
        DispatchQueue.global().async {
            Networking.sharedInstance.connectToServer(ipAddress: self.ipAddress, credentials: nil) { (response) in
                DispatchQueue.main.async {
                    self.handleServerResponse(response)
                }
            }
        }
    }
}
