//
//  trendingMoviesCVCellCollectionViewCell.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import UIKit
import SDWebImage

class trendingMovieCell: UICollectionViewCell
{

    var movieID : Int = 0
    
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with  movie: TrendingResultDay)
    {
      
        if let posterPath = movie.posterPath
        {
            let rawURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let validURLString = rawURLString.removingPercentEncoding
            {
                self.movieID = movie.id
                print("DEBUG: self.movieID from TrendingResultDay",self.movieID )
                lblTitle.text = movie.title
                let finalURL = URL(string: validURLString)
                imageView.sd_setImage(with: finalURL , placeholderImage: UIImage(named: "placeholder"))
                print("DEBUG:imageURL", validURLString)
            }
        }
        
    }
    
    func configure(with  movie: TrendingResultWeek)
    {
      
        if let posterPath = movie.posterPath
        {
            let rawURLString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let validURLString = rawURLString.removingPercentEncoding
            {
                self.movieID = movie.id
                print("DEBUG: self.movieID from TrendingResultWeek",self.movieID )
                lblTitle.text = movie.title
                let finalURL = URL(string: validURLString)
                imageView.sd_setImage(with: finalURL , placeholderImage: UIImage(named: "placeholder"))
                print("DEBUG:imageURL", validURLString)
            }
        }
        
    }
    
    
   
}
