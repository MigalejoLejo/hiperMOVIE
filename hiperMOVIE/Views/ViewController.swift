//
//  ViewController.swift
//  hiperMOVIE
//
//  Created by Miguel Alejandro Correa Avila on 12/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    var userService: UserService = .sharedInstance
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userService.isLoggedIn {
            if let vc = storyboard?.instantiateViewController(identifier: "MainView") as? MainView{
                navigationController?.pushViewController(vc, animated: false)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(identifier: "Login") as? Login{
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}
