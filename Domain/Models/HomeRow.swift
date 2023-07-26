//
//  Row.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 12/6/23.
//

import Foundation

struct HomeRow: Identifiable {
    var id: UUID = UUID()
    var title:String
    var list: ResultList
    var params: [String:Any] = [:]
    var endpoint: String
}
