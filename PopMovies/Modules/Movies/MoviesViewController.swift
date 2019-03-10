//
//  MoviesViewController.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/19/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

protocol MoviesViewInput: class {
    var page: Int { get set }
    func reloadCollection(with data: [Movie])
    func showAlert()
}

class MoviesViewController: UIViewController {
    
    let configurator: MoviesConfiguratorProtocol = MoviesConfigurator()
    var presenter: MoviesViewOutput!
    var collectionManager: CollectionViewManager!

    var page = 1

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(with: self)
        collectionView.delegate = collectionManager
        collectionView.dataSource = collectionManager
        presenter.configureView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
}

extension MoviesViewController: MoviesViewInput {
    
    func reloadCollection(with data: [Movie]) {
        self.collectionManager.movies = data
        self.collectionView.reloadData()
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
