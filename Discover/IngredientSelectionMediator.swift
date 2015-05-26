//
//  IngredientSelectionMediator.swift
//  Discover
//
//  Created by Michael Kinney on 5/25/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class IngredientSelectionMediator{
	
	var ingredients = [String]()
	let ingredientButton: IngredientButton
	var ingredientsIndexingGenerator: IndexingGenerator<[String]>?
	let mealDescriptionIngredientType: MealDescriptionIngredientType

	// timer
	var countdownTimer: NSTimer?
	var countDownTimeMax: CUnsignedInt = 5
	var countDownTimeMin: CUnsignedInt = 1
	var updateTimer: NSTimer?
	let updateTimerInterval = 0.5
	
	// MARK: Methods
	
	init(ingredientButton: IngredientButton, mealDescriptionIngredientType: MealDescriptionIngredientType) {
		self.ingredientButton = ingredientButton
		self.mealDescriptionIngredientType = mealDescriptionIngredientType
		ingredients = MealDescriptionIngredient(mealDescriptionIngredientType: self.mealDescriptionIngredientType).ingredients
		ingredientsIndexingGenerator = ingredients.generate()
		self.ingredientButton.numberOfArcs = ingredients.count
		changeDisplayedIngredient()
	}
	
	func allButtonArcsNormalColor() {
		ingredientButton.allArcsNormalColor()
	}
	
	func changeDisplayedIngredient() {
		if let ingredient = self.nextIngredient() {
			ingredientButton.setTitle(ingredient, forState: .Normal)
			ingredientButton.selectedArcIndex = find(ingredients, ingredient)
			ingredientButton.setNeedsDisplay()
		}
	}
	
	func nextIngredient() -> String? {
		var ingredient: String?
		if let ingredient = ingredientsIndexingGenerator?.next() {
			return ingredient
		} else {
			ingredientsIndexingGenerator = ingredients.generate()
			return ingredientsIndexingGenerator?.next()
		}
	}
	
	func save() {
		if let ingredient = ingredientButton.titleForState(.Normal) {
			MealPlanModel.saveIngredients([mealDescriptionIngredientType:ingredient])
		}
	}
}

extension IngredientSelectionMediator {
	
	// MARK: Shuffling
	//
	func shuffleIngredients() {
		var randomCountdown = arc4random_uniform(countDownTimeMax - countDownTimeMin) + countDownTimeMin
		var countdownTime: NSTimeInterval = NSTimeInterval(randomCountdown)
		startUpdateTimer()
		startCountdownTimer(countdownTime)
	}
	
	func startCountdownTimer(timeout: NSTimeInterval) {
		countdownTimer?.invalidate()
		countdownTimer = NSTimer.scheduledTimerWithTimeInterval(timeout, target: self, selector: Selector("countdownTimerFired"), userInfo: nil, repeats: false)
	}
	
	func startUpdateTimer() {
		updateTimer?.invalidate()
		updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateTimerInterval, target: self, selector: Selector("updateTimerFired"), userInfo: nil, repeats: true)
	}
	
	@objc func updateTimerFired() {
		changeDisplayedIngredient()
	}
	
	@objc func countdownTimerFired() {
		updateTimer?.invalidate()
		countdownTimer?.invalidate()
	}
	
}
