# "Recipe Form" module

Module that is shown after user tries to add his own recipe to the application

## To set up

This module could be opened in [Personal](https://github.com/iCookbook/Personal) module.

It requires Core Data manager instance (protocol) for saving data in Core Data. This instance should be provided in `RecipeFormContext` structure.

## Use cases

1. Create new recipe:
    No need for special setup, just provide `nil` for `recipe: Persistence.Recipe` property.

2. Open details for an existing recipe
    You need to provide it [recipe] in `RecipeFormContext`.

## Dependencies

This module has 4 dependencies:

- [CommonUI](https://github.com/iCookbook/CommonUI) for the extension of `UIAlertController` to mask Apple's error 
- [Resources](https://github.com/iCookbook/Resources) for access to resources of the application
- [Persistence](https://github.com/iCookbook/Persistence) to use data models add create/save/update favourites recipes
- [Models](https://github.com/iCookbook/Models) to use `Persistence` models representatives
- [Logger](https://github.com/iCookbook/Logger) to log data in debug mode

- `Persistence` for access to Core Data models

## Screenshots

| <img width=300 src=""> | <img width=300 src=""> | <img width=300 src=""> |
|---|---|---|

---

For more details, read [GitHub Wiki](https://github.com/iCookbook/RecipeForm/wiki) documentation
