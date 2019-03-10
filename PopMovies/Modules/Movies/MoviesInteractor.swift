//
//  MoviesInteractor.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/4/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol MoviesInteractorInput: class {
    func getMovies(page: Int)
}

class MoviesInteractor: MoviesInteractorInput {
    
    weak var presenter: MoviesInteractorOutput!
    var apiService: APIServiceProtocol = APIService()

    var movies: [Movie] = []
    var totalPages = 1
    var dbWasLoad = false
    var isLoading = false
    
    
    required init(presenter: MoviesInteractorOutput) {
        self.presenter = presenter
    }

    func getMovies(page: Int) {
        if page <= totalPages && !isLoading {
            isLoading = true
            apiService.getPopularMovies(page: page) { (result) in
                guard let movies = result?.results, let pages = result?.totalPages else {
                    DispatchQueue.main.async {
                        self.getMoviesFromDB()
                    }
                    return
                }
                self.totalPages = pages
                self.movies = page == 1 ? movies : self.movies + movies
                DBService.instance.saveContext()
                DispatchQueue.main.async {
                    self.presenter.didFetchedWithSuccess(modelArray: self.movies)
                }
                self.isLoading = false
            }
        }
    }
    
    func getMoviesFromDB() {
        if !dbWasLoad {
            dbWasLoad = true
            movies = DBService.instance.findFilms()
            presenter.didFetchWithFailure(modelArray: movies)
        }
    }
}
