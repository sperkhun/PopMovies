//
//  DetailPresenter.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/9/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol DetailViewOutput: class {
    func configureView()
    func backButtonClicked()
}

protocol DetailInteractorOutput: class {
    func didFetchData(movie: Movie)
}

class DetailPresenter {
    
    weak var view: DetailViewInput!
    var interactor: DetailInteractorInput!
    var router: DetailRouterInput!
    
    required init(view: DetailViewInput) {
        self.view = view
    }
    
}

extension DetailPresenter: DetailViewOutput {
    
    func configureView() {
        interactor.getDetail(index: view.index!)
    }
    
    func backButtonClicked() {
        router.closeCurrentViewController()
    }
}

extension DetailPresenter: DetailInteractorOutput {
    
    func didFetchData(movie: Movie) {
        view.setBackImage(with: movie.backdropPath!)
        view.setDateLabel(with: movie.releaseDate!)
        view.setTitleLabel(with: movie.title!)
        view.setPosterImage(with: movie.posterPath!)
        view.setOverviewLabel(with: movie.overview!)
        view.setProgressBar(with: movie.voteAverage)
    }
}
