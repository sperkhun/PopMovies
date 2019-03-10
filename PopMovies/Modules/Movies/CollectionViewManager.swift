//
//  CollectionViewManager.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/26/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewManager: NSObject {
    
    weak var viewController: MoviesViewController!
    var movies: [Movie] = []
    let sectionInsets = UIEdgeInsets(top: 10.0,
                                     left: 25.0,
                                     bottom: 10.0,
                                     right: 25.0)
    
    required init(viewController: MoviesViewController) {
        self.viewController = viewController
    }
}

extension CollectionViewManager: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if maximumOffset - contentOffset <= 100 {
            self.viewController.presenter.configureView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewController.presenter.didSelectItemAt(indexPath: indexPath)
    }
}

extension CollectionViewManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCell
        //        cell.index = indexPath.row
        cell.titleLabel.text = movies[indexPath.row].title
        cell.score = movies[indexPath.row].voteAverage
        
        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)
        queue.async {
            cell.posterImage.downloadFrom(path: self.movies[indexPath.row].backdropPath, defaultImageName: "defaultCell")
        }
        return cell
    }
}

extension CollectionViewManager: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = viewController.view.frame.width
        let itemsPerRow: CGFloat = CGFloat(integerLiteral: Int(width / 300))
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 1.35)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
