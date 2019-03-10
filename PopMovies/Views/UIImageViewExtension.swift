//
//  UIImageViewExtension.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/26/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadFrom(path: String?, defaultImageName: String)
    {
        let urlString = "https://image.tmdb.org/t/p/w1280"
        guard let p = path, let url = URL(string: urlString + p) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (responseData, response, responseError) in
            guard let data = responseData, let im = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: defaultImageName)
                    self.layoutSubviews()
                }
                return
            }
            DispatchQueue.main.async {
                self.image = im
                self.layoutSubviews()
            }
        }.resume()
    }

}
