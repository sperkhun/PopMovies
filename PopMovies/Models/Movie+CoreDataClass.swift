//
//  Movie+CoreDataClass.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/24/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        let context = MovieManager.instance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.popularity = (try container.decodeIfPresent(Double.self, forKey: .popularity))!
        self.voteAverage = (try container.decodeIfPresent(Double.self, forKey: .voteAverage))!
    }

}
