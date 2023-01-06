//
//  SpyRecipeFormPresenter.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

@testable import RecipeForm
@testable import Models

class SpyRecipeFormPresenter: RecipeFormInteractorOutput {
    
    var providedRecipeData: RecipeData!
    var checkedBarButtonFlag: Bool!
    
    func didProvideRecipeData(_ recipeData: RecipeData) {
        providedRecipeData = recipeData
    }
    
    func didCheckBarButtonEnabled(_ result: Bool) {
        checkedBarButtonFlag = result
    }
}
