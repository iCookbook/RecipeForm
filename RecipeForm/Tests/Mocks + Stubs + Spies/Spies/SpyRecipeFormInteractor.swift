//
//  SpyRecipeFormInteractor.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

import XCTest
@testable import RecipeForm
@testable import Models

class SpyRecipeFormInteractor: RecipeFormInteractorInput {
    
    var didProvideRecipeData: Bool!
    var recipeDataCheckWith: RecipeData!
    var recipeDataToSave: RecipeData!
    
    var expectation: XCTestExpectation!
    
    func provideRecipeData() {
        didProvideRecipeData = true
    }
    
    func checkBarButtonEnabled(_ recipeData: RecipeData) {
        recipeDataCheckWith = recipeData
    }
    
    func saveRecipe(with recipeData: RecipeData) {
        recipeDataToSave = recipeData
        
        if let expectation = expectation {
            expectation.fulfill()
        }
    }
}
