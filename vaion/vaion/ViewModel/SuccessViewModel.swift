//
//  SuccessViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 02/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

protocol SuccessProtocol {
    func getAddServerViewModel() -> AddServerViewModel
    func successLabel(updateWith text: String)
    func goToWelcomeScreen()
}

class SuccessViewModel {
    let callback: SuccessProtocol
    
    //MARK: - API
    
    init(callbackHandler: SuccessProtocol) {
        callback = callbackHandler
    }
    
    func didAppear() {
        let serverIpAddress = callback.getAddServerViewModel().ipAddress
        
        let metaString = NSLocalizedString(
            "The server %@ was successfully added to the cluster.",
            comment: "The parameter is an IP address e.g. 1.2.3.4")

        let string = String.localizedStringWithFormat(metaString, serverIpAddress)
        callback.successLabel(updateWith: string)
    }
    
    func okButtonWasPressed() {
        callback.goToWelcomeScreen()
    }
}
