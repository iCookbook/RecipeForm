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

This module has 2 dependencies:

- `Persistence` for access to Core Data models

## Screenshots

| <img width=300 src=""> | <img width=300 src=""> | <img width=300 src=""> |
|---|---|---|
