//
//  PopMoviesViewController.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/19/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class PopMoviesViewController: UIViewController {
    
    var page = 1
    var totalPages = 1
    var isLoading = true
    var dbWasLoad = false
    let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 25.0,
                                             bottom: 10.0,
                                             right: 25.0)

    var movies: [Movie] = []
    var cellImages: [UIImage?] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromPopMoviesToDetails" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! FilmCell
            detailVC.movie = movies[cell.index]
        }
    }
    
    func makeRequest() {
        Request.instance.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                if movies.results != nil {
                    DispatchQueue.main.async {
                        self.page += 1
                        self.totalPages = movies.totalPages!
                        self.movies += movies.results!
                        self.collectionView.reloadData()
                        MovieManager.instance.saveContext()
                    }
                } else if self.dbWasLoad == false {
                    DispatchQueue.main.async {
                        self.dbWasLoad = true
                        self.movies = MovieManager.instance.findFilms()
                        self.collectionView.reloadData()
                        self.showAlert()
                    }
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                if self.dbWasLoad == false {
                    DispatchQueue.main.async {
                        self.dbWasLoad = true
                        self.movies = MovieManager.instance.findFilms()
                        self.collectionView.reloadData()
                        self.showAlert()
                    }
                }
            }
            self.isLoading = false
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "Uh oh, it seems like something went wrong. To see the actual information, please, try it later.", preferredStyle: .alert)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }

}
