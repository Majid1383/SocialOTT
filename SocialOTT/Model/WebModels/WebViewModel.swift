//
//  WebViewModel.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 03/12/24.
//

import Foundation

//struct VideoResponse: Codable {
//    let results: [Video]
//}
//
//struct Video: Codable
//{
//    let id: String
//    let key: String
//    let name: String
//    let site: String
//    let type: String
//    let official: Bool?
//
//    enum CodingKeys: String, CodingKey
//    {
//        case id, key, name, site, type, official
//    }
//}

// Main response model for videos
//struct VideoResponse: Codable {
//    let id: Int
//    let results: [Video]
//}
//
//// Represents each individual video
//struct Video: Codable {
//    let id: String
//    let key: String  // YouTube video key
//    let name: String
//    let site: String
//    let type: String
//    let publishedAt: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case key
//        case name
//        case site
//        case type
//        case publishedAt = "published_at"
//    }
//}

struct TrailerResponse: Codable
{
    let results: [Trailer]
}

struct Trailer: Codable
{
    let id: String
    let key: String // YouTube video ID
    let name: String
    let site: String // Should be "YouTube"
    let type: String // Trailer, Teaser, etc.
}
