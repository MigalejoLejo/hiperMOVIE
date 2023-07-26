//
//  Env.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 21/6/23.
//


struct Env {
    static let api_key = "204d0575f0b77a6ce275bc3e63fa1f17"
    static let base_url = "https://api.themoviedb.org/3/"
    static let image_url = "https://image.tmdb.org/t/p"
}

enum ImageSize: String {
    case w500 = "w500"
    case original = "original"
}
