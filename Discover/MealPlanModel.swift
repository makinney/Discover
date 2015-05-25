//
//  MealPlanModel.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.          
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import Foundation

enum MealDescriptionIngrediantType {
	case Batch
	case Sweet
	case Spicy
	case Texture
	case Quantity
	case Meal
}

struct MealDescriptionIngrediant {
	var mealDescriptionIngrediantType: MealDescriptionIngrediantType
	var choices: [String] {
		get {
			return MealPlanModel.ingrediants(mealDescriptionIngrediantType) // TODO: name and reverence back into class is kinda
		}
	}
}

class MealPlanModel {

	private static var ingrediantPresistence = [MealDescriptionIngrediantType:String]()

	class func ingrediantDescription() -> [MealDescriptionIngrediantType:String] {
			return ingrediantPresistence
	}
	
	class func saveIngrediants(ingrediants: [MealDescriptionIngrediantType:String]) {
		for (ingrediantType, ingrediant) in ingrediants {
			ingrediantPresistence[ingrediantType] = ingrediant
		}
	}
	
	class func ingrediants(mealDescriptionIngrediantType: MealDescriptionIngrediantType) -> [String] {
		switch (mealDescriptionIngrediantType) {
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
