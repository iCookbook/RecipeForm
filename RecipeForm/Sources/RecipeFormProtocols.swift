//
//  RecipeFormProtocols.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation
import Models
import Persistence

public protocol RecipeFormDependenciesProtocol {
    var moduleOutput: RecipeFormModuleOutput? { get set }
    var dataModel: Persistence.Recipe? { get }
    var coreDataManager: CoreDataManagerProtocol { get }
}

public protocol RecipeFormModuleInput {
    var moduleOutput: RecipeFormModuleOutput? { get }
}

public protocol RecipeFormModuleOutput: AnyObject {
    func recipeFormModuleDidFinish()
}

protocol RecipeFormViewInput: AnyObject {
    func displayData(_ recipeData: RecipeData)
    func changeBarButtonEnabledState(_ flag: Bool)
}

protocol RecipeFormViewOutput: AnyObject {
    func viewDidLoad()
    func checkBarButtonEnabled(_ recipeData: RecipeData)
    
    func saveRecipe(with recipeData: RecipeData?)
    func dismissThisModule()
}

protocol RecipeFormInteractorInput: AnyObject {
    func provideRecipeData()
    func checkBarButtonEnabled(_ recipeData: RecipeData)
    func saveRecipe(with recipeData: RecipeData)
}

protocol RecipeFormInteractorOutput: AnyObject {
    func didProvideRecipeData(_ recipeData: RecipeData)
    func didCheckBarButtonEnabled(_ result: Bool)
}

protocol RecipeFormRouterInput: AnyObject {
}

protocol RecipeFormRouterOutput: AnyObject {
}
