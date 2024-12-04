//
//  movieListingDetailCVCell.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import UIKit
import SDWebImage

class movieListingDetailCVCell: UICollectionViewCell
{

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    
    func configure<T>(with movie: T)
    {
        let posterPath: String?
        
        switch movie
        {
        case let popularMovie as PopularMoviesResult:
            posterPath = popularMovie.posterPath
        case let upcomingMovie as UpcomingMoviesResult:
            posterPath = upcomingMovie.posterPath
        case let nowPlayingMovie as NowPlayingMoviesResult:
            posterPath = nowPlayingMovie.posterPath
        case let topRatedMovie as TopRatedMoviesResult:
            posterPath = topRatedMovie.posterPath
        default:
            posterPath = nil
        }
        
        if let posterPath = posterPath
        {
            let rawURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let validURLString = rawURLString.removingPercentEncoding,
               let finalURL = URL(string: validURLString)
            {
                imgView.sd_setImage(with: finalURL, placeholderImage: UIImage(named: "placeholder"))
                print("DEBUG:imageURL", validURLString)
            }
        }
    }
   
}
