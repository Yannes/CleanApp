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


public final class SignUpViewController:UIViewController, StoryBoarderded {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTExtField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var confirmarSenhaTextField: UITextField!
    
    
   public  var signUp: ((SignUpViewModel)-> Void)?
    
   public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        saveButton?.layer.cornerRadius = 5
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyBoardOnTap()
    }
    

    
    @objc private func saveButtonTapped(){
        let viewModel = SignUpViewModel(name: nameTextField.text, email: emailTExtField.text, password: senhaTextField.text, passwordConfirm: confirmarSenhaTextField.text)
        signUp?(viewModel)
    }
    
    
}


extension SignUpViewController: LoadingView{
  public  func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
            
        }else{
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}



extension SignUpViewController: AlertView{
  public  func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
