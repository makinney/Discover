//
//  IngrediantSelectionMediator.swift
//  Discover
//
//  Created by Michael Kinney on 5/25/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class IngrediantSelectionMediator{
	
	var ingrediants = [String]()
	let ingrediantButton: IngrediantButton
	var ingrediantsIndexingGenerator: IndexingGenerator<[String]>?
	let mealDescriptionIngrediantType: MealDescriptionIngrediantType

	// timer
	var countdownTimer: NSTimer?
	var countDownTimeMax: CUnsignedInt = 5
	var countDownTimeMin: CUnsignedInt = 1
	var updateTimer: NSTimer?
	let updateTimerInterval = 0.5
	
	// MARK: Methods
	
	init(ingrediantButton: IngrediantButton, mealDescriptionIngrediantType: MealDescriptionIngrediantType) {
		self.ingrediantButton = ingrediantButton
		self.mealDescriptionIngrediantType = mealDescriptionIngrediantType
		ingrediants = MealDescriptionIngrediant(mealDescriptionIngrediantType: self.mealDescriptionIngrediantType).choices
		ingrediantsIndexingGenerator = ingrediants.generate()
		self.ingrediantButton.numberOfArcs = ingrediants.count
		changeDisplayedIngrediant()
	}
	
	func allButtonArcsNormalColor() {
		ingrediantButton.allArcsNormalColor()
	}
	
	func changeDisplayedIngrediant() {
		if let ingrediant = self.nextIngrediant() {
			ingrediantButton.setTitle(ingrediant, forState: .Normal)
			ingrediantButton.selectedArcIndex = find(ingrediants, ingrediant)
			ingrediantButton.setNeedsDisplay()
		}
	}
	
	func nextIngrediant() -> String? {
		var choice: String?
		if let choice = ingrediantsIndexingGenerator?.next() {
			return choice
		} else {
			ingrediantsIndexingGenerator = ingrediants.generate()
			return ingrediantsIndexingGenerator?.next()
		}
	}
	
	func save() {
		if let ingrediant = ingrediantButton.titleForState(.Normal) {
			MealPlanModel.saveIngrediants([mealDescriptionIngrediantType:ingrediant])
		}
	}
}

extension IngrediantSelectionMediator {
	
	// MARK: Shuffling
	//
	func shuffleIngrediants() {
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
		changeDisplayedIngrediant()
	}
	
	@objc func countdownTimerFired() {
		updateTimer?.invalidate()
		countdownTimer?.invalidate()
	}
	
}
