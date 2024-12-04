//
//  MainViewController.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import UIKit

class MainViewController: UIViewController
{

    //MARK: Outlets
    @IBOutlet weak var movieListingDetailCollView: UICollectionView!
    @IBOutlet weak var movieListiingCollView: UICollectionView!
    @IBOutlet weak var trendingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var segmentOutLet: UISegmentedControl!
    
    //MARK: View Model
    var viewModel : MainViewModel  = MainViewModel()
    
    //MARK: Data Models
    var trendingMoviesDataModelDay: [TrendingResultDay] = []
    var trendingMoviesDataModelWeek: [TrendingResultWeek] = []
    
    var popularMoviesDataModel: [PopularMoviesResult] = []
    var upcomingMoviesDataModel: [UpcomingMoviesResult] = []
    var nowplayingMoviesdataModel : [NowPlayingMoviesResult] = []
    var topRatedMoviesdataModel : [TopRatedMoviesResult] = []
    
    var randomMoviesForDay: [TrendingResultDay] = []
    var randomMoviesForWeek: [TrendingResultWeek] = []
    
    var movieListingArray = ["Now Playing", "Popular", "Top-Rated", "Upcoming"]
    
    var selectedIndex : Int = 0
    var movieId: Int = 0
    
   
    //MARK: ViewWill Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        viewModel.getTrendingMoviesForDay()
        callingViewModelFunctions()
        
//        let url = "\(NetworkConstant.shared.baseUrl)/movie/\(self.movieId)?api_key=\(NetworkConstant.shared.apiKey)"
//        print("DEBUG: navigateToMovieDetail", url)
    }
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.delegate = self
        callingViewModelFunctions()
    }
    
    func callingViewModelFunctions()
    {
        viewModel.getTrendingMoviesForDay()
        viewModel.getNowPlayingMovies()
        viewModel.getPopulareMovies()
        viewModel.getTopRatedMovies()
        viewModel.getUpcomingMovies()
    }
    
    //MARK: Segment Actions
    @IBAction func segmentActionTapped(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            print("DEBUG: Day is selected")
            viewModel.getTrendingMoviesForDay()
            
        }else if sender.selectedSegmentIndex == 1
        {
            print("DEBUG: Week is selected")
            viewModel.getTrendingMoviesForWeek()
        } else
        {
            print("DEBUG: Nothing in else Statement!")
        }
        self.scrollToFirstIndex(collectionView: self.trendingMoviesCollectionView) // Scroll to First Index
        self.trendingMoviesCollectionView.reloadData()
    }
    
    //Random Five Array From Trending-Day
    func showRandomFiveMoviesDay()
    {
        let shuffleDayArray = trendingMoviesDataModelDay.shuffled()
        randomMoviesForDay = Array(shuffleDayArray.prefix(5))
    }
    
    //Random Five Array From Trending-Week
    func showRandomFiveMoviesWeek()
    {
        let shuffleWeekArray = trendingMoviesDataModelWeek.shuffled()
        randomMoviesForWeek = Array(shuffleWeekArray.prefix(5))
    }
   
}

//MARK: Conforming Protocol
extension MainViewController : MainViewModelDelegates
{
    func didUpdateTrendingMoviesForWeek(for trendingMovies: [TrendingResultWeek])
    {
        self.trendingMoviesDataModelWeek = trendingMovies
        self.showRandomFiveMoviesWeek()
        self.trendingMoviesCollectionView.reloadData()
        print("DEBUG: trendingMoviesDataModelWeek is working alright!")
    }
    
    func didUpdateTrendingMoviesForDay(for trendingMovies: [TrendingResultDay])
    {
        self.trendingMoviesDataModelDay = trendingMovies
        self.showRandomFiveMoviesDay()
        self.trendingMoviesCollectionView.reloadData()
        print("DEBUG: trendingMoviesDataModelDay is working alright!")
    }
    
    func didUpdatePopularMovies(for popularMovies: [PopularMoviesResult])
    {
        self.popularMoviesDataModel = popularMovies
        self.movieListingDetailCollView.reloadData()
        self.scrollToFirstIndex(collectionView: self.movieListingDetailCollView)
        print("DEBUG: popularMoviesDataModel is working alright!")
    }
    
    func didUpdateUpcomingMovies(for upcomingMovies: [UpcomingMoviesResult])
    {
        self.upcomingMoviesDataModel = upcomingMovies
        self.movieListingDetailCollView.reloadData()
        self.scrollToFirstIndex(collectionView: self.movieListingDetailCollView)
        print("DEBUG: upcomingMoviesDataModel is working alright!")
    }
    
    func didUpdateNowPlayingMovies(for nowPlayingMovies: [NowPlayingMoviesResult])
    {
        self.nowplayingMoviesdataModel = nowPlayingMovies
        self.movieListingDetailCollView.reloadData()
        self.scrollToFirstIndex(collectionView: self.movieListingDetailCollView)
        print("DEBUG: nowplayingMoviesdataModel is working alright!")
    }
    
    func didUpdateTopRatedMovies(for topRatedMovies: [TopRatedMoviesResult])
    {
        self.topRatedMoviesdataModel = topRatedMovies
        self.movieListingDetailCollView.reloadData()
        self.scrollToFirstIndex(collectionView: self.movieListingDetailCollView)
        print("DEBUG: topRatedMoviesdataModel is working alright!")
    }
}


