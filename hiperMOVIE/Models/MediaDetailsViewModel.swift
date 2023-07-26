//
//  MediaDetailsViewViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import Foundation
import CodableX


class MediaDetailsViewModel: ObservableObject {
   
    var id: Int
    var type: ResultType
    
    var endpoint:String = ""
    
    @Published var mediaDetails: MediaDetails? = nil
    @Published var isFavorite: Bool = false
    
    init(id: Int, type: ResultType) {
        self.id = id
        self.type = type
        loadDetails()
    }
    
    func loadDetails(){
        var params: [String:Any] = [:]
        endpoint = "\(type)/\(id)"
        
        params = [
            "append_to_response": "similar,recommendations,credits,videos,account_states",
            "language":UserService.sharedInstance.appLanguage,
            "session_id":UserService.sharedInstance.sessionID ?? ""
        ]
        
        
        if type == .movie {
            ApiService.get(endpoint: endpoint, parameters: params){ (mediaDetails: MovieDetails) in
                
                self.mediaDetails = mediaDetails
                self.isFavorite = mediaDetails.details.accountState.favorite ?? false

            }
        }
        
        if type == .tv{
            ApiService.get(endpoint: endpoint, parameters: params){ (mediaDetails: TVDetails) in
                self.mediaDetails = mediaDetails
                self.isFavorite = mediaDetails.details.accountState.favorite ?? false

            }
        }
        
        guard let details = mediaDetails else {return}
        
        self.mediaDetails = details
    }
    
    
    
    func checkState()->Bool{
        return mediaDetails?.details.accountState.favorite ?? false
    }
    
    func remove (errorCallback: ((ErrorResponse?)->Void)? = nil, successCallback: (()->Void)? = nil){
        let body: FavoriteState = .init(media_type: type.rawValue, media_id: id, favorite: false)
        let path: String = "account/\(UserService.sharedInstance.accountID ?? "")/favorite"
        print(body)
        
        ApiService.post(endpoint: path, withSessionID: true, body: body, callback: { (response:Response) in
            if response.success {
                self.isFavorite = false
            }
        }, errorCallback: errorCallback)
        
      
    }
    
    func add (errorCallback: ((ErrorResponse?)->Void)? = nil, successCallback: (()->Void)? = nil){
        let body: FavoriteState = .init(media_type: type.rawValue, media_id: id, favorite: true)
        let path: String = "account/\(UserService.sharedInstance.accountID ?? "")/favorite"
        print(body)
        
        ApiService.post(endpoint: path, withSessionID: true, body: body, callback: { (response:Response) in
            if response.success {
                self.isFavorite = true

            }
        }, errorCallback: errorCallback)
        
    }
}
