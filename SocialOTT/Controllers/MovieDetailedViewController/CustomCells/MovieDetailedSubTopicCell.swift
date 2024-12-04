//
//  MovieDetailedSubTopicCell.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 03/12/24.
//

import UIKit

class MovieDetailedSubTopicCell: UICollectionViewCell
{

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblSubtopics: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 5
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.white.cgColor
        
    }
  
}
