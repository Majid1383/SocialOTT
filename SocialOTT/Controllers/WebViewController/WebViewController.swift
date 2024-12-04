//
//  WebViewController.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 03/12/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController
{
    @IBOutlet weak var webView: WKWebView!
    
    var movieId: Int = 0
    var webViewDataModel : [Trailer] = []
    var urlString : String = ""
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupWebView()
        loadYouTubeVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWebView()
        loadYouTubeVideo()
    }
    
    
    //    private func setupWebView()
    //    {
    //        let webConfiguration = WKWebViewConfiguration()
    //        webView = WKWebView(frame: .zero, configuration: webConfiguration)
    //        webView.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(webView)
    //
    //        NSLayoutConstraint.activate([
    //            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    //            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    //            webView.topAnchor.constraint(equalTo: view.topAnchor),
    //            webView.heightAnchor.constraint(equalToConstant: 300)  // Adjust height as needed
    //        ])
    //    }
    
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webConfiguration.allowsInlineMediaPlayback = false
        webConfiguration.allowsAirPlayForMediaPlayback = true
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // Ensures it starts below the status bar
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // Ensures it goes to the bottom
        ])
    }
    
    
    private func loadYouTubeVideo()
    {
        let fullScreenURL = "\(self.urlString)?autoplay=1&fullscreen=1"
        print("DEBUG: fullScreenURL", fullScreenURL)
        if let url = URL(string: fullScreenURL)
        {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
