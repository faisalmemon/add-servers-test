//
//  AddServerViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

protocol AddServerProtocol {
    func gotoServerCredentialsScreen()
    func gotoSuccessScreen()
    func reportError(message: String)
    func spinner(show: Bool)
}

class AddServerViewModel {

    //MARK: - State
    
    var delayTimeoutSecond: TimeInterval = 1
    var shouldShowSpinner = false
    var requestInProgress = false
    var ipAddress = ""
    let callback: AddServerProtocol

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
            callback.gotoServerCredentialsScreen()
        } else {
            // maybe hide the details of the error if it is a
            // security concern
            callback.reportError(message: response.message)
        }
        completionHandler()
    }
    
    //MARK: - API
    
    init(callbackHandler: AddServerProtocol) {
        callback = callbackHandler
    }

    func ipAddressString(updatedWith ipAddressString: String?) {
        ipAddress = ipAddressString ?? ""
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
            Networking.sharedInstance.connectToServer(ipAddress: self.ipAddress, credentials: nil) { (response) in
                DispatchQueue.main.async {
                    self.handleServerResponse(response, completionHandler: completionHandler)
                }
            }
        }
    }
    
    func errorWasAcknowledged() {
        
    }
}
