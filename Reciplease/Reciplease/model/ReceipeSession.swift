//
//  ReceipeSessio,.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

final class ReceipeSession: AlamofireSession {

    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}
