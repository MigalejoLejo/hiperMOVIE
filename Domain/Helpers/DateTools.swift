//
//  MyDateFormater.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import Foundation


class DateTools {
    static let dateFormatter = DateFormatter()
  

    static func format(this date: String) -> String{
        DateTools.dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd MMM yyyy"
            let formattedDate = dateFormatter.string(from: date)
            return ("\(formattedDate)") // Output: 22 Jul 1947
        } else {
            return(date)
        }
    }
    
    static func calculateAge(from birthdate: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: birthdate) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
            return ageComponents.year
        }
        
        return nil
    }

   
}
