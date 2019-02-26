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
        
        if let p = path {
            Request.instance.getImage(path: p) { (result) in
                switch result {
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.image = UIImage(named: defaultImageName)
                        self.layoutSubviews()
                    }
                case .success(let data):
                    if let im = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = im
                            self.layoutSubviews()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.image = UIImage(named: defaultImageName)
                            self.layoutSubviews()
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = UIImage(named: defaultImageName)
                self.layoutSubviews()
            }
        }
    }
    
}
