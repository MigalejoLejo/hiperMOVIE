//
//  ApiService.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation
import Alamofire


final class ApiService {
    static let api_key = Env.api_key
    static let base_url = Env.base_url

    
    static func get <T:Codable> (endpoint:String, parameters: [String: Any] = [:], callback:@escaping (T) -> Void){
        var params = parameters
        params["api_key"] = api_key
        
        AF.request(base_url+endpoint, method: .get, parameters: params).responseDecodable(of:T.self, queue: .main){ result in
            if let error = result.error {
                print("error calling api get")
                print(error.localizedDescription)
                print(result)
                return
            }
            
            if let value = result.value {
                callback(value)
                
            } else {
                print("get request on ApiService didn't return a value.")
            }
        }
    }
    
    static func post <T:Codable, Body:Encodable>(endpoint:String, withSessionID:Bool, body: Body? , callback: @escaping (T)-> Void, errorCallback: ((ErrorResponse?) -> Void)? = nil) {
        let headers: HTTPHeaders = [
          "content-type": "application/json"
        ]
        
        let path:String = withSessionID
            ? "\(base_url)\(endpoint)?api_key=\(api_key)&session_id=\(UserService.sharedInstance.sessionID ?? "")"
            : "\(base_url)\(endpoint)?api_key=\(api_key)"
        
//        print(path)
        
        AF.request(path, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of:T.self, queue: .main){
            result in
            if let error = result.error {
                print("at post: " + error.localizedDescription)
                print(error)
                if let data = result.data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    errorCallback?(errorResponse)
                    return
                }
            }
            
        
            if let value = result.value {
                callback(value)
            } else {
                //TODO: remove print
                print("get request on ApiService didn't return a value.")
            }
        }
    }
    
    static func delete<T:Codable, Body:Encodable>(endpoint:String, body: Body? , callback: @escaping (T)-> Void){
        let headers: HTTPHeaders = [
          "content-type": "application/json"
        ]
      
        
        AF.request("\(base_url)\(endpoint)?api_key=\(api_key)", method: .delete, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of:T.self, queue: .main){
            result in
           
            if let error = result.error {
                print("On Delete: " + error.localizedDescription)
                print("Details: ")
                print(result)
                return
            }
            
        
            if let value = result.value {
                callback(value)
            } else {
                print("get request on ApiService didn't return a value.")
            }
        }
    }
    
}
