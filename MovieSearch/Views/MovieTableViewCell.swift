//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Zachary Frew on 7/20/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        descriptionLabel.text = movie.description
        movieImageView.image = nil
        MovieController.retrieveImageFor(movie: movie) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
    
}
