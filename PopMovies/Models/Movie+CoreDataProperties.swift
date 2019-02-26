//
//  Movie+CoreDataProperties.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/24/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    
    @NSManaged public var backdropPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    
    
    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }

}
