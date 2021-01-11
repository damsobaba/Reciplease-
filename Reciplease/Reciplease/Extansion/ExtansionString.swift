//
//  ExtansionString.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/01/2021.
//

import Foundation
extension String {
    /**
     * Check if a string contains at least one element
     */
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}

