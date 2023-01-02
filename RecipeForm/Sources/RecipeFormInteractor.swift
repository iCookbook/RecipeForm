//
//  RecipeFormInteractor.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import Foundation

final class RecipeFormInteractor {
    weak var presenter: RecipeFormInteractorOutput?
}

extension RecipeFormInteractor: RecipeFormInteractorInput {
}
