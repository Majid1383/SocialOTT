//
//  MainViewModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import Foundation


protocol MainViewModelDelegates: AnyObject
{
    func didUpdatePopularMovies(for popularMovies: [PopularMoviesResult])
    func didUpdateTrendingMoviesForDay(for trendingMovies: [TrendingResultDay])
    func didUpdateTrendingMoviesForWeek(for trendingMovies: [TrendingResultWeek])
    func didUpdateUpcomingMovies(for upcomingMovies: [UpcomingMoviesResult])
    func didUpdateNowPlayingMovies(for nowPlayingMovies: [NowPlayingMoviesResult])
    func didUpdateTopRatedMovies(for topRatedMovies: [TopRatedMoviesResult])
}


class MainViewModel
{
    weak var delegate: MainViewModelDelegates?
    
//    func getData()
//    {
//        APICaller.getTrendingMovies
//        { [weak self] result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getData ",data.results)
//                    self?.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in  getData, ",error)
//                }
//            }
//        }
//    }
    
    //MARK: Get Trending Movies for the Day
//    func getTrendingMoviesForTheDay()
//    {
//        APICaller.getTrendingMovies
//        { [weak self] result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getTrendingMoviesForTheDay ",data.results)
//                    self?.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getTrendingMoviesForTheDay, ",error)
//                }
//            }
//        }
//        
//    }
    
    //MARK: Get Trending Movies for the Week
//    func getTrendingMoviesForTheWeek()
//    {
//        APICaller.trendingMoviesForWeek
//        { [weak self] result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getTrendingMoviesForTheDay ",data.results)
//                    self?.delegate?.didUpdateMovies(data.results)
//                    
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getTrendingMoviesForTheDay, ",error)
//                }
//            }
//        }
//    }
    
    //MARK: Now Playing Movies
//    func getNowPlayingMovies()
//    {
//        APICaller.getNowPlayingMovies
//        {  result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getNowPlayingMovies ",data.results)
//                    self.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getNowPlayingMovies, ",error)
//                }
//            }
//        }
//    }
    
    //MARK: Popular Movies
//    func getPopularMovies()
//    {
//        APICaller.getPopularMovies
//        {  result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getPopularMovies ",data.results)
//                    self.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getPopularMovies, ",error)
//                }
//            }
//        }
//    }
    
    
    
    //MARK: Top-Rated Movies
//    func getTopRatedMovies()
//    {
//        APICaller.getTopRatedMovies
//        {  result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getTopRatedMovies ",data.results)
//                    self.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getTopRatedMovies, ",error)
//                }
//            }
//        }
//        
//    }
    
    //MARK: Upcoming Movies
//    func getUpcomingMovies()
//    {
//        APICaller.getUpcomingMovies
//        {  result in
//            DispatchQueue.main.async
//            {
//                switch result
//                {
//                case .success(let data):
//                    print("DEBUG: getUpcomingMovies ",data.results)
//                    self.delegate?.didUpdateMovies(data.results)
//                    
//                case .failure(let error):
//                    print("DEBUG: Failure in getUpcomingMovies, ",error)
//                }
//            }
//        }
//    }
    
    func getTrendingMoviesForDay()
    {
        let url = NetworkConstant.shared.trendingMoviesForDay
        
        APICaller.getRequest(url: url,
                             modalName: TrendingMoviesForDay.self)
        { [weak self] (data, error, status) in
            
            if let error = error
            {
                print("DEBUG: getPopulareMovies error", error.localizedDescription)
                return
            }
            
            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("Popular Movies: \(data.results)")
                    self?.delegate?.didUpdateTrendingMoviesForDay(for: data.results)
                    
                }
            }
        }
    }
    
    func getTrendingMoviesForWeek()
    {
        let url = NetworkConstant.shared.trendingMoviesForWeek
        APICaller.getRequest(url: url,
                             modalName: TrendingMoviesForWeek.self)
        { [weak self] (data, error, status) in
            
            if let error = error
            {
                print("DEBUG: getPopulareMovies error", error.localizedDescription)
                return
            }
            
            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("Popular Movies: \(data.results)")
                    self?.delegate?.didUpdateTrendingMoviesForWeek(for: data.results)
                    
                }
            }
        }
    }
    
    
    func getPopulareMovies()
    {
        let url = NetworkConstant.shared.popularMovies
        
        APICaller.getRequest(url: url,
                             modalName: PopularMoviesModel.self)
        { [weak self] (data, error, status) in
            
            if let error = error
            {
                print("DEBUG: getPopulareMovies error", error.localizedDescription)
                return
            }
            
            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("Popular Movies: \(data.results)")
                    self?.delegate?.didUpdatePopularMovies(for: data.results)
                }
            }
        }
    }
    
    func getUpcomingMovies()
    {
        let url = NetworkConstant.shared.upcomingMovies
        
        APICaller.getRequest(url: url,
                             modalName: UpcomingMoviesModel.self)
        { [weak self] (data, error, status) in
            
            if let error = error
            {
                print("DEBUG: getUpcomingMovies error", error.localizedDescription)
                return
            }
            
            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("DEBUG: getUpcomingMovies: \(data.results)")
                    self?.delegate?.didUpdateUpcomingMovies(for: data.results)
                }
            }
        }
    }
    
    func getNowPlayingMovies()
    {
        let url = NetworkConstant.shared.nowPlayingMovies
        
        APICaller.getRequest(url: url,
                             modalName: NowPlayingMoviesModel.self)
        { [weak self] (data, error, status) in
            
            if let error = error
            {
                print("DEBUG: getNowPlayingMovies error", error.localizedDescription)
                return
            }
            
            if let data = data
            {
                DispatchQueue.main.async
                {
                    print("DEBUG: getNowPlayingMovies: \(data.results)")
                    self?.delegate?.didUpdateNowPlayingMovies(for: data.results)
                    
                }
            }
        }
    }
    
    func getTopRatedMovies()
    {
        let url = NetworkConstant.shared.topRatedMovies
        
        APICaller.getRequest(url: url,
                             modalName: TopRatedMoviesModel.self)
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
                    print("DEBUG: getTopRatedMovies: \(data.results)")
                    self?.delegate?.didUpdateTopRatedMovies(for: data.results)
                }
            }
        }
    }
     
}
