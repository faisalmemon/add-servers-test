//
//  WelcomeViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

protocol WelcomeProtocol {
    func commenceAddServerWorkflow()
}

class WelcomeViewModel {
    
    // MARK: - State
    
    let callback: WelcomeProtocol
    var hasStartedAddServerWorkflow = false
    
    // MARK:- API
    
    init(callbackHandler: WelcomeProtocol) {
           callback = callbackHandler
       }
    
    func addServerToClusterWasPressed() {
        if !hasStartedAddServerWorkflow {
            hasStartedAddServerWorkflow = true
            callback.commenceAddServerWorkflow()
        }
    }
    
    func didFinishAddServerWorkflow() {
        hasStartedAddServerWorkflow = false
    }
}
