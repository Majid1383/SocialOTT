//
//  MovieDetailedViewController.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 02/12/24.
//

import UIKit
import SDWebImage
import WebKit
import YouTubeiOSPlayerHelper

class MovieDetailedViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblGeneres: UILabel!
    @IBOutlet weak var movieDetailSubTypesCV: UICollectionView!
    @IBOutlet weak var containerView: UIView!

    let playerView = YTPlayerView()
    
    var movieDetailedDataModel : MovieDetailedModel?
    
    var viewModel : MovieDetailedViewModel  = MovieDetailedViewModel()
    var castDataModel : [CastMember] = []
    var trailerDataModel : [Trailer] = []
    
    var movieId : Int = 0
    var selectedIndex: Int = 0
    
    let subTopicArray : [String] = ["About Movie", "Cast"]
    var trailerURL: String = ""
    var dummyTrailerURL : String = ""
    
    lazy var aboutView: AboutViewClass =
    {
        let view = AboutViewClass(frame: containerView.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    lazy var castView: CastViewClass =
    {
        let view = CastViewClass(frame: containerView.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.title = ""
        callingViewModelFunctions()
        updateUI()
        configureYoutubeView(for: self.dummyTrailerURL)
        setupTapGestureForProfileImageView()
        setupTapGestureForPlayerView()
    }
    
    //MARK: VIEW Will Appear
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        playerView.playVideo() // Resume the video when returning
    }
    
    //MARK: VIEW Will DisAppear
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        playerView.pauseVideo() // Pause the video when leaving the screen
    }

    func callingViewModelFunctions()
    {
        viewModel.delegate = self
        viewModel.fetchMovieTrailers(movieId: self.movieId)
        viewModel.navigateToMovieDetailed(for: self.movieId)
        viewModel.navigateToCastDetailed(for: self.movieId)
    }
    
    //MARK: updateUI()
    func updateUI()
    {
        setupCollectionView()
        addViewToContainer(aboutView)
    }
    
    func configureYoutubeView(for videoKey: String)
    {
        
        playerView.frame = backGroundImageView.bounds
        backGroundImageView.addSubview(playerView)
        
        playerView.alpha = 1.0
        playerView.backgroundColor = .clear
        playerView.load(withVideoId: videoKey, playerVars: [
                "controls": 0,
                "playsinline": 1,
                "autoplay": 1,
                "mute": 1,
                "loop": 1
            ])
    }
    
    private func setupTapGestureForProfileImageView()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    private func setupTapGestureForPlayerView()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTappedFromVideoPlayer))
        profileImageView.addGestureRecognizer(tapGesture)
        playerView.isUserInteractionEnabled = true
    }
    
    @objc func imageTappedFromVideoPlayer()
    {
        print("DEBUG : Image is getting tapped from imageTappedFromVideoPlayer")
        let vc = WebViewController(nibName: "WebViewController", bundle: nil)
        vc.urlString = self.trailerURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageTapped()
    {
        print("DEBUG : Image is getting tapped! ")
        let vc = WebViewController(nibName: "WebViewController", bundle: nil)
        vc.urlString = self.trailerURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func addViewToContainer(_ view: UIView)
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

}

extension MovieDetailedViewController : MovieDetailedViewModelDelegates
{
    
    func didFetchTrailers(_ trailers: [Trailer])
    {
        self.trailerDataModel = trailers
        self.dummyTrailerURL = self.trailerDataModel.first?.key ?? ""
        
        // Safely unwrap the trailerURL
        let url = "https://www.youtube.com/watch?v=\(self.dummyTrailerURL)"
        self.trailerURL = url
        
        if let youtubeUrl = URL(string: url)
        {
            let request = URLRequest(url: youtubeUrl)
            print("DEBUG: request + URL ", request)
            configureYoutubeView(for: self.dummyTrailerURL)
        } else
        {
            print("DEBUG: Invalid YouTube URL string")
        }
    }
 
    func didFailWithError(_ error: any Error)
    {
        print("Error fetching trailers: \(error.localizedDescription)")
    }
    
    func didUpdateCastDetails(for castResult: CastResponse)
    {
        self.castDataModel = castResult.cast
        print("self.castDataModel",self.castDataModel)
    }
    
    func didUpdateNavigation(for result: MovieDetailedModel)
    {
        self.movieDetailedDataModel = result
        configure(with: result)
        aboutView.configure(with: result.overview)
    }
    
    
    func configure(with  movie: MovieDetailedModel)
    {
        if let posterPath = movie.posterPath, let profileImage = movie.backdropPath
        {
            lblMovieName.text = movie.title
            lblGeneres.text = movie.genres.first?.name
            
            
            let rawURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            let rawBackDropURLString = "https://image.tmdb.org/t/p/w500\(profileImage)"
            if let validURLString = rawURLString.removingPercentEncoding, let validBackdropPathString = rawBackDropURLString.removingPercentEncoding
            {
                
                let finalURL = URL(string: validURLString)
                let finalProfileURL = URL(string: rawBackDropURLString)
//                backGroundImageView.sd_setImage(with: finalURL , placeholderImage: UIImage(named: "placeholder"))
                profileImageView.sd_setImage(with: finalProfileURL , placeholderImage: UIImage(named: "placeholder"))
                print("DEBUG:imageURL", validURLString)
            }
        }
    }
    
    
}


