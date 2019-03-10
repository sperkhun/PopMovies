//
//  MoviesConfigurator.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/4/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol MoviesConfiguratorProtocol: class {
    func configure(with viewController: MoviesViewController)
}

class MoviesConfigurator: MoviesConfiguratorProtocol {
    func configure(with viewController: MoviesViewController) {
        let presenter = MoviesPresenter(view: viewController)
        let interactor = MoviesInteractor(presenter: presenter)
        let router = MoviesRouter(viewController: viewController)
        let collectionManager = CollectionViewManager(viewController: viewController)
        
        viewController.presenter = presenter
        viewController.collectionManager = collectionManager
        presenter.interactor = interactor
        presenter.router = router
    }
}
