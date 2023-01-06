//
//  RecipeFormViewController.swift
//  RecipeForm
//
//  Created by Егор Бадмаев on 03.01.2023.
//  

import UIKit
import Models
import Resources

final class RecipeFormViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: RecipeFormViewOutput
    
    private var recipeData: RecipeData?
    
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
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    @objc private func dismissThisModule() {
        presenter.dismissThisModule()
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissThisModule))
        navigationItem.rightBarButtonItem = editButtonItem
        view.backgroundColor = Colors.systemBackground
        
        
    }
}

extension RecipeFormViewController: RecipeFormViewInput {
    
    func displayData(_ recipeData: RecipeData) {
        /// We do not need to update view if recipe was not provided for this module originally.
        let viewToUpdateFlag = self.recipeData != nil
        self.recipeData = recipeData
        
        if viewToUpdateFlag {
            
        }
    }
}
