//
//  SearchViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 20/6/23.
//

import Foundation



class SearchViewModel: ObservableObject {
 
    var params: [String:Any] = [:]
    
    @Published var results: [Result] = []
   
    @Published var page:Int = 0
    var totalPages:Int = 0
    var item: String = ""
    var category: String = ""
    var endpoint:String = ""
    var canLookForMore: Bool = false
    
    
    func search(item: String, in category:String){
        params = [
            "query": item,
            "language":UserService.sharedInstance.appLanguage
        ]
        
        self.item = item
        self.category = category
        endpoint = "search/\(category)"
        print("searching ")

        ApiService.get(endpoint: endpoint, parameters: params){ (resultList: ResultList) in
            self.results = resultList.results
            self.totalPages = resultList.totalPages ?? 0
        }
        page = 1
    }
    
   
    
    
    func getMoreResults(){
        if page < totalPages {
            page += 1
        }
        
        params = [
            "query": item,
            "page": page,
            "language":UserService.sharedInstance.appLanguage
        ]
        
        print("searching more")

        if page > 1 && page < totalPages {
            ApiService.get(endpoint:endpoint, parameters: params ){ (resultList:ResultList) in
                self.results.append(contentsOf: resultList.results)
            }
        }
    }
    
}
