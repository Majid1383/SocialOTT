//
//  MainViewController + trendingMoviesCollectionView.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //MARK: CollectionView [DATASOURCE & DELEGATE]
    func setupCollectionView()
    {
        self.trendingMoviesCollectionView.delegate = self
        self.trendingMoviesCollectionView.dataSource = self
        
        self.movieListiingCollView.delegate = self
        self.movieListiingCollView.dataSource = self
        
        self.movieListingDetailCollView.delegate = self
        self.movieListingDetailCollView.dataSource = self
        
        registerCell()
    }
    
    //MARK: Register XIB Cell's
    func registerCell()
    {
        let nib = UINib(nibName: "trendingMovieCell", bundle: nil)
        self.trendingMoviesCollectionView?.register(nib, forCellWithReuseIdentifier: "trendingMovieCell")
        
        let nib1 = UINib(nibName: "movieListingCVCell", bundle: nil)
        self.movieListiingCollView?.register(nib1, forCellWithReuseIdentifier: "movieListingCVCell")
        
        let nib2 = UINib(nibName: "movieListingDetailCVCell", bundle: nil)
        self.movieListingDetailCollView?.register(nib2, forCellWithReuseIdentifier: "movieListingDetailCVCell")
    
    }
    
    //MARK: NumberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        switch collectionView.tag
        {
        case 1 :
            if segmentOutLet.selectedSegmentIndex == 0 {
                return self.randomMoviesForDay.count
            }else {
                return self.randomMoviesForWeek.count
            }
            
        case 2 : return self.movieListingArray.count
        case 3: return self.popularMoviesDataModel.count
        
        default:
            return 0
        }
    }
    
    //MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        switch collectionView.tag
        {
            
        case 1 : return trendingMovieCell(for: collectionView, indexPath: indexPath)
        case 2 : return movieListingCVCell(for: collectionView, indexPath: indexPath)
        case 3 : return movieListingDetailCVCell(for: collectionView, indexPath: indexPath)
        
        default:
            return UICollectionViewCell()
        }
        
    }
    
    //MARK: SizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        switch collectionView.tag
        {
            
        case 1 :
            let height = collectionView.frame.height  // Make the cell height fit the collection view's height
                    let width = height * 0.7  // Adjust the width-to-height ratio as needed
                    return CGSize(width: width, height: height)
             
        case 2:
            return CGSize(width: 200, height: 50)
        
        case 3:
            let totalSpacing: CGFloat = 10 * 2 + 10 * 2 // 2 edges + 2 gaps between 3 cells
                    let availableWidth = collectionView.frame.width - totalSpacing
                    
                    // Calculate width for each cell to fit 3 cells in a row
                    let cellWidth = availableWidth / 3
                    let cellHeight = cellWidth * 1.5 // Adjust height as needed
                    
                    return CGSize(width: cellWidth, height: cellHeight)
           
        default:
            return CGSize(width: 80, height: 80)
        }
    }
    
    //MARK: DidSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch collectionView.tag {
            
        case 1:
            let vc = MovieDetailedViewController(nibName: "MovieDetailedViewController", bundle: nil)
            if segmentOutLet.selectedSegmentIndex == 0 {
                vc.movieId = self.randomMoviesForDay[indexPath.row].id
            }else {
                vc.movieId = self.randomMoviesForWeek[indexPath.row].id
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2 :
            self.selectedIndex = indexPath.row
            switch selectedIndex
            {
            case 0:
                viewModel.getNowPlayingMovies()
                print("DEBUG: getNowPlayingMovies - selectedIndex -", selectedIndex)
                
            case 1:
                viewModel.getPopulareMovies()
                print("DEBUG: getPopulareMovies - selectedIndex -", selectedIndex)
                
            case 2:
                viewModel.getTopRatedMovies()
                print("DEBUG: getTopRatedMovies - selectedIndex -", selectedIndex)
                
            case 3:
                viewModel.getUpcomingMovies()
                print("DEBUG: getUpcomingMovies - selectedIndex -", selectedIndex)
                
            default:
               break
            }
            
        case 3:
            
            let vc = MovieDetailedViewController(nibName: "MovieDetailedViewController", bundle: nil)
            
            switch selectedIndex
            {
                
            case 0: vc.movieId = nowplayingMoviesdataModel[indexPath.row].id
            case 1: vc.movieId = popularMoviesDataModel[indexPath.row].id
            case 2: vc.movieId = topRatedMoviesdataModel[indexPath.row].id
            case 3: vc.movieId = upcomingMoviesDataModel[indexPath.row].id
                
            default:
               break
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    
    //MARK: trendingMovieCell
    func trendingMovieCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trendingMovieCell", for: indexPath) as! trendingMovieCell
        
        if segmentOutLet.selectedSegmentIndex == 0
        {
            
            let movie = self.randomMoviesForDay[indexPath.item]
            cell.configure(with: movie)
            self.movieId = cell.movieID
            
        }else
        {
            let movie = self.randomMoviesForWeek[indexPath.item]
            cell.configure(with: movie)
            self.movieId = cell.movieID
        }
        
        print("DEBUG: self.movieId", self.movieId)
        return cell
    }
    
    //MARK: movieListingCVCell
    func movieListingCVCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListingCVCell", for: indexPath) as! movieListingCVCell
        
        let movieTitle = movieListingArray[indexPath.row]
        cell.configure(for: movieTitle)
        return cell
    }
    
    //MARK: movieListingDetailCVCell
    func movieListingDetailCVCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListingDetailCVCell", for: indexPath) as! movieListingDetailCVCell
        
        switch self.selectedIndex
        {
            
        case 0 :
            guard indexPath.row < self.nowplayingMoviesdataModel.count else {return cell}
            cell.configure(with: self.nowplayingMoviesdataModel[indexPath.row])
            print("DEBUG: upcomingMoviesDataModel CellForRowAt",selectedIndex)
            
        case 1 :
            guard indexPath.row < self.popularMoviesDataModel.count else {return cell}
            cell.configure(with: self.popularMoviesDataModel[indexPath.row])
            print("DEBUG: popularMoviesDataModel CellForRowAt",selectedIndex)
            
        case 2:
            guard indexPath.row < self.topRatedMoviesdataModel.count else {return cell}
            cell.configure(with: self.topRatedMoviesdataModel[indexPath.row])
            print("DEBUG: topRatedMoviesdataModel CellForRowAt",selectedIndex)
            
        case 3:
            guard indexPath.row < self.upcomingMoviesDataModel.count else {return cell}
            cell.configure(with: self.upcomingMoviesDataModel[indexPath.row])
            print("DEBUG: upcomingMoviesDataModel CellForRowAt",selectedIndex)
            
        default:
            break
        }
        return cell
    }
    
    //MARK: InsetForSectonAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5 , bottom: 5, right: 5)
    }
    
    //MARK: ScrollToFirstIndex() 
    func scrollToFirstIndex(collectionView: UICollectionView)
    {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        // Check if the collection view has items to scroll to
        DispatchQueue.main.async
        {
            if collectionView.numberOfSections > 0 && collectionView.numberOfItems(inSection: 0) > 0
            {
                collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)
            }
        }
        
    }
    
}



