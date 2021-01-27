//
//  CoreDataManagerTest.swift
//  RecipleaseTests
//
//  Created by Adam Mabrouki on 15/01/2021.
//
@testable import Reciplease
import XCTest

    final class CoreDataManagerTests: XCTestCase {

        // MARK: - Properties

        var coreDataStack: MockCoreDataStack!
        var coreDataManager: CoreDataManager!

        //MARK: - Tests Life Cycle

        override func setUp() {
            super.setUp()
            coreDataStack = MockCoreDataStack()
            coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        }

        override func tearDown() {
            super.tearDown()
            coreDataManager = nil
            coreDataStack = nil
        }

        // MARK: - Tests

        func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
            // renomer la methode
            coreDataManager.createRecipe(name: "potatoe", image: Data(), yield: "", totalTime:"", ingredients: [""], url: "https://api.edamam.com/search?q=potatoe")
            XCTAssertTrue(!coreDataManager.favoriteFoods.isEmpty)
            XCTAssertTrue(coreDataManager.favoriteFoods.count == 1)
            XCTAssertTrue(coreDataManager.favoriteFoods[0].name! == "potatoe")
        }

        func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
            coreDataManager.createRecipe(name: "potatoe", image: Data(), yield: "", totalTime: "", ingredients: [""], url: "https://api.edamam.com/search?q=potatoe")
            coreDataManager.deleteAllIngredients()
            XCTAssertTrue(coreDataManager.favoriteFoods.isEmpty)
        }
        
        
        
    }



