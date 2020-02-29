//
//  AddServerViewController.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class AddServerViewController: UIViewController {
    
    var viewModel: AddServerViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = AddServerViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = AddServerViewModel()
        super.init(coder: coder)
    }

    @IBOutlet weak var ipAddressTextFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ipAddressTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        viewModel.gotoSuccessScreen = {
            self.gotoSuccessScreen()
        }
        
        viewModel.gotoServerCredentialsScreen = {
            self.gotoAddCredentialsScreen()
        }
        
        viewModel.reportError = { (message) in
            self.reportError(message: message)
        }
    }
    
    @objc func textFieldDidChange() {
        viewModel.ipAddressString(updatedWith: ipAddressTextFieldOutlet.text)
    }
    
    @IBAction func nextButtonWasPressedAction(_ sender: Any) {
        viewModel.nextButtonWasPressed()
    }
    
    // MARK: Callback Handlers
    
    func gotoAddCredentialsScreen() {
        performSegue(withIdentifier: "toServerCredentials", sender: self)
    }
    
    func gotoSuccessScreen() {
        performSegue(withIdentifier: "toSuccessScreenFromAddServerScreen", sender: self)
    }
    
    func reportError(message: String) {
        presentAlert(withTitle: NSLocalizedString("Server Error", comment: ""), message: message, actions: [
            NSLocalizedString("OK", comment: "") : .default], completionHandler: {(action) in

                if action.title == NSLocalizedString("OK", comment: "") {
                    self.viewModel.errorWasAcknowledged()
                }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
