//
//  RecipeFormAssembly.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import UIKit
import Persistence

public final class RecipeFormAssembly {
    
    // MARK: - Public Properties
    
    public let input: RecipeFormModuleInput
    public let viewController: UIViewController
    
    // MARK: - Private Properties
    
    private(set) weak var router: RecipeFormRouterInput!
    
    // MARK: - Public Methods
    
    public static func assemble(with context: RecipeFormContext) -> RecipeFormAssembly {
        let router = RecipeFormRouter()
        let interactor = RecipeFormInteractor()
        let presenter = RecipeFormPresenter(router: router, interactor: interactor)
        let viewController = RecipeFormViewController(presenter: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.presenter = presenter
        interactor.recipe = context.recipe
        
        router.viewController = viewController
        router.presenter = presenter
        
        return RecipeFormAssembly(view: viewController, input: presenter, router: router)
    }
    
    // MARK: - Init
    
    private init(view: UIViewController, input: RecipeFormModuleInput, router: RecipeFormRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

public struct RecipeFormContext {
    weak var moduleOutput: RecipeFormModuleOutput?
    let recipe: Recipe?
    
    public init(moduleOutput: RecipeFormModuleOutput?, recipe: Recipe?) {
        self.moduleOutput = moduleOutput
        self.recipe = recipe
    }
}
