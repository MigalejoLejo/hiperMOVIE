//
//  MediaDetails.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import Foundation
import CodableX

protocol MediaDetails: AnyCodable {
    var details: DetailsWrapper {get}
    
}


// MARK: - DetailsWrapper
struct DetailsWrapper: Codable{
    let id: Int
    let title: String
    let genres: [Genre]
    let backdrop: String?
    let poster: String?
    let overview: String
    let date: String
    let tagline: String
    let status: String?
    var recommendations: ResultList?
    var similar: ResultList?
    var credits: Credits
    var seasons: [Season]?
    var videos: Videos
    var accountState: MediaState
}


struct MediaDetailsResult: AnyCodable {
    @AnyValuable<MediaOptions> var _details: AnyValue
}

extension AnyValue {
    var details: MediaDetails? {
        value as? MediaDetails
    }
}

public struct MediaOptions: OptionConfigurable {
    public static var options: [Option] = [
        .init(MovieDetails.self),
        .init(TVDetails.self),
    ]
}


// MARK: - MovieDetails
struct MovieDetails: MediaDetails {
    
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    @Defaultable var overview: String
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    @Defaultable var tagline: String
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let similar: ResultList?
    let recommendations: ResultList?
    @Defaultable var credits: Credits
    var videos: Videos?
    @Defaultable var accountStates: MediaState

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case similar, recommendations, credits, videos
        case accountStates = "account_states"
    }
    
    var details: DetailsWrapper {
        .init(
            id: id ?? 0,
            title: title ?? "",
            genres: genres ?? [],
            backdrop: backdropPath,
            poster: posterPath,
            overview: overview,
            date: DateTools.format(this: releaseDate ?? ""),
            tagline: tagline,
            status: status,
            recommendations: recommendations,
            similar: similar,
            credits: credits,
            seasons: nil,
            videos: videos ?? Videos(results: []),
            accountState: accountStates
        )
    }
}

// MARK: - TVDetails
struct TVDetails: MediaDetails {
    let adult: Bool?
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: Episode?
    let name: String?
    let nextEpisodeToAir: Episode?
    let networks: [Network]?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]?
    let productionCountries: [ProductionCountry]?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?
    let similar, recommendations: ResultList?
    @Defaultable var credits: Credits
    var videos: Videos?
    @Defaultable var accountStates: MediaState


    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case similar, recommendations, credits, videos
        case accountStates = "account_states"


    }
    
    var details: DetailsWrapper {
        .init(id: id ?? 0 , title: name ?? "", genres: genres ?? [], backdrop: backdropPath, poster: posterPath, overview: overview ?? "", date: DateTools.format(this: firstAirDate ?? ""), tagline: tagline ?? "", status: status, recommendations: recommendations, similar: similar, credits: credits, seasons: seasons, videos:  videos ?? Videos(results: []), accountState: accountStates
)
    }
   
}

// MARK: - PeopleDetails
struct PeopleDetails: Codable {
    let adult: Bool?
    let gender: Int
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let birthday:String?
    let deathday: String?
    let placeOfBirth:String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    @Defaultable var order: Int
    let department: String?
    let job: String?
    let biography : String?
    let images: PersonImages?
    let combinedCredits: CombinedCredits?


    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case birthday
        case deathday
        case placeOfBirth = "place_of_birth"
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
        case biography
        case images
        case combinedCredits = "combined_credits"
    }
    
    var result: Result {
            .init(
                id: id ?? 0,
                title: name ?? "",
                subtitle:"✩ " + (popularity?.description ?? ""),
                image: profilePath ?? "",
                type: .person)
        }
}


// >>>>>>>>>>>>>>>>>  SUB MODELS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// MARK: - BelongsToCollection
struct BelongsToCollection: AnyCodable {
    var id: Int?
    var name: String?
    var posterPath:String?
    var backdropPatch:String?
}


// MARK: - CombinedCredits
struct CombinedCredits: Codable {
    @ArrayAnyable<Options> var _cast: [Any]
    
    enum CodingKeys: String, CodingKey {
        case _cast = "cast"
    }
        
    var cast: [Result] {_cast.compactMap {($0 as? Resultable)?.result }}
}


// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int?
    let creditID, name: String?
    let gender: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}


// MARK: - Credits
struct Credits: Codable, DefaultCodable {
    init() {
        cast = []
        crew = []
    }
    
    let cast, crew: [PeopleDetails]
    var castResults: [Result] {cast.sorted (by: { $0.order < $1.order })[0..<min(15, cast.count)].map {$0.result}
    }
}


// MARK: - LastEpisodeToAir
struct Episode: Codable {
    let id: Int?
    let name, overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let airDate: String?
    let episodeNumber: Int?
    let productionCode: String?
    let runtime, seasonNumber, showID: Int?
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}


// MARK: - Network
struct Network: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


// MARK: - State
struct MediaState: Codable, DefaultCodable {
    init(){
        id = 0
        favorite = false
        watchlist = false
    }
    
   let id: Int?
   var favorite: Bool?
   var watchlist: Bool?
}


// MARK: - PersonImages
struct PersonImages: Codable {
    let id: Int?
    let profiles: [Profile]?
}


// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}


// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}


// MARK: - Profile
struct Profile: Codable {
    let filePath: String?

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}



// MARK: - Recommendations
struct Recommendations: Codable {
    let page: Int
    let results: [MovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}


// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}


// MARK: - Videos
struct Videos: Codable {
    let results: [VideosResult]
}


// MARK: - VideosResult
struct VideosResult: Codable {
    let name, key: String?
    let site: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name, key, site, id
    }
}



// MARK: - FavoriteState
struct FavoriteState: Codable {
    var media_type: String
    var media_id: Int
    var favorite: Bool
    
    enum codingKeys: String, CodingKey{
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
}
