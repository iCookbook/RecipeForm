//
//  RecipeFormPresenterTests.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

import XCTest
@testable import RecipeForm
@testable import Models

class RecipeFormPresenterTests: XCTestCase {
    
    let mockRouter = MockRecipeFormRouter()
    var spyInteractor: SpyRecipeFormInteractor!
    /// SUT.
    var presenter: RecipeFormPresenter!
    
    override func setUpWithError() throws {
        spyInteractor = SpyRecipeFormInteractor()
        presenter = RecipeFormPresenter(router: mockRouter, interactor: spyInteractor)
    }
    
    override func tearDownWithError() throws {
        spyInteractor = nil
        presenter = nil
    }
    
    func testViewDidLoadMethod() throws {
        presenter.viewDidLoad()
        
        XCTAssertNotNil(spyInteractor.didProvideRecipeData)
        XCTAssertTrue(spyInteractor.didProvideRecipeData)
    }
    
    func testCheckBarButtonEnabledMethod() throws {
        let data = RecipeData.default
        presenter.checkBarButtonEnabled(data)
        
        XCTAssertNotNil(spyInteractor.recipeDataCheckWith)
        XCTAssertEqual(spyInteractor.recipeDataCheckWith, data)
    }
    
    func test_SaveRecipeMethod_withDefaultData() throws {
        let expectation = expectation(description: "test_SaveRecipeMethod_withDefaultData")
        spyInteractor.expectation = expectation
        let data = RecipeData.default
        
        presenter.saveRecipe(with: data)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(spyInteractor.recipeDataToSave)
        XCTAssertEqual(spyInteractor.recipeDataToSave, data)
    }
    
    func test_SaveRecipeMethod_withNilData() throws {
        presenter.saveRecipe(with: nil)
        
        XCTAssertNil(spyInteractor.recipeDataCheckWith)
    }
    
    func testRecipeFormModuleDidFinishMethod() throws {
        let moduleOutput = SpyRecipeFormModuleOutput()
        presenter.moduleOutput = moduleOutput
        
        presenter.dismissThisModule()
        
        XCTAssertNotNil(moduleOutput.recipeFormModuleDidFinishFlag)
        XCTAssertTrue(moduleOutput.recipeFormModuleDidFinishFlag)
    }
}
