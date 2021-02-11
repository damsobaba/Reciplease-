//
//  Loger.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 14/12/2020.
//

import Foundation


/// provide details in the console about the API  calls
struct Logger {

    // MARK: - Properties
      var url: URL
    private var request: URLRequest {
        return URLRequest(url: url)
    }

    // MARK: - Class's Methods
    func show() {
        defer {
            print("\n *****************     End     ****************** \n")
        }

        guard let httpMethod = request.httpMethod else { return }
        guard let stringUrl = request.url?.absoluteString else { return }
        guard let urlComponents = NSURLComponents(string: stringUrl) else { return }
        guard let host = urlComponents.host else { return }
        guard let path = urlComponents.path else { return }
        let query = urlComponents.query ?? String()

        let logOutput = """
        ** HTTP Method : \(httpMethod)
        ** URL : \(stringUrl)
        ** Host : \(host)
        ** Path : \(path)
        ** Query : \(query)
        """

        print("\n ***************** Request info ***************** \n")
        print(logOutput)
    }
}
