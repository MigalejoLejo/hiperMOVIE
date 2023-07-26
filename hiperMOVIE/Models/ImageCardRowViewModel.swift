//
//  ImageCardRowModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 15/6/23.
//

import Foundation
import SwiftUI

class ImageCardRowViewModel: ObservableObject {
    
    @Published var results:[Result] = []
    var path:String
    var page:Int = 1
    var title:String
    var totalPages:Int = 1
    
    var params:[String:Any] = [
        "language":UserService.sharedInstance.appLanguage
    ]

    var endpoint:Endpoint {
        return Endpoint(path: "\(path)?page=\(page)", title: title)
    }
     
    
    init(path: String, title: String) {
        self.path = path
        self.title = title
    }
    
    
    
    func fetchResults() {
      
        
        ApiService.get(endpoint: endpoint.path, parameters: params){ (resultList:ResultList) in
            self.results = resultList.results
            self.totalPages = resultList.totalPages ?? 0
        }
    }
    
    func getMoreResults(){
        page += 1
        if page <= totalPages {
            ApiService.get(endpoint: endpoint.path, parameters: params){ (resultList:ResultList) in
                self.results.append(contentsOf: resultList.results)
            }
        }
    }
    
}

