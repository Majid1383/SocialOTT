//
//  CastViewClass.swift
//  secondModule
//
//  Created by apple on 02/12/24.
//

import UIKit

class CastViewClass: UIView
{
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    private let viewModel : MovieDetailedViewModel =  MovieDetailedViewModel()
    
    var movieId: Int? {
            didSet {
                if let id = movieId {
                    loadCastDetails(for: id)
                    navigateToCastDetailed(for: movieId ?? 0)
                }
            }
        }
        
       
    var cast: [CastMember] = []
    
    override init(frame: CGRect)
    { // for using CustomView in code
        super.init(frame: frame)
        commonInit()
        UISet()

    }
    
    required init?(coder aDecoder: NSCoder)
    { // for using CustomView in IB
        super.init (coder: aDecoder)
        commonInit ( )
    }
    
    func loadCastDetails(for movieId: Int) {
        print("Loading cast details for movie ID: \(movieId)")
        // Add API call or other logic to fetch cast data
    }
    
    private func commonInit()
    {
        Bundle.main.loadNibNamed("CastViewClass", owner: self,options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    private func UISet()
    {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cast")
    }

    
}
extension CastViewClass : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast", for: indexPath) as! CastCollectionViewCell
        let cast = cast[indexPath.row]
        print(cast.name)
        cell.nameLabel.text = cast.name
        if let profilePath = cast.profilePath {
                let urlString = "https://image.tmdb.org/t/p/w500\(profilePath)"
                if let url = URL(string: urlString) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.imageView.image = image
                            }
                        }
                    }
                }
            } else {
                cell.imageView.image = UIImage(named: "placeholder.jpg") // Add a default placeholder image
            }
       // cell.nameLabel.text = cast[indexPath.row].name
        //cell.imageView.image = UIImage(named: "\(indexPath.row)")// Make the image circular
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height / 2
        cell.imageView.clipsToBounds = true
        return cell
    }
}
extension CastViewClass: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Size for each item (half the width of the screen minus padding)
        let width = (collectionView.bounds.width/2) - 10 // Adjust spacing
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20// Spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Spacing between items in the same row
    }
    
    
}

extension CastViewClass {
    
    func navigateToCastDetailed(for movieId: Int)
    {
        let url = "\(NetworkConstant.shared.baseUrl)/movie/\(movieId)/credits?api_key=\(NetworkConstant.shared.apiKey)"
        
        print("DEBUG: navigateToCastDetailed", url)
        
        APIRequest.getRequest(url: url,
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
                    self?.cast = data.cast
                    self?.collectionView.reloadData()
                    
                }
            }
        }
        
    }
    
    
}


