//
//  Account.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 26/6/23.
//

import Foundation



// MARK: - Account
struct Account: Codable {
    var avatar: Avatar
    var id: Int
    var iso639_1, iso3166_1, name: String
    var includeAdult: Bool
    var username: String

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    var gravatar: Gravatar
    var tmdb: Tmdb
}

// MARK: - Gravatar
struct Gravatar: Codable {
    var hash: String?
}

// MARK: - Tmdb
struct Tmdb: Codable {
    var avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
