//
//  PopularMoviesModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import Foundation

struct PopularMoviesModel: Decodable
{
    let page: Int
    let results: [PopularMoviesResult]
    let totalPages: Int
    let totalResults: Int
    
    // Map snake_case JSON keys to camelCase properties
    enum CodingKeys: String, CodingKey
    {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PopularMoviesResult: Decodable
{
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey
    {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Decodable
{
    case en = "en"
    case es = "es"
    case fr = "fr"
    case tl = "tl"
}

