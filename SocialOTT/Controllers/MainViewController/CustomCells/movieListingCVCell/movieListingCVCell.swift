//
//  movieListingCVCell.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import UIKit

class movieListingCVCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblMovieListing: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 5
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(for value: String)
    {
        lblMovieListing.text  = value
    }

}
