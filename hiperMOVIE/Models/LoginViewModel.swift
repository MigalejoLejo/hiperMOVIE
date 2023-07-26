//
//  LoginViewModel.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username:String = ""
    @Published var password:String = ""
    @Published var error:ErrorResponse? = nil
    @Published var isLogging:Bool = false
    
    
    func login(onCompletion: @escaping ()->Void){
        isLogging = true
        
        UserService.sharedInstance.authenticate(username: username, password: password, errorCallback:{ errorResponse in 
            self.error = errorResponse
            self.isLogging = false
            onCompletion()

        }, successCallback: {
            self.isLogging = false
            onCompletion()            
        })
        
        
    }
    
    func validate() -> Bool{
        return !username.isEmpty && !password.isEmpty
    } 
}
