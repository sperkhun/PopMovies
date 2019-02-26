//
//  PopMoviesViewController+CollectionViewDataSource.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/26/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import UIKit

extension PopMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCell
        cell.index = indexPath.row
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
