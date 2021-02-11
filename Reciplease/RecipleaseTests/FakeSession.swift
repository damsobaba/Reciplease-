//
//  FakeSession.swift
//  RecipleaseTests
//
//  Created by Adam Mabrouki on 21/01/2021.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class FakeSession: AlamofireSession {
    
    /// MARK: - Properties
    private let fakeResponse: FakeResponse
    
    /// MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    

 

    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        callback(dataResponse)
    }
    
    
    
}
