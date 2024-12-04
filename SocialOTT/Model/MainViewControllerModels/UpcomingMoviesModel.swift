//
//  UpcomingMoviesModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 02/12/24.
//

import Foundation

// MARK: - UpcomingMoviesModel
struct UpcomingMoviesModel: Decodable {
    let dates: UpcomingMoviesDates
    let page: Int
    let results: [UpcomingMoviesResult]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct UpcomingMoviesDates: Decodable {
    let maximum: String
    let minimum: String
}

// MARK: - UpcomingMoviesResult
struct UpcomingMoviesResult: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


