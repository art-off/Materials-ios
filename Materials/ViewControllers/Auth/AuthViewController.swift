//
//  AuthViewController.swift
//  Materials
//
//  Created by art-off on 26.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiels: UITextField!
    
    // MARK: Animating
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.backgroupd
    }
    
    
    // MARK: - Actions
    @IBAction func onSingInTapped(_ sender: Any) {
        guard let emailText = emailTextField.text,
            let passwordText = passwordTextFiels.text else { return }
        
        guard !emailText.isEmpty, !emailText.isEmpty else { return }
        
        DispatchQueue.main.async {
            self.startActivityIndicator()
        }
        ApiManager.authUser(withEmail: emailText, password: passwordText) { user, isWrongLoginOrPassword in
            if isWrongLoginOrPassword {
                DispatchQueue.main.async {
                    self.showAlert(withText: "Неверный логин или пароль")
                    self.passwordTextFiels.text = ""
                    self.stopActivityIndicator()
                }
                return
            }
            
            guard let user = user else { return }
            DispatchQueue.main.async {
                UserHelpers.authUser(user: user)
                self.stopActivityIndicator()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
            }
        }
    }
}


extension AuthViewController: AnimatingNetworkViewController {
    
    func animatingSuperViewForDisplay() -> UIView {
        return view
    }
    
    func animatingViewForDisableUserInteraction() -> UIView {
        return view
    }
    
    func animatingActivityIndicatorView() -> ActivityIndicatorView {
        return activityIndicatorView
    }
    
    func animatingAlertView() -> AlertView {
        return alertView
    }
    
}
