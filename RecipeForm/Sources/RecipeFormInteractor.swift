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
    
    var recipe: Persistence.Recipe!
}

extension RecipeFormInteractor: RecipeFormInteractorInput {
    
    /// Converts recipe from persistence to entity to display in view.
    func provideRecipeData() {
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
}
