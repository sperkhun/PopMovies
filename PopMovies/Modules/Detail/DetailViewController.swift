//
//  DetailViewController.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/23/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

protocol DetailViewInput: class {

    var index: Int? { get }
    func setBackImage(with imagePath: String)
    func setPosterImage(with imagePath: String)
    func setProgressBar(with average: Double)
    func setTitleLabel(with title: String)
    func setDateLabel(with date: String)
    func setOverviewLabel(with overview: String)
}

class DetailViewController: UIViewController, DetailViewInput {
    
    let configurator: DetailConfiguratorProtocol = DetailConfigurator()
    var presenter: DetailViewOutput!
    
    var index: Int?
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var progressBar: CircleProgressBar!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red:0.09, green:0.11, blue:0.14, alpha:0.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:0.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:1.0).cgColor, UIColor(red:0.09, green:0.11, blue:0.14, alpha:1.0).cgColor]
        gradient.locations = [0, 0.25, 0.55, 1]
        gradientView.layer.addSublayer(gradient)
        
        let customBackButton = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action: #selector(backAction(sender:)))
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton

        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        presenter.backButtonClicked()
    }
    
    func setBackImage(with imagePath: String) {
        backImage.downloadFrom(path: imagePath, defaultImageName: "defaultBack")
    }
    
    func setProgressBar(with average: Double) {
        progressBar.labelSize = 50
        progressBar.progress = average
        progressBar.setProgress(withAnimation: true)
    }
    
    func setPosterImage(with imagePath: String) {
        posterImage.downloadFrom(path: imagePath, defaultImageName: "defaultPoster")
    }
    
    func setTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    func setDateLabel(with date: String) {
        dateLabel.text = date
    }
    
    func setOverviewLabel(with overview: String) {
        overviewLabel.text = overview
    }
    
}
