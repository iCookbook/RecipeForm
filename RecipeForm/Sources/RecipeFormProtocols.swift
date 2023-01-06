//
//  RecipeFormProtocols.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation
import Models

public protocol RecipeFormModuleInput {
    var moduleOutput: RecipeFormModuleOutput? { get }
}

public protocol RecipeFormModuleOutput: AnyObject {
    func recipeFormModuleDidFinish()
}

protocol RecipeFormViewInput: AnyObject {
    func displayData(_ recipeData: RecipeData)
}

protocol RecipeFormViewOutput: AnyObject {
    func viewDidLoad()
    
    func dismissThisModule()
}

protocol RecipeFormInteractorInput: AnyObject {
    func provideRecipeData()
}

protocol RecipeFormInteractorOutput: AnyObject {
    func didProvideRecipeData(_ recipeData: RecipeData)
}

protocol RecipeFormRouterInput: AnyObject {
}

protocol RecipeFormRouterOutput: AnyObject {
}
