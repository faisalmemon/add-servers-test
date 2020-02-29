//
//  AddServerViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

class AddServerViewModel {
    
    var ipAddress: String?
    
    var gotoServerCredentialsScreen: (() -> Void)?
    var gotoSuccessScreen: (() -> Void)?

    
    func ipAddressString(updatedWith ipAddressString: String?) {
        ipAddress = ipAddressString
    }
    
    func nextButtonWasPressed() {

    }
}
