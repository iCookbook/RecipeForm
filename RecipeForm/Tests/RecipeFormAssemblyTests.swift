//
//  RecipeFormAssemblyTests.swift
//  RecipeForm-Unit-Tests
//
//  Created by Егор Бадмаев on 07.01.2023.
//

import XCTest
@testable import RecipeForm
@testable import Persistence

class RecipeFormAssemblyTests: XCTestCase {
    
    let mockCoreDataManager = MockCoreDataManager()
    /// SUT.
    var assembly: RecipeFormAssembly!
    var context: RecipeFormContext!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        assembly = nil
        context = nil
    }
    
    /**
     In the next tests we will check that the module consists of the correct parts and all dependencies are filled in.
     The tests will differ by creating different contexts
     */
    func test_Assembling_WithModuleOutputWithNilRecipe() throws {
        let moduleOutput = MockRecipeFormPresenter()
        context = RecipeFormContext(moduleOutput: moduleOutput, recipe: nil, moduleDependency: mockCoreDataManager)
        assembly = RecipeFormAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router, "Module router should not be nil")
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? RecipeFormViewController,
              let presenter = assembly.input as? RecipeFormPresenter,
              let _ = assembly.router as? RecipeFormRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
        /// Unfortunately, it is impossible to access Core Data manager, that is why it is impossible to test its' injecting. DI was tested in `Cookbook/ServiceLocatorTests.swift`.
    }
    
    func test_Assembling_WithoutModuleOutputWithNilRecipe() throws {
        context = RecipeFormContext(moduleOutput: nil, recipe: nil, moduleDependency: mockCoreDataManager)
        assembly = RecipeFormAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router)
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? RecipeFormViewController,
              let presenter = assembly.input as? RecipeFormPresenter,
              let _ = assembly.router as? RecipeFormRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
    
    func test_Assembling_WithModuleOutputWithRecipe() throws {
        let moduleOutput = MockRecipeFormPresenter()
        let recipe = Recipe()
        context = RecipeFormContext(moduleOutput: moduleOutput, recipe: recipe, moduleDependency: mockCoreDataManager)
        assembly = RecipeFormAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router, "Module router should not be nil")
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? RecipeFormViewController,
              let presenter = assembly.input as? RecipeFormPresenter,
              let _ = assembly.router as? RecipeFormRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertIdentical(moduleOutput, presenter.moduleOutput, "All injected dependencies should be identical")
        /// Unfortunately, it is impossible to access Core Data manager, that is why it is impossible to test its' injecting. DI was tested in `Cookbook/ServiceLocatorTests.swift`.
    }
    
    func test_Assembling_WithoutModuleOutputWithRecipe() throws {
        let recipe = Recipe()
        context = RecipeFormContext(moduleOutput: nil, recipe: recipe, moduleDependency: mockCoreDataManager)
        assembly = RecipeFormAssembly.assemble(with: context)
        
        XCTAssertNotNil(assembly.input)
        XCTAssertNotNil(assembly.router)
        XCTAssertNotNil(assembly.viewController)
        
        guard let _ = assembly.viewController as? RecipeFormViewController,
              let presenter = assembly.input as? RecipeFormPresenter,
              let _ = assembly.router as? RecipeFormRouter
        else {
            XCTFail("Module was assebled with wrong components")
            return
        }
        XCTAssertNil(presenter.moduleOutput, "Module output was not provided and should be nil")
    }
}
