//
//  MoviesRouter.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/4/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesRouterInput: class {
    func showDetailView(with data: Int)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class MoviesRouter: MoviesRouterInput {
    
    weak var viewController: MoviesViewController!
    
    init(viewController: MoviesViewController) {
        self.viewController = viewController
    }
    
    func showDetailView(with data: Int) {
        viewController.performSegue(withIdentifier: "segueFromMoviesToDetails", sender: data)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromMoviesToDetails" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.index = sender as? Int
        }
    }
}
