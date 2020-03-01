//
//  ViewController.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var viewModel: WelcomeViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = WelcomeViewModel(callbackHandler: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = WelcomeViewModel(callbackHandler: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addServerToClusterAction(_ sender: Any) {
        viewModel.addServerToClusterWasPressed()
    }
}

extension WelcomeViewController: WelcomeProtocol {
    func commenceAddServerWorkflow() {
        performSegue(withIdentifier: "addServerSegue", sender: self)
    }
}

