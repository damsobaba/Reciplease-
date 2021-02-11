//
//  receipe.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 08/12/2020.
//


import Foundation

// MARK: - Welcome
struct Recipes: Decodable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String?
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
  
}




// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let weight: Double
    let image: String?
}

