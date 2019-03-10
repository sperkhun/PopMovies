//
//  DetailRouter.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/9/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol DetailRouterInput: class {
    func closeCurrentViewController()
}

class DetailRouter: DetailRouterInput {
    
    weak var viewController: DetailViewController!
    
    init(viewController: DetailViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
