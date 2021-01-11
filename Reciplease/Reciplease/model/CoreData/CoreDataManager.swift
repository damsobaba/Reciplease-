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

    var favoriteFood: [FavoriteFood] {
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

    
    func deleteRecipeFromFavorite(recipeName: String) {
          let request: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
          let predicate = NSPredicate(format: "name == %@", recipeName)
          request.predicate = predicate
          if let objects = try? managedObjectContext.fetch(request) {
              objects.forEach { managedObjectContext.delete($0)}
          }
          coreDataStack.saveContext()
      }
    
    
    // MARK: - Manage Task Entity

    func createIngredients(name: String, image: String, yield: String, totalTime: String, ingredients: [String]) {
        let food = FavoriteFood(context: managedObjectContext)
        food.name = name
        food.image = image
        food.yield = yield
        food.totaTime = totalTime
        food.ingredients = ingredients.joined()
        
        coreDataStack.saveContext()
    }

    func deleteAllIngredients() {
        favoriteFood.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
