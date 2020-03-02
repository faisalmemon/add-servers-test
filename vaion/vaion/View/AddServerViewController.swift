//
//  AddServerViewController.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class AddServerViewController: UIViewController {
    
    var viewModel: AddServerViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = AddServerViewModel(callbackHandler: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = AddServerViewModel(callbackHandler: self)
    }
    
    @IBOutlet weak var ipAddressTextFieldOutlet: UITextField!
    
    var spinner: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ipAddressTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        viewModel.ipAddressString(updatedWith: ipAddressTextFieldOutlet.text)
    }
    
    @IBAction func nextButtonWasPressedAction(_ sender: Any) {
        viewModel.nextButtonWasPressed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addCredentialsViewController = segue.destination as? AddCredentialsViewController {
            addCredentialsViewController.addServerViewModel = viewModel
        }
        if let successViewController = segue.destination as? SuccessViewController {
            successViewController.addServerViewModel = viewModel
        }
    }
    
    
}

extension AddServerViewController: AddServerProtocol {
    
    func gotoServerCredentialsScreen() {
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
    
    func spinner(show: Bool) {
        if show {
            spinner = UIActivityIndicatorView(style: .large)
            self.view.addSubview(spinner!)
            spinner?.center = self.view.center
            spinner?.startAnimating()
        } else {
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
}
