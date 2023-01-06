//
//  RecipeFormInteractorTests.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

import XCTest
@testable import RecipeForm
@testable import Models

class RecipeFormInteractorTests: XCTestCase {
    
    let mockCoreDataManager = MockCoreDataManager()
    var spyPresenter: SpyRecipeFormPresenter!
    /// SUT.
    var interactor: RecipeFormInteractor!
    
    override func setUpWithError() throws {
        spyPresenter = SpyRecipeFormPresenter()
        interactor = RecipeFormInteractor(coreDataManager: mockCoreDataManager, recipe: nil)
        interactor.presenter = spyPresenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        spyPresenter = nil
    }
    
    func test_checkBarButtonEnabled_withoutName() throws {
        let data = RecipeData(name: "", dateCreated: Date(), numberOfServings: 1, proteins: nil, fats: nil, carbohydrates: nil, calories: nil, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        
        interactor.checkBarButtonEnabled(data)
        
        XCTAssertNotNil(spyPresenter.checkedBarButtonFlag)
        XCTAssertFalse(spyPresenter.checkedBarButtonFlag)
    }
    
    func test_checkBarButtonEnabled_withoutNumberOfServings() throws {
        let data = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: nil, proteins: nil, fats: nil, carbohydrates: nil, calories: nil, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        
        interactor.checkBarButtonEnabled(data)
        
        XCTAssertNotNil(spyPresenter.checkedBarButtonFlag)
        XCTAssertFalse(spyPresenter.checkedBarButtonFlag)
    }
    
    func test_checkBarButtonEnabled_withoutCookingTime() throws {
        let data = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: nil, fats: nil, carbohydrates: nil, calories: nil, cookingTime: nil, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        
        interactor.checkBarButtonEnabled(data)
        
        XCTAssertNotNil(spyPresenter.checkedBarButtonFlag)
        XCTAssertFalse(spyPresenter.checkedBarButtonFlag)
    }
    
    func test_checkBarButtonEnabled_withAllRequiredFields() throws {
        let data = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: nil, fats: nil, carbohydrates: nil, calories: nil, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        
        interactor.checkBarButtonEnabled(data)
        
        XCTAssertNotNil(spyPresenter.checkedBarButtonFlag)
        XCTAssertTrue(spyPresenter.checkedBarButtonFlag)
    }
    
    func test_provideRecipeData_withNilRecipe() throws {
        interactor.provideRecipeData()
        
        XCTAssertNotNil(spyPresenter.providedRecipeData)
        XCTAssertEqual(spyPresenter.providedRecipeData.name, RecipeData.default.name)
    }
}
