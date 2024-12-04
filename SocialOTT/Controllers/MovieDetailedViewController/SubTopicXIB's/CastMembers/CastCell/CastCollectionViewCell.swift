//
//  CastCollectionViewCell.swift
//  secondModule
//
//  Created by apple on 02/12/24.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageView.layer.cornerRadius = imageView.frame.size.height / 2
//        imageView.clipsToBounds = true
    }
   func confgure (with cast: CastMember) {
        nameLabel.text = cast.name
      // imageView.image = cast.profilePath
    }
}
