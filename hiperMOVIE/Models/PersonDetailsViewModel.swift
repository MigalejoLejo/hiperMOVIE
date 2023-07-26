//
//  PersonDetailsViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import Foundation

class PersonDetailsViewModel: ObservableObject {
    var id: Int = 0
    var endpoint:String = ""
    var params: [String:Any] = [:]

    @Published var person: PeopleDetails? = nil
  
    
    
    func loadDetails(id:Int){
        self.id = id
        endpoint = "person/\(id)"
        params = [
            "append_to_response": "combined_credits,images",
            "language":UserService.sharedInstance.appLanguage
        ]
        
        
        

        ApiService.get(endpoint: endpoint, parameters: params){ (person: PeopleDetails) in
            self.person = person
            print(self.person?.images?.profiles ?? [])
        }
    }
    
    
//    func getBirthAndDeathDetails () -> some View{
//        var birhtAndDeathDetails = ""
//
//        if let age = DateTools.calculateAge(from:person?.birthday ?? "") {
//            if let deathDate = person?.deathday, !deathDate.isEmpty{
//                birhtAndDeathDetails = "\("died_at".localizedLanguage()): \(age) \("years_old".localizedLanguage()) \n"
//            } else {
//                birhtAndDeathDetails += ("\(age) \(String(localized: "years_old")) \n")
//            }
//            birhtAndDeathDetails += ("\("birthdate".localizedLanguage()): \(DateTools.format(this: person?.birthday ?? "")) \n")
//        }
//
//        if let birthPlace = person?.placeOfBirth, !birthPlace.isEmpty {
//            birhtAndDeathDetails += ("\("born_in".localizedLanguage()) \(birthPlace) \n")
//        }
//
//        if let deathDate = person?.deathday, !deathDate.isEmpty{
//            birhtAndDeathDetails += ("\("date_of_death".localizedLanguage()): \(DateTools.format(this: deathDate)) \n")
//        }
//
//        if birhtAndDeathDetails.isEmpty {
//            return Text("\("no_birth_or_death_information".localizedLanguage()).")
//        } else {
//            return Text(birhtAndDeathDetails)
//        }
//    }
}
