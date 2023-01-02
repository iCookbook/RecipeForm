//
//  RecipeFormProtocols.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation

public protocol RecipeFormModuleInput {
    var moduleOutput: RecipeFormModuleOutput? { get }
}

public protocol RecipeFormModuleOutput: AnyObject {
}

protocol RecipeFormViewInput: AnyObject {
}

protocol RecipeFormViewOutput: AnyObject {
}

protocol RecipeFormInteractorInput: AnyObject {
}

protocol RecipeFormInteractorOutput: AnyObject {
}

protocol RecipeFormRouterInput: AnyObject {
}

protocol RecipeFormRouterOutput: AnyObject {
}
