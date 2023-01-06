//
//  SpyRecipeFormModuleOutput.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

import RecipeForm

class SpyRecipeFormModuleOutput: RecipeFormModuleOutput {
    
    var recipeFormModuleDidFinishFlag: Bool!
    
    func recipeFormModuleDidFinish() {
        recipeFormModuleDidFinishFlag = true
    }
}
