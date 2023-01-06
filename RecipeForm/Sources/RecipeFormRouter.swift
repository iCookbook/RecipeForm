//
//  RecipeFormRouter.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import UIKit

final class RecipeFormRouter {
    weak var presenter: RecipeFormRouterOutput?
    weak var viewController: UIViewController?
}

extension RecipeFormRouter: RecipeFormRouterInput {
}
