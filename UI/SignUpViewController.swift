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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTExtField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var confirmarSenhaTextField: UITextField!
    
    
    var signUp: ((SignUpViewModel)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func saveButtonTapped(){
        let viewModel = SignUpViewModel(name: nameTextField.text, email: emailTExtField.text, password: senhaTextField.text, passwordConfirm: confirmarSenhaTextField.text)
        signUp?(viewModel)
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



extension SignUpViewController: AlertView{
    func showMessage(viewModel: AlertViewModel) {
    }
}
