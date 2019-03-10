//
//  DetailInteractor.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 3/9/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol DetailInteractorInput: class {
    func getDetail(index: Int)
}

class DetailInteractor: DetailInteractorInput {
    
    weak var presenter: DetailInteractorOutput!
    
    required init(presenter: DetailInteractorOutput) {
        self.presenter = presenter
    }
    
    func getDetail(index: Int) {
        let array = DBService.instance.findFilms()
        if index < array.count {
            presenter.didFetchData(movie: array[index])
        }
    }
}
