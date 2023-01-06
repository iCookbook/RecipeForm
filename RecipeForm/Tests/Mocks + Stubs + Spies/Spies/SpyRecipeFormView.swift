//
//  SpyRecipeFormView.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

@testable import RecipeForm
@testable import Models

class SpyRecipeFormView: RecipeFormViewInput {
    
    var displayedRecipeData: RecipeData!
    var barButtonFlag: Bool!
    
    func displayData(_ recipeData: RecipeData) {
        displayedRecipeData = recipeData
    }
    
    func changeBarButtonEnabledState(_ flag: Bool) {
        barButtonFlag = flag
    }
}
