//
//  DetailViewController.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/23/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var backImage: UIImageView! {
        didSet {
            if movie != nil {
                backImage.downloadFrom(path: movie?.backdropPath, defaultImageName: "defaultBack")
            } else {
                backImage.image = UIImage(named: "defaultBack")
            }
        }
    }

    @IBOutlet weak var progressBar: CircleProgressBar! {
        didSet {
            if movie != nil {
                progressBar.labelSize = 50
                progressBar.progress = (movie?.voteAverage)!
            }
        }
    }

    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            if movie != nil {
                posterImage.downloadFrom(path: movie?.posterPath, defaultImageName: "defaultPoster")
            } else {
                self.posterImage.image = UIImage(named: "defaultPoster")
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            if movie != nil {
                titleLabel.text = movie?.title
            }
        }
    }

    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            if movie != nil {
                dateLabel.text = (movie?.releaseDate)!
            }
        }
    }

    @IBOutlet weak var overviewLabel: UILabel! {
        didSet {
            if movie != nil {
                overviewLabel.text = movie?.overview
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red:0.09, green:0.11, blue:0.14, alpha:0.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:0.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:1.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:1.0).cgColor]
        gradient.locations = [0, 0.25, 0.55, 1]
        gradientView.layer.addSublayer(gradient)

        progressBar.setProgress(withAnimation: true)
    }
    
}
