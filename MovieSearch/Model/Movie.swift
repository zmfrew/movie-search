//
//  Movie.swift
//  MovieSearch
//
//  Created by Zachary Frew on 7/20/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Movie]
}

struct Movie: Codable {
    
    // MARK: - Properties
    let title: String
    let rating: Float
    let description: String
    let imageURLExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case description = "overview"
        case imageURLExtension = "poster_path"
    }
    
}
