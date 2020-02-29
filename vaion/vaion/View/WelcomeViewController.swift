//
//  ViewController.swift
//  vaion
//
//  Created by Faisal Memon on 29/02/2020.
//  Copyright © 2020 Faisal Memon. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var viewModel: WelcomeViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = WelcomeViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = WelcomeViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.commenceAddServerWorkflow = {
            self.gotoAddServerScreen()
        }
    }

    @IBAction func addServerToClusterAction(_ sender: Any) {
        viewModel.addServerToClusterWasPressed()
    }
    
    // MARK: Callback Handlers
    
    func gotoAddServerScreen() {
        performSegue(withIdentifier: "addServerSegue", sender: self)
    }
    
    
    
    
}

