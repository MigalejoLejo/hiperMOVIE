//
//  ContentViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 26/6/23.
//

import Foundation

class ContentViewModel: ObservableObject{
    
    @Published var homeViewID:UUID = UUID()
    
    func navToHome () {
        homeViewID = UUID()
    }
    
}
