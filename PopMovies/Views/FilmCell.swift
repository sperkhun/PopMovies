//
//  FilmCell.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/21/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class FilmCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
        
    var score: Double? {
        
        didSet {
            switch score {
            case _ where score! >= 7.0:
                scoreLabel.textColor = UIColor(red:0.39, green:0.80, blue:0.51, alpha:1.0)
            case _ where score! >= 4.0:
                scoreLabel.textColor = UIColor(red:0.82, green:0.84, blue:0.33, alpha:1.0)
            default:
                scoreLabel.textColor = UIColor(red:0.79, green:0.22, blue:0.38, alpha:1.0)
            }
            scoreLabel.text = String(describing: score!)
        }
    }
}
