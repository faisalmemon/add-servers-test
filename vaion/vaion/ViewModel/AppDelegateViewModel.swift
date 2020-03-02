//
//  AppDelegateViewModel.swift
//  vaion
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateProtocol {
    func getActiveInputModes() -> [UITextInputMode]
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
        #if targetEnvironment(simulator)
        let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")  // private method but not used in production hardware environments
        callback.getActiveInputModes()
        .filter({ $0.responds(to: setHardwareLayout) })
        .forEach { $0.perform(setHardwareLayout, with: nil) }
        #endif
    }
}
