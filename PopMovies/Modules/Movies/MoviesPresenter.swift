//
//  MoviesPresenter.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/4/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol MoviesViewOutput: class {
    var router: MoviesRouterInput! { get }
    func configureView()
    func didSelectItemAt(indexPath: IndexPath)
}

protocol MoviesInteractorOutput: class {
    func didFetchedWithSuccess(modelArray: [Movie])
    func didFetchWithFailure(modelArray: [Movie])
}

class MoviesPresenter {
    
    weak var view: MoviesViewInput!
    var interactor: MoviesInteractorInput!
    var router: MoviesRouterInput!
    
    required init(view: MoviesViewInput) {
        self.view = view
    }

}

extension MoviesPresenter: MoviesViewOutput {

    func configureView() {
        interactor.getMovies(page: view.page)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        router.showDetailView(with: indexPath.row)
    }
}

extension MoviesPresenter: MoviesInteractorOutput {
    func didFetchedWithSuccess(modelArray: [Movie]) {
        view.page += 1
        view.reloadCollection(with: modelArray)
    }
    
    func didFetchWithFailure(modelArray: [Movie]) {
        view.reloadCollection(with: modelArray)
        view.showAlert()
    }
}
