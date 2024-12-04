//
//  MovieDetailedViewModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 02/12/24.
//

import Foundation

protocol MovieDetailedViewModelDelegates: AnyObject
{
    func didUpdateNavigation(for result: MovieDetailedModel)
    func didUpdateCastDetails(for castResult: CastResponse)
    func didFetchTrailers(_ trailers: [Trailer])
    func didFailWithError(_ error: Error)
}

class MovieDetailedViewModel
{
    weak var delegate: MovieDetailedViewModelDelegates?
    
    func navigateToMovieDetailed(for movieId: Int)
       {
           let url = "\(NetworkConstant.shared.baseUrl)/movie/\(movieId)?api_key=\(NetworkConstant.shared.apiKey)"
           print("DEBUG: navigateToMovieDetail", url)
   
           APICaller.getRequest(url: url,
                                modalName: MovieDetailedModel.self)
           { [weak self] (data, error, status) in
   
               if let error = error
               {
                   print("DEBUG: getTopRatedMovies error", error.localizedDescription)
                   return
               }
   
               if let data = data
               {
                   DispatchQueue.main.async
                   {
                       print("DEBUG: getTopRatedMovies: \(data)")
                       self?.delegate?.didUpdateNavigation(for: data)
                   }
               }
           }
   
       }
    
    
    func navigateToCastDetailed(for movieId: Int)
    {
        let url = "\(NetworkConstant.shared.baseUrl)/movie/\(movieId)/credits?api_key=\(NetworkConstant.shared.apiKey)"
        
        print("DEBUG: navigateToCastDetailed", url)
        
        APICaller.getRequest(url: url,
                             modalName: CastResponse.self)
        { [weak self] (data, error, status) in

            if let error = error
            {
                print("DEBUG: navigateToCastDetailed error", error.localizedDescription)
                return
            }

            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("DEBUG: navigateToCastDetailed: \(data)")
                    self?.delegate?.didUpdateCastDetails(for: data)
                }
            }
        }
        
    }
    
    
    func loadTrailers(for movieId: Int)
    {
        APIRequest.fetchMovieTrailers(movieId: movieId) { result in
            switch result {
            case .success(let videos):
                let youtubeVideos = videos.filter { $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer" }
                DispatchQueue.main.async {
                    // Handle UI updates, such as reloading collection view or passing data to the view
                    print("Trailers: \(youtubeVideos.map { $0.name })")
                }
            case .failure(let error):
                print("Error fetching trailers: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMovieTrailers(movieId: Int)
    {
        let url = "\(NetworkConstant.shared.baseUrl)/movie/\(movieId)/videos?api_key=\(NetworkConstant.shared.apiKey)"
        
        APICaller.getRequest(url: url, modalName: TrailerResponse.self)
        { [weak self] data, error, _ in
            if let error = error
            {
                self?.delegate?.didFailWithError(error)
                return
            }
            
            if let trailers = data?.results.filter({ $0.site == "YouTube" })
            {
                DispatchQueue.main.async
                {
                    self?.delegate?.didFetchTrailers(trailers)
                    print("DEBUG: trailers Key - ",trailers )
                }
            }
        }
    }
}
