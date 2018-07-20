//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Zachary Frew on 7/20/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
 
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Methods
    func updateViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        descriptionLabel.text = movie.description
        
        MovieController.retrieveImageFor(movie: movie) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
    
}
