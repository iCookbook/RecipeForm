//
//  RecipeFormPresenter.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation

final class RecipeFormPresenter {
    weak var view: RecipeFormViewInput?
    weak var moduleOutput: RecipeFormModuleOutput?
    
    // MARK: - Private Properties
    
    private let router: RecipeFormRouterInput
    private let interactor: RecipeFormInteractorInput
    
    // MARK: - Init
    
    init(router: RecipeFormRouterInput, interactor: RecipeFormInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RecipeFormPresenter: RecipeFormModuleInput {
}

extension RecipeFormPresenter: RecipeFormViewOutput {
}

extension RecipeFormPresenter: RecipeFormInteractorOutput {
}

extension RecipeFormPresenter: RecipeFormRouterOutput {
}
