//
//  Request.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/21/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }

    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

struct Request {
    
    static let instance = Request()
    
    private let urlMovies = "https://api.themoviedb.org/3/movie/popular"
    private let urlImage = "https://image.tmdb.org/t/p/w1280"
    private let apiKey = "8b43cd2e4f26189664edc4db07dcdae8"

    
    func getPopularMovies(page: Int, completion: @escaping ((Result<PopMovies>) -> Void)) {

        var comp = URLComponents(string: urlMovies)
        let key = URLQueryItem(name: "api_key", value: apiKey)
        let pageNumber = URLQueryItem(name: "page", value: String(page))
        comp?.queryItems = [key, pageNumber]
        guard let url = comp?.url else { return }

        URLSession.shared.dataTask(with: url) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let data = responseData {
                do {
                    let movies = try JSONDecoder().decode(PopMovies.self, from: data)
                    completion(.success(movies))
                }
                catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion(.failure(error))
            }
        }.resume()

    }
    
    
    func getImage(path: String, completion: @escaping ((Result<Data>) -> Void)) {
    
        let url = URL(string: urlImage + path)
        URLSession.shared.dataTask(with: url!) { (responseData, response, responseError) in
            if let data = responseData {
                completion(.success(data))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion(.failure(error))
            }
        }.resume()
    }

}
