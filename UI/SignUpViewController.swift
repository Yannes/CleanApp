//
//  SignUpViewController.swift
//  UI
//
//  Created by Yannes Meneguelli on 17/04/20.
//  Copyright © 2020 Yannes Meneguelli. All rights reserved.
//

import Foundation
import UIKit
import PresentationLayer


final class SignUpViewController:UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


extension SignUpViewController: LoadingView{
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        }else{
            loadingIndicator.stopAnimating()
        }
    }
}
