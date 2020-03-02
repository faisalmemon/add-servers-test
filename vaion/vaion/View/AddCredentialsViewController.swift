//
//  AddCredentialsViewController.swift
//  vaion
//
//  Created by Faisal Memon on 01/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class AddCredentialsViewController: UIViewController {
    
    var viewModel: AddCredentialsViewModel!
    var addServerViewModel: AddServerViewModel!
    var welcomeViewModel: WelcomeViewModel!
    
    var spinner: UIActivityIndicatorView?

    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    
    @IBAction func nextButtonAction(_ sender: Any) {
        viewModel.nextButtonWasPressed()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = AddCredentialsViewModel(callbackHandler: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = AddCredentialsViewModel(callbackHandler: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        passwordTextFieldOutlet.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        assert(addServerViewModel != nil, "Segue to this controller should have setup the ServerViewModel")
        assert(welcomeViewModel != nil, "Segue to this controller should have setup the ServerViewModel")
    }
    
    @objc func textFieldDidChange(sender: Any) {
        guard let textField = sender as? UITextField else {
            assertionFailure("Tried to handle text change on non-UITextField type")
            return
        }
        if textField == usernameTextFieldOutlet {
            viewModel.username(updatedWith: textField.text)
        } else if textField == passwordTextFieldOutlet {
            viewModel.password(updatedWith: textField.text)
        } else {
            assertionFailure("Missing text field case")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let successViewController = segue.destination as? SuccessViewController {
            successViewController.addServerViewModel = addServerViewModel
            successViewController.welcomeViewModel = welcomeViewModel
        }
    }

}

extension AddCredentialsViewController: AddCredentialsProtocol {
    
    func gotoSuccessScreen() {
        performSegue(withIdentifier: "toSuccessScreen", sender: self)
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
    
    func getAddServerViewModel() -> AddServerViewModel {
        return addServerViewModel
    }
}
