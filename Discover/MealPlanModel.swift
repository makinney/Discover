//
//  MealPlanModel.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.          
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import Foundation

enum MealDescriptionIngredientType {
	case Batch
	case Sweet
	case Spicy
	case Texture
	case Quantity
	case Meal
}

struct MealDescriptionIngredient {
	var mealDescriptionIngredientType: MealDescriptionIngredientType
	var ingredients: [String] {
		get {
			return MealPlanModel.ingredients(mealDescriptionIngredientType) // TODO: name and reverence back into class is kinda
		}
	}
}

class MealPlanModel {

	private static var ingredientPresistence = [MealDescriptionIngredientType:String]()

	class func ingredientDescription() -> [MealDescriptionIngredientType:String] {
			return ingredientPresistence
	}
	
	class func saveIngredients(ingredients: [MealDescriptionIngredientType:String]) {
		for (ingredientType, ingredient) in ingredients {
			ingredientPresistence[ingredientType] = ingredient
		}
	}
	
	class func ingredients(mealDescriptionIngredientType: MealDescriptionIngredientType) -> [String] {
		switch (mealDescriptionIngredientType) {
		case .Batch:
			return ["SMALL BATCH", "LARGE BATCH", "MASS MARKET", "ONE OF A KIND"]
		case .Sweet:
			return ["SAVORY", "SWEET", "UMAMI"]
		case .Spicy:
			return ["SPICY", "MILD"]
		case .Texture:
			return ["CRUNCHY", "MUSHY", "SMOOTH"]
		case .Quantity:
			return ["A LITTLE", "A LOT"]
		case .Meal:
			return ["BREAKFAST", "BRUNCH", "LUNCH", "SNACK", "DINNER"]
		default:
			return [String]()
		}
	}
	
}
