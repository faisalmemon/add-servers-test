//
//  WelcomeViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

class WelcomeViewModel {
    
    var hasStartedAddServerWorkflow = false
    var commenceAddServerWorkflow: (() -> Void)?
    
    func addServerToClusterWasPressed() {
        
        if hasStartedAddServerWorkflow {
            return
        }
        if let startWorkflow = commenceAddServerWorkflow {
            hasStartedAddServerWorkflow = true
            startWorkflow()
        }
    }
    
    func didFinishAddServerWorkflow() {
        hasStartedAddServerWorkflow = false
    }
}
