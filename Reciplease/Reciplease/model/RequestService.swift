//
//  ReceipeService.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//

import Foundation
import Alamofire


var key = "f80904bfd20af14390731a06fca44c7e"
var id = "5dd13b2f"




final class RequestService {

    // MARK: - Properties

    private let session: AlamofireSession

    // MARK: - Initializer

    init(session: AlamofireSession = ReceipeSession()) {
        self.session = session
    }

    // MARK: - Management

    func getData(q: String,  callback: @escaping (Result<Recipes, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search") else { return }
        let parameters =  [("app_id", id), ("app_key", key), ("q", q)]
        let encoding = encode(baseUrl: url, with: parameters)
        Logger(url: url).show()
        session.request(url: encoding ) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.noResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(Recipes.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
    
    
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
