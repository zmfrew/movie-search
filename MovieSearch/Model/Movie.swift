//
//  Movie.swift
//  MovieSearch
//
//  Created by Zachary Frew on 7/20/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

struct Movie {
    
    // MARK: - Properties
    let title: String
    let rating: Float
    let description: String
    let imageURLExtension: String?
    
    init?(dict: [String : Any]) {
        guard let title = dict[CodingKeys.title.rawValue] as? String,
            let rating = dict[CodingKeys.rating.rawValue] as? Float,
            let description = dict[CodingKeys.description.rawValue] as? String,
            let imageURLExtension = dict[CodingKeys.imageURL.rawValue] as? String
            else { return nil }
        
        self.title = title
        self.rating = rating
        self.description = description
        self.imageURLExtension = imageURLExtension
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case description = "overview"
        case imageURL = "poster_path"
    }
    
}
