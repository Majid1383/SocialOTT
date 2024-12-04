//
//  NetworkConstant.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import Foundation

class NetworkConstant
{
    // Singleton instance
    static let shared = NetworkConstant()
    
    // Private initializer to enforce singleton pattern
    private init() {}
    
    let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"
    
    // Base URLs and API key
    let apiKey = "154ad8f9017ced85e1b45f006f50d4a0"
    let baseUrl = "https://api.themoviedb.org/3"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    // API Endpoints
    var trendingMoviesForDay: String { "\(baseUrl)/trending/movie/week?api_key=\(apiKey)" }
    var trendingMoviesForWeek: String { "\(baseUrl)/trending/movie/day?api_key=\(apiKey)" }
    var nowPlayingMovies: String { "\(baseUrl)/movie/now_playing?api_key=\(apiKey)" }
    var popularMovies: String { "\(baseUrl)/movie/popular?api_key=\(apiKey)" }
    var topRatedMovies: String { "\(baseUrl)/movie/top_rated?api_key=\(apiKey)" }
    var upcomingMovies: String { "\(baseUrl)/movie/upcoming?api_key=\(apiKey)" }
    var navigateToMovieDetailed: String {"\(baseUrl)/movie/upcoming?api_key=\(apiKey)"}
    
    //var url = "https://www.youtube.com/watch?v=\(self.dummyTrailerURL)" 
}

