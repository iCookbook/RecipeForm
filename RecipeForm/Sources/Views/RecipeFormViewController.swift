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
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
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
        
        defer {
            presenter.dismissThisModule()
        }
        
        if saveBarButton.isEnabled {
            let alert = UIAlertController(title: Texts.RecipeForm.unsavedChangesTitle, message: Texts.RecipeForm.unsavedChangesDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Texts.RecipeForm.save, style: .destructive, handler: { [unowned self] _ in
                presenter.saveRecipe(with: recipeData)
            })
            let no = UIAlertAction(title: Texts.RecipeForm.cancel, style: .cancel)
            
            alert.addAction(yes)
            alert.addAction(no)
            
            present(alert, animated: true)
        }
    }
    
    @objc private func saveButtonTapped() {
        presenter.saveRecipe(with: recipeData)
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissThisModule))
        navigationItem.rightBarButtonItem = saveBarButton
        view.backgroundColor = Colors.systemBackground
        
        
    }
}

extension RecipeFormViewController: RecipeFormViewInput {
    
    func displayData(_ recipeData: RecipeData) {
        self.recipeData = recipeData
        /*
         /// We do not need to update view if recipe was not provided for this module originally.
         let viewToUpdateFlag = self.recipeData != nil
         self.recipeData = recipeData
         
         if viewToUpdateFlag {
         
         }*/
    }
}
