//
//  UserService.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation
import KeychainAccess

class UserService: ObservableObject {
   
    static var sharedInstance: UserService = .init()
    private var storage: Keychain = .init(service: "com.miguelcorrea.Movie")
    
    @Published var sessionID: String? = nil
    @Published var isLoggedIn: Bool = false
    @Published var account: Account? = nil
    @Published var accountID: String? = nil
    @Published var updateFavorites: Bool = false
    @Published var appLanguage = Locale.current.language.languageCode?.identifier ?? "en"

    
    
    
    public var hasSessionID: Bool {
        guard let _ = try? storage.get("session_id") else {
            return false
        }
        return true
    }
    
    public var hasAccountID: Bool {
        guard let _ = try? storage.get("account_id") else {
            return false
        }
        return true
    }
  
    
    init() {
        loadSession()
        isLoggedIn = hasSessionID
//        print(sessionID ?? "no session id")
//        print(accountID ?? "no account id")
    }
    
    func loadAccount () {
        let path  = "account?session_id=\(UserService.sharedInstance.sessionID ?? "")"
        ApiService.get(endpoint: path){ (account:Account) in
            do {
                try self.storage.set(account.id.description, key: "account_id")
//                successCallback?()
            } catch (let error){
                print("On creating new session: " + error.localizedDescription)
            }
            self.account = account
            print(account.id)
        }
        
    }
    
    func loadSession (){
        if let storageSessionID = try? storage.get("session_id") {
            sessionID = storageSessionID
            isLoggedIn = hasSessionID
        } else {
            sessionID = nil
            isLoggedIn = hasSessionID

        }
        
        if let storageAccountID = try? storage.get("account_id") {
            accountID = storageAccountID
        } else {
            accountID = nil
        }
        
    }
    
    
    
    func authenticate (username: String, password: String, errorCallback: ((ErrorResponse?)->Void)? = nil, successCallback: (()->Void)? = nil){
        newToken{ token in
            let credentials: UserCredentials = .init(username: username, password: password, requestToken: token.requestToken)
            ApiService.post(endpoint: "authentication/token/validate_with_login", withSessionID: false, body: credentials, callback: { (responseToken:Token) in
                if token.success {
                    self.newSession(requestToken: responseToken.requestToken , errorCallback: errorCallback, successCallback: successCallback)
                }
            }, errorCallback: errorCallback)
        }
    }
     
    private func newToken (done: @escaping (Token)-> Void){
        ApiService.get(endpoint: "authentication/token/new") { (token:Token) in
            if token.success {
                done(token)
            }
        }
    }
    
    
    
    func newSession (requestToken:String, errorCallback: ((ErrorResponse?)->Void)?, successCallback: (()->Void)? = nil){
        let credentials: TokenCredential = .init(requestToken: requestToken)
        ApiService.post(endpoint: "authentication/session/new", withSessionID: false, body: credentials, callback: { (session:Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionID, key: "session_id")
                    self.loadSession()
                    self.loadAccount()
                    successCallback?()
                } catch (let error){
                    print("On creating new session: " + error.localizedDescription)
                }
            }
        }, errorCallback: errorCallback)
    }
    
    
    
    func unauthenticate (){
        loadSession()
        let credentials: SessionCredential = .init(sessionID:sessionID ?? "")
        ApiService.delete(endpoint: "authentication/session", body: credentials, callback: { (result:LogoutResponse) in
            if  result.success {
                do {
                    try self.storage.remove("session_id")
                    self.loadSession()
                } catch (let error){
                    print("On unauthentication: " + error.localizedDescription)
                }
            }
        })
    }
    
    
    func setLanguage (language: Language) {
        switch language {
        case .de: appLanguage = "de"
        case .en:  appLanguage  = "en"
        case .es:  appLanguage = "es"
        case .systemDefault:  appLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        }
    }
    
    
    func getLanguage () -> String {
        let systemLang = appLanguage
        switch systemLang {
            case "en": return "en-US"
            case "es": return "es-ES"
            case "de": return "de-DE"
            default: return "en-US"
        }
    }
}


