//
//  NetworkManager.swift
//  HiveAI
//
//  Created by Sannica.Gupta on 27/02/24.
//

import Foundation

enum NetworkError: Error {
    case apiError
    case urlError
}

protocol Usecase {
    func fetchData(searchData: SearchData, completion: @escaping ((Result<SearchResponseData, NetworkError>) -> ()))
}

final class NetworkManager: Usecase {
    static let shared = NetworkManager()
    private init() {} //singleton
    private var baseUrlString: String {
        return "https://en.wikipedia.org/w/api.php"
    }
    
    func fetchData(searchData: SearchData,
                   completion: @escaping ((Result<SearchResponseData, NetworkError>) -> ())){
        
        let queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "generator", value: "search"),
            URLQueryItem(name: "gsrnamespace", value: "0"),
            URLQueryItem(name: "gsrsearch", value: searchData.searchString),
            URLQueryItem(name: "gsrlimit", value: "\(searchData.gsrlimit)"),
            URLQueryItem(name: "prop", value: "pageimages|extracts"),
            URLQueryItem(name: "pilimit", value: "max"),
            URLQueryItem(name: "exintro", value: ""),
            URLQueryItem(name: "explaintext", value: ""),
            URLQueryItem(name: "exsentences", value: "1"),
            URLQueryItem(name: "exlimit", value: "max")
        ]
        
        var urlComps = URLComponents(string: self.baseUrlString)
        urlComps?.queryItems = queryItems
        
        guard let urlSearch = urlComps?.url else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: urlSearch) { data, response, error in
            if error == nil,
               let responseData = data,
               let response = try? JSONDecoder().decode(SearchResponseData.self, from: responseData) {
                completion(.success(response))
               } else {
                   completion(.failure(.apiError))
               }
        }.resume()
    }
}
