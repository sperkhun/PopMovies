//
//  PopMovies.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/21/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

struct PopMovies: Decodable {

    let results: [Movie]?
    let page: Int?
    let totalPages: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let p = try container.decodeIfPresent(Int.self, forKey: .page)
        if p != nil && p == 1 {
            MovieManager.instance.deleteAll()
        }
        self.page = p
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.results = try container.decodeIfPresent([Movie].self, forKey: .results)
    }

}
