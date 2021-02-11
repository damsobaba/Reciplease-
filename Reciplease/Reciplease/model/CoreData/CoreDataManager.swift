//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Adam Mabrouki on 14/12/2020.
//


import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoriteFoods: [FavoriteFood] {
        let request: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    /// Manage  Favorite Recipes List entities
    func createRecipe(name: String, image: Data, yield: String, totalTime: String, ingredients: [String], url: String) {
        let food = FavoriteFood(context: managedObjectContext)
        food.name = name
        food.image = image
        food.yield = yield
        food.totaTime = totalTime
        food.ingredients = ingredients
        food.url = url
        coreDataStack.saveContext()
    }
    /// Delete all
    func deleteAllRecipe() {
        favoriteFoods.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    
    func checkIfRecipeIsAlreadyFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipeName)
        request.predicate = predicate
        guard let favoritesFoods = try? managedObjectContext.fetch(request) else { return false }
        if favoritesFoods.isEmpty {
            return false
        }
        return true
    }
    
    
    
    func deleteFromFavorite(recipeName: String) {
        let request: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipeName)
        request.predicate = predicate
        guard let objects = try? managedObjectContext.fetch(request) else { return }
        objects.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
}







