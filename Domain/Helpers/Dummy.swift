////
////  Dummy.swift
////  Movie
////
////  Created by Miguel Alejandro Correa Avila on 6/6/23.
////
//
//import SwiftUI
//
//
//// A Dummy-Struct that returns Dummies for testing
//struct Dummy {
//    
//    static var messages: String = ""
//   
//    static func getResult(for type:ResultType = .movie) -> Result {
//        return Result(
//            id: 1,
//            title: "Super Mario Bros.",
//            subtitle: "The Movie",
//            image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
//            type: type
//        )
//    }
//    
//    static func getResults(_ quantity:Int) -> [Result] {
//        var results:[Result] = []
//        for _ in 0...quantity {
//            results.append(getResult())
//        }
//        return results
//    }
//    
//    static func getWarning(color: Color = .red, message: String = "This is a dummy warning") -> Warning {
//        return Warning(type: .logging, color: color, message:message)
//    }
//}
