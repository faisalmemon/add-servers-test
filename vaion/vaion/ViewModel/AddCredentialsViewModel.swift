//
//  AddCredentialsViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

protocol AddCredentialsProtocol {
    func gotoSuccessScreen()
    func reportError(message: String)
    func spinner(show: Bool)
    func getAddServerViewModel() -> AddServerViewModel
}

class AddCredentialsViewModel {
    
    // MARK: - State
    
    let callback: AddCredentialsProtocol
    
    var username = ""
    var password = ""
    var requestInProgress = false
    var shouldShowSpinner = false
    var delayTimeoutSecond: TimeInterval = 1

    //MARK: - Internal Logic
    
    func showSpinner() {
        if shouldShowSpinner {
            callback.spinner(show: true)
        }
    }
    
    func hideSpinner() {
        if !shouldShowSpinner {
            callback.spinner(show: false)
        }
    }
    
    func handleServerResponse(_ response: NetworkingResponse, completionHandler: @escaping ()-> Void = {}) {
        requestInProgress = false
        shouldShowSpinner = false
        hideSpinner()
        
        if response.success {
            callback.gotoSuccessScreen()
        } else if response.code == 401 {
            // we've already supplied credentials so fallback to it being
            // an error
            callback.reportError(message: response.message)
        } else {
            // maybe hide the details of the error if it is a
            // security concern
            callback.reportError(message: response.message)
        }
        completionHandler()
    }
    
    //MARK: - API
    
    init(callbackHandler: AddCredentialsProtocol) {
        callback = callbackHandler
    }
    
    func username(updatedWith usernameString: String?) {
        username = usernameString ?? ""
    }
    
    func password(updatedWith passwordString: String?) {
        password = passwordString ?? ""
    }
    
    func nextButtonWasPressed(completionHandler: @escaping ()-> Void = {}) {
        if requestInProgress {
            return
        }
        requestInProgress = true
        shouldShowSpinner = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTimeoutSecond) {
            self.showSpinner()
        }
        DispatchQueue.global().async {
            let ipAddress = self.callback.getAddServerViewModel().ipAddress
            let credentials = Credentials(username: self.username, password: self.password)
            Networking.sharedInstance.connectToServer(ipAddress: ipAddress, credentials: credentials) { (response) in
                DispatchQueue.main.async {
                    self.handleServerResponse(response, completionHandler: completionHandler)
                }
            }
        }
    }
    
    func errorWasAcknowledged() {
    }
}
