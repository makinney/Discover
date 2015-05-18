//
//  ChoicesModel.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import Foundation

enum ChoiceCategory {
	case Batch
	case Sweet
	case Spicy
	case Texture
	case Quantity
	case Meal
}

struct ChoiceCategoryData: ChoiceControlProtocol {
	var choiceCategory: ChoiceCategory
	var choices: [String] {
		get {
			return ChoicesModel.choices(choiceCategory)
		}
	}
}

class ChoicesModel {

	class func bindToData(choiceController: ChoiceController, choiceCategory: ChoiceCategory) {
		choiceController.dataSourceDelegate = ChoiceCategoryData(choiceCategory: choiceCategory)
	}
	
	class func choices(category: ChoiceCategory) -> [String] {
		switch (category) {
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
