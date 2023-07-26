//
//  ResultList.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 12/6/23.
//

import Foundation
import CodableX


struct Result: Identifiable, Hashable {
    let uuid = UUID()
    let id:Int
    let title:String
    let subtitle:String?
    let image:String
    let type:ResultType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}

struct ResultList: Codable {
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    @ArrayAnyable<Options> var _results: [Any]
    
    enum CodingKeys:String, CodingKey{
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case _results = "results"
    }
    
    var results: [Result] {
        return _results.compactMap {$0 as? Resultable}.map {$0.result}
    }
}

// MARK: - MovieResult
struct MovieResult: Resultable {
    var adult: Bool?
    @Nullable var backdropPath: String?
    var genreIDs: [Int]
    var id: Int
    var originalLanguage: String
    var overview: String
    var popularity: Double
    var posterPath: String?
    @Nullable var voteAverage: Double?
    var voteCount: Int
    
    @Nullable var releaseDate: String?
    var title: String
    @Nullable var originalTitle: String?
    @Nullable var video: Bool?
    @Nullable var mediaType: String?
    
    enum CodingKeys:String, CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case overview
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_avarage"
        case voteCount = "vote_count"
        
        case releaseDate = "release_date"
        case title
        case originalTitle = "original_title"
        case video
        case mediaType = "media_type"
    }
    
    var result: Result {
            .init(
                id: id,
                title: title,
                subtitle: DateTools.format(this: releaseDate ?? ""),
                image: posterPath ?? "",
                type: .movie)
        }
    
}

// MARK: - TVResult
struct TVResult: Resultable {
        @Nullable var backdropPath: String?
        var genreIDs: [Int]
        var id: Int
        var originalLanguage: String
        var overview: String
        var popularity: Double
        @Nullable var posterPath: String?
        @Nullable var voteAverage: Double?
        var voteCount: Int
    
        @Nullable var firstAirDate: String?
        var name: String
        @Nullable var originCountry: String?
    
        enum CodingKeys:String, CodingKey{
            case backdropPath = "backdrop_path"
            case genreIDs = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case overview
            case popularity
            case posterPath = "poster_path"
            case voteAverage = "vote_avarage"
            case voteCount = "vote_count"
    
            case firstAirDate = "first_air_date"
            case name
            case originCountry = "origin_country"
    }
    
    var result: Result {
            .init(
                id: id,
                title: name,
                subtitle:  DateTools.format(this: firstAirDate ?? ""),
                image: posterPath ?? "",
                type: .tv
        )
    }
}

// MARK: - PeopleResult
struct PeopleResult: Resultable {
    @Nullable var adult: Bool?
    var gender: Int
    var id: Int
    @ArrayAnyable<PeopleOptions> var _knownFor: [Any] // MARK: not working
    var knownForDepartment: String
    var name: String
    var popularity: Double
    var profilePath: String
    
    enum CodingKeys:String, CodingKey{
        case adult
        case gender
        case id
        case _knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name
        case popularity
        case profilePath = "profile_path"
    }
    
    var result: Result {
            .init(
                id: id,
                title: name,
                subtitle:"✩ " + popularity.description,
                image: profilePath,
                type: .person)
        }
}


// MARK: - Protocols and Options

protocol Resultable: AnyCodable {
    var result:Result {get}
}

struct PeopleOptions: OptionConfigurable {
    static var options: [Option] = [
        .init(MovieResult.self),
        .init(TVResult.self),
    ]
}

struct Options: OptionConfigurable {
    static var options: [Option] = [
        .init(MovieResult.self),
        .init(TVResult.self),
        .init(PeopleResult.self)
    ]
}


enum ResultType: String {
    case tv, movie, person, cast, credit
}
