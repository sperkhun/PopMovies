//
//  APIService.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/21/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

protocol APIServiceProtocol: class {
    func getPopularMovies(page: Int, completion: @escaping ((PopMovies?) -> Void))
}

class APIService: APIServiceProtocol {
    
    private let urlMovies = "https://api.themoviedb.org/3/movie/popular"
    private let apiKey = "8b43cd2e4f26189664edc4db07dcdae8"

    
    func getPopularMovies(page: Int, completion: @escaping ((PopMovies?) -> Void)) {

        var comp = URLComponents(string: urlMovies)
        let key = URLQueryItem(name: "api_key", value: apiKey)
        let pageNumber = URLQueryItem(name: "page", value: String(page))
        comp?.queryItems = [key, pageNumber]
        guard let url = comp?.url else { return }

        URLSession.shared.dataTask(with: url) { (responseData, response, responseError) in
            var movies: PopMovies? = nil
            if let data = responseData {
                do {
                    movies = try JSONDecoder().decode(PopMovies.self, from: data)
                }
                catch {
                    print("Data was not retrieved from request")
                }
            }
            completion(movies)
        }.resume()

    }

}
