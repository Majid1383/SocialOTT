//
//  MovieDetailedViewController + CollectionView.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 03/12/24.
//

import UIKit

extension MovieDetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
     
    func setupCollectionView()
    {
        self.movieDetailSubTypesCV.delegate = self
        self.movieDetailSubTypesCV.dataSource = self
        
        registerCell()
    }
    
    func registerCell()
    {
        let nib = UINib(nibName: "MovieDetailedSubTopicCell", bundle: nil)
        self.movieDetailSubTypesCV?.register(nib, forCellWithReuseIdentifier: "MovieDetailedSubTopicCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        selectedIndex = indexPath.row
        
        // Remove existing views
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        // Add the selected view to container
        if selectedIndex == 0 {
            addViewToContainer(aboutView)
        } else if selectedIndex == 1 {
            let castView = CastViewClass()
            
            // Set the movieId directly
            castView.movieId = self.movieId // Pass the relevant movieId
            
            addViewToContainer(castView)
            print("PUT cast here with movieId:", castView.movieId ?? "No ID")
            
        } else if selectedIndex == 2 {
            print("PUT MovieReview here")
        }
        
        movieDetailSubTypesCV.reloadData()
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return subTopicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        return MovieDetailedSubTopicCell(for: collectionView, indexPath: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 60)
    }
    
    
    
    
    func MovieDetailedSubTopicCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailedSubTopicCell", for: indexPath) as! MovieDetailedSubTopicCell
        
        cell.lblSubtopics.text = self.subTopicArray[indexPath.row]
        
        return cell
        
        
    }
    
    
}
