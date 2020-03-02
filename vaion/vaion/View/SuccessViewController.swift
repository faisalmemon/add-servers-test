//
//  SuccessViewController.swift
//  vaion
//
//  Created by Faisal Memon on 02/03/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var viewModel: SuccessViewModel!
    var addServerViewModel: AddServerViewModel!
    
    @IBOutlet weak var successDetailLabelOutlet: UILabel!
    
    @IBAction func okButtonWasPressedAction(_ sender: Any) {
        viewModel.okButtonWasPressed()
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = SuccessViewModel(callbackHandler: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = SuccessViewModel(callbackHandler: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(addServerViewModel != nil, "Segue to this controller should have setup the ServerViewModel")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didAppear()
    }
}

extension SuccessViewController: SuccessProtocol {
    func getAddServerViewModel() -> AddServerViewModel {
        return addServerViewModel
    }

    func successLabel(updateWith text: String) {
        successDetailLabelOutlet.text = text
    }

    func goToWelcomeScreen() {
        self.dismiss(animated: true) {
            // TODO need to cancel the workflow
        }
    }
}
