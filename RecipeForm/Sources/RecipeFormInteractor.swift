//
//  RecipeFormInteractor.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation
import Persistence
import Models

final class RecipeFormInteractor {
    weak var presenter: RecipeFormInteractorOutput?
    
    let coreDataManager: CoreDataManagerProtocol
    var recipe: Persistence.Recipe?
    
    init(coreDataManager: CoreDataManagerProtocol, recipe: Persistence.Recipe?) {
        self.coreDataManager = coreDataManager
        self.recipe = recipe
    }
}

extension RecipeFormInteractor: RecipeFormInteractorInput {
    
    /// Converts recipe from persistence to entity to display in view.
    func provideRecipeData() {
        guard let recipe = recipe else {
            /// Provide empty recipe data.
            presenter?.didProvideRecipeData(RecipeData.default)
            return
        }
        
        let steps = (recipe.steps?.array as? [Step])?.map {
            StepData(text: $0.text, imageData: $0.imageData)
        }
        
        let data = RecipeData(name: recipe.name,
                              dateCreated: recipe.dateCreated,
                              numberOfServings: recipe.numberOfServings,
                              proteins: recipe.proteins,
                              fats: recipe.fats,
                              carbohydrates: recipe.carbohydrates,
                              calories: recipe.calories,
                              cookingTime: recipe.cookingTime,
                              comment: recipe.comment,
                              ingredients: recipe.ingredients,
                              imageData: recipe.imageData,
                              steps: steps)
        
        presenter?.didProvideRecipeData(data)
    }
    
    /// Checks that all required fileds are filled.
    ///
    /// - Parameter recipeData: Recipe data to check.
    func checkBarButtonEnabled(_ recipeData: RecipeData) {
        presenter?.didCheckBarButtonEnabled(!recipeData.name.isEmpty &&
                                            recipeData.numberOfServings != 0 &&
                                            recipeData.cookingTime != 0)
    }
    
    /// Saves or updates recipe. It depends on was recipe provided or not (`nil`).
    ///
    /// - Parameter recipeData: New recipe data.
    func saveRecipe(with recipeData: RecipeData) {
        
        guard let recipe = recipe else {
            coreDataManager.createRecipe(with: recipeData)
            return
        }
        
        coreDataManager.update(recipe, with: recipeData)
    }
}
