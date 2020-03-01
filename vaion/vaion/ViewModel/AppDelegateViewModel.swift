//
//  AppDelegateViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation

protocol AppDelegateProtocol {
    func disableHardwareKeyboardOnSimulator()
}

class AppDelegateViewModel {
    
    let callback: AppDelegateProtocol
    
    init(callbackHandler: AppDelegateProtocol) {
        callback = callbackHandler
    }
    
    func didFinishLaunching() {
        /*
         Allow UI Testing we requires a software keyboard to allow interaction with
         certain TextFields.  Otherwise we'd get an element focus failure.
         */
        callback.disableHardwareKeyboardOnSimulator()
    }
}
