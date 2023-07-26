//
//  MediaDetailsViewViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import Foundation
import CodableX
import SwiftUI

class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteMovies:[Result] = []
    @Published var favoriteSeries:[Result] = []
    
    private var hasFinishedLoadingMovies = true
    private var hasFinishedLoadingSeries = true
    
    var hasFinishedLoading:Bool {
        return hasFinishedLoadingMovies && hasFinishedLoadingSeries
    }
    
    
    var account:Account? = nil
    var totalMoviePages = 0
    var totalTVPages = 0
    
    
    
    init(){
        getFavorites()
    }
    
    func getFavorites(){
        fetchFavoriteMovies(onCompletion: getMoreMovies)
        fetchFavoriteSeries(onCompletion: getMoreSeries)
    }
    
    func fetchFavoriteMovies(onCompletion: @escaping ()->Void) {
        if favoriteMovies.isEmpty {
            hasFinishedLoadingMovies = false
            
            let path = "account/\(UserService.sharedInstance.account?.id ?? 0)/favorite/movies"
            let params : [String:Any] = [
                "session_id":UserService.sharedInstance.sessionID ?? "",
                "language":UserService.sharedInstance.getLanguage()
            ]
            
            ApiService.get(endpoint: path, parameters: params){ (resultList:ResultList) in
                self.favoriteMovies.append(contentsOf: resultList.results)
                self.totalMoviePages = resultList.totalPages ?? 0
                self.hasFinishedLoadingMovies = true
                onCompletion()
            }
        }
    }
    
    func fetchFavoriteSeries(onCompletion: @escaping ()->Void) {
        if favoriteSeries.isEmpty {
            hasFinishedLoadingSeries = false
            
            let path = "account/\(UserService.sharedInstance.account?.id ?? 0)/favorite/tv"
            let params : [String:Any] = [
                "session_id":UserService.sharedInstance.sessionID ?? "",
                "language":UserService.sharedInstance.getLanguage()
            ]
            
            ApiService.get(endpoint: path, parameters: params){ (resultList:ResultList) in
                self.favoriteSeries.append(contentsOf: resultList.results)
                self.totalTVPages = resultList.totalPages ?? 0
                self.hasFinishedLoadingSeries = true
                onCompletion()
            }
        }
    }
    
    func getMoreMovies(){
        if totalMoviePages >= 2{
            for page in 2...totalMoviePages {
                
                let path = "account/\(UserService.sharedInstance.account?.id ?? 0)/favorite/movies"
                let params : [String:Any] = [
                    "page": page,
                    "session_id":UserService.sharedInstance.sessionID ?? "",
                    "language":UserService.sharedInstance.getLanguage()
                ]
                
                ApiService.get(endpoint: path, parameters: params){ (resultList:ResultList) in
                    self.favoriteMovies.append(contentsOf: resultList.results)
                }
            }
        }
    }
    
    func getMoreSeries(){
        if totalTVPages >= 2{
            for page in 2...totalMoviePages {
                
                let path = "account/\(UserService.sharedInstance.account?.id ?? 0)/favorite/movies"
                let params : [String:Any] = [
                    "page": page,
                    "session_id":UserService.sharedInstance.sessionID ?? "",
                    "language":UserService.sharedInstance.appLanguage
                ]
                
                ApiService.get(endpoint: path, parameters: params){ (resultList:ResultList) in
                    self.favoriteSeries.append(contentsOf: resultList.results)
                }
            }
        }
    }
    
    func updateFavorites () {
        favoriteMovies = []
        favoriteSeries = []
        
        getFavorites()
    }
    
}
