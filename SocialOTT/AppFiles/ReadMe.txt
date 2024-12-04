//
//  ReadMe.txt
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 03/12/24.
//

SOCIALOTT

This app fetches movie trailers and displays them in a collection view. Users can watch trailers directly in the app with a muted background video player for a seamless experience.


Architecture Explanation
The app uses the MVVM (Model-View-ViewModel) or MVC (Model-View-Controller) architecture for clean and maintainable code.

1. Model
Handles the data logic and API response mapping.
Example: Movie, Trailer.
2. View
Composed of UI elements such as UICollectionView, UIActivityIndicatorView, and custom XIB cells.
Example: MovieCell.xib, MovieViewController.swift.
3. ViewModel/Controller
Manages the data flow between the Model and the View.
Handles API calls and processes data for display.
Example: MovieViewModel.swift or MovieViewController.swift


YouTubePlayer-in-WKWebView:
To embed and play YouTube trailers seamlessly.

SD_WEBImage:
To fetch the Images and show.


