//
//  PopMoviesViewController+CollectionViewDelegate.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/26/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import UIKit

extension PopMoviesViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoading && page <= totalPages && maximumOffset - contentOffset <= 100 {
            isLoading = true
            self.makeRequest()
        }
    }

}
