//
//  RecipeFormViewController.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import UIKit

final class RecipeFormViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: RecipeFormViewOutput
    
    // MARK: - Init
    
    init(presenter: RecipeFormViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension RecipeFormViewController: RecipeFormViewInput {
}
