//
//  RecipeFormPresenter.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Models

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
    
    func saveRecipe(with recipeData: RecipeData?) {
        guard let data = recipeData else { return } // do nothing
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.interactor.saveRecipe(with: data)
        }
    }
    
    /// Handles calling `viewDidLoad` method from view.
    func viewDidLoad() {
        interactor.provideRecipeData()
    }
    
    /// Tells module's output to close this module.
    func dismissThisModule() {
        moduleOutput?.recipeFormModuleDidFinish()
    }
}

extension RecipeFormPresenter: RecipeFormInteractorOutput {
    
    /// Provides recipe data from interactor to view.
    ///
    /// - Parameter recipeData: Recipe data to provide.
    func didProvideRecipeData(_ recipeData: RecipeData) {
        view?.displayData(recipeData)
    }
}

extension RecipeFormPresenter: RecipeFormRouterOutput {
}
