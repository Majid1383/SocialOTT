//
//  TrendingMoviesModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import Foundation

//MARK: Below is the Data Model for Day
struct TrendingMoviesForDay: Decodable
{
    let page: Int
    let results: [TrendingResultDay]
}

struct TrendingResultDay: Decodable
{
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let originalLanguage: String?
    let genreIDs: [Int]?
    let popularity: Double
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool
    let video: Bool
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey
    {
        case id, title, overview, popularity, adult, video
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


//MARK: Below is the Data Model for Week
struct TrendingMoviesForWeek: Decodable
{
    let page: Int
    let results: [TrendingResultWeek]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey
    {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TrendingResultWeek: Decodable
{
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: MediaType?
    let adult: Bool?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey
    {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Decodable
{
    case movie
}
