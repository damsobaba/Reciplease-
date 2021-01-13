//
//  NetworkError.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//

import UIKit
import Foundation
enum NetworkError: Error {
    case noData, noResponse, undecodableData
    var description: String {
        switch self {
        case .noData:
            return "There is no data !"
        case .noResponse:
            return "Response status is incorrect !"
        case .undecodableData:
            return "Data can't be decoded !"
        }
    }
}
