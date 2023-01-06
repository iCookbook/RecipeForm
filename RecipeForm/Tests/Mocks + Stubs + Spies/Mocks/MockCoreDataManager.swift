//
//  MockCoreDataManager.swift
//  Personal-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import Persistence
import Models

class MockCoreDataManager: CoreDataManagerProtocol {
    
    func fetchRecipes() -> [Persistence.Recipe]? {
        nil
    }
    
    func fetchRecipe(by data: RecipeData) -> Persistence.Recipe? {
        nil
    }
    
    func createRecipe(with data: RecipeData) {
    }
    
    func update(_ recipe: Persistence.Recipe, with data: RecipeData) {
    }
    
    func delete(_ recipe: Persistence.Recipe) {
    }
    
    func createStep(with data: StepData, for recipe: Persistence.Recipe) {
    }
    
    func update(_ step: Step, with data: StepData) {
    }
    
    func delete(_ step: Step) {
    }
}
