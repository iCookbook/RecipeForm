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
    var recipeData = RecipeData.default
    
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
        let steps = (recipe?.steps?.array as? [Step])?.map {
            StepData(text: $0.text, imageData: $0.imageData)
        }
        
        presenter?.didCheckBarButtonEnabled(!recipeData.name.isEmpty &&
                                             recipeData.numberOfServings != nil &&
                                             recipeData.cookingTime != nil &&
                                            (recipeData.name != recipe?.name ||
                                             recipeData.numberOfServings != recipe?.numberOfServings ||
                                             recipeData.proteins != recipe?.proteins ||
                                             recipeData.fats != recipe?.fats ||
                                             recipeData.carbohydrates != recipe?.carbohydrates ||
                                             recipeData.calories != recipe?.calories ||
                                             recipeData.cookingTime != recipe?.cookingTime ||
                                             recipeData.comment != recipe?.comment ||
                                             recipeData.ingredients != recipe?.ingredients ||
                                             recipeData.imageData != recipe?.imageData ||
                                             recipeData.steps != steps)
        )
    }
    
    /// Saves or updates recipe. It depends on was recipe provided or not (`nil`).
    ///
    /// - Parameter recipeData: New recipe data.
    func saveRecipe(with recipeData: RecipeData) {
        
        defer {
            recipe = coreDataManager.fetchRecipe(by: recipeData)
        }
        
        guard let recipe = recipe else {
            coreDataManager.createRecipe(with: recipeData)
            return
        }
        
        coreDataManager.update(recipe, with: recipeData)
    }
}
