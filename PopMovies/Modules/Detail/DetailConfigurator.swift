//
//  DetailConfigurator.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/9/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol DetailConfiguratorProtocol: class {
    func configure(with viewController: DetailViewController)
}

class DetailConfigurator: DetailConfiguratorProtocol {
    func configure(with viewController: DetailViewController) {
        let presenter = DetailPresenter(view: viewController)
        let interactor = DetailInteractor(presenter: presenter)
        let router = DetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
