//
//  Extensions.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(withTitle title: String, message : String, actions : [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {

            let action = UIAlertAction(title: action.key, style: action.value) { action in

                if completionHandler != nil {
                    completionHandler!(action)
                }
            }

            alertController.addAction(action)
        }

        self.present(alertController, animated: true, completion: nil)
    }
}
