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

    var food: [Food] {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
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

    func createIngredients(name: String) {
        let food = Food(context: managedObjectContext)
        food.name = name
        coreDataStack.saveContext()
    }

    func deleteAllIngredients() {
        food.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
