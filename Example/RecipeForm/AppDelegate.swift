//
//  AppDelegate.swift
//  RecipeForm
//
//  Created by htmlprogrammist on 01/03/2023.
//  Copyright (c) 2023 htmlprogrammist. All rights reserved.
//

import UIKit
import RecipeForm
import Persistence
import Models
import Resources

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let coreDataManager: CoreDataManagerProtocol = CoreDataManager(containerName: "Cookbook")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let recipe = getRecipe()
        let context = RecipeFormContext(moduleOutput: self, recipe: nil, moduleDependency: coreDataManager)
        let assembly = RecipeFormAssembly.assemble(with: context)
        
        let navController = UINavigationController(rootViewController: assembly.viewController)
        navController.navigationBar.prefersLargeTitles = false
        
        // Resources.Fonts
        Fonts.registerFonts()
        navController.navigationBar.largeTitleTextAttributes = [.font: Fonts.largeTitle()]
        navController.navigationBar.titleTextAttributes = [.font: Fonts.headline()]
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: RecipeFormModuleOutput {
    
    func recipeFormModuleDidFinish() {
        print("recipeFormModuleDidFinish")
    }
}

private extension AppDelegate {
    /*
    func createNewRecipe() -> Persistence.Recipe {
        let stepData = [StepData(text: "Make dough Make dough Make dough Make dough Make dough Make dough Make dough Make dough", imageData: Resources.Images.sampleRecipeImage.pngData()),
                        StepData(text: "Make dough Make dough Make dough Make dough Make dough Make dough Make dough Make dough", imageData: Resources.Images.sampleRecipeImage.pngData()),
                        StepData(text: "Make dough Make dough Make dough Make dough Make dough Make dough Make dough Make dough", imageData: Resources.Images.sampleRecipeImage.pngData()),
                        StepData(text: "Make dough Make dough Make dough Make dough Make dough Make dough Make dough Make dough", imageData: Resources.Images.sampleRecipeImage.pngData()),
                        StepData(text: "Make dough Make dough Make dough Make dough Make dough Make dough Make dough Make dough", imageData: Resources.Images.sampleRecipeImage.pngData()),
        ]
        let data = RecipeData(name: "Pizza", dateCreated: Date(), numberOfServings: 4, proteins: 120, fats: 350, carbohydrates: 600, calories: 2300, cookingTime: 120, comment: "My favourite pizza recipe! How wonderful it is! And this is description for this with two or more lines", ingredients: ["Tomato Pasta", "Flour", "Salt", "Pepper", "Mozzarella"], imageData: Resources.Images.sampleRecipeImage.pngData(), steps: stepData)
        coreDataManager.createRecipe(with: data)
        let recipes =
    }
     */
    func getRecipe() -> Persistence.Recipe? {
        let recipes = coreDataManager.fetchRecipes()
        return recipes?.first
    }
}
