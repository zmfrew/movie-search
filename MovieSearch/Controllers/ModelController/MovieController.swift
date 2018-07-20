//
//  MovieController.swift
//  MovieSearch
//
//  Created by Zachary Frew on 7/20/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MovieController {
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")!
    static let imageURL = URL(string: "http://image.tmdb.org/t/p/w500/")!
    
    // MARK: - Methods
    static func retrieveMovies(_ searchText: String, completion: @escaping ([Movie]) -> Void) {
        guard var components = URLComponents(url: MovieController.baseURL, resolvingAgainstBaseURL: true) else { completion([]) ; return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "c5c1f4910df19b60d4b5657cf2225704")
        let languageQuery = URLQueryItem(name: "language", value: "en-US")
        let movieQuery = URLQueryItem(name: "query", value: searchText)
        components.queryItems = [apiQuery, languageQuery, movieQuery]
        
        guard let url = components.url else { completion([]) ; return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error occurred while retrieving data: \(error.localizedDescription).")
                completion([])
                return
            }
            
            guard let data = data else { completion([]) ; return }

            do {
                guard let topLevelDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { completion([]) ; return }
                guard let moviesDict = topLevelDict["results"] as? [[String: Any]] else { completion([]) ; return }
                var movies: [Movie] = []
                for movieDict in moviesDict {
                    if let newMovie = Movie(dict: movieDict) {
                        movies.append(newMovie)
                    }
                }
                completion(movies)
            } catch {
                print("Error occurred decoding JSON: \(error.localizedDescription).")
                completion([])
            }
        }.resume()
    }

    static func retrieveImageFor(movie: Movie, completion: @escaping(UIImage?) -> Void) {
        guard let movieURLAsString = movie.imageURLExtension else { completion(nil) ; return }
        
        let url = MovieController.imageURL
        let fullURL = url.appendingPathComponent(movieURLAsString)

        URLSession.shared.dataTask(with: fullURL) { (data, _, error) in
            if let error = error {
                print("Error occurred retrieving image: \(error.localizedDescription).")
                completion(nil)
                return
            }
    
            guard let data = data else { completion(nil) ; return }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
}
