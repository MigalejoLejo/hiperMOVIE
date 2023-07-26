//
//  ViewController.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 11/7/23.
//

import UIKit

class Login: UIViewController {
    
    var loginViewModel = LoginViewModel()
    var userService: UserService = .sharedInstance
    
    var isLoggedIn: Bool {
        userService.isLoggedIn
    }

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        logginButton.isEnabled = false
        navigationItem.hidesBackButton = true

        if userService.hasSessionID {
            navigateToMain()
        }
    }
    
    @IBAction func checkInput(_ sender: UITextField) {
        if (username.text == "") || (password.text == "") {
            logginButton.isEnabled = false
        } else {
            logginButton.isEnabled = true
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        loginViewModel.username = username.text ?? ""
        loginViewModel.password = password.text ?? ""
        loginViewModel.login{ [weak self] in
            guard let self = self else {return}
            if self.userService.hasSessionID {
                self.navigateToMain()
            }
        }
    }
    
    func navigateToMain(){
        if let vc = self.storyboard?.instantiateViewController(identifier: "MainView") as? MainView{
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

