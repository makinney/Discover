//
//  IngrediantButton.swift
//  Discover
//
//  Created by Michael Kinney on 5/22/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class IngrediantButton: UIButton {

	@IBInspectable var fillColor: UIColor = UIColor.grayColor().colorWithAlphaComponent(0.8)
	
	var ingrediants = [String]()
	var ingrediantsIndexingGenerator: IndexingGenerator<[String]>?
	
	let arcStrokeColor = UIColor.orangeColor()
	let selectedArcStrokeColor = UIColor.blackColor()
	let normalTextColor = UIColor.blackColor()
	let highlightedTextColor = UIColor.orangeColor ()
	var selectedArcIndex: Int?
	
	var usersChoice: String {
		get {
			return self.titleLabel?.text ?? ""
		}
	}
	
	var mealDescriptionIngrediantType: MealDescriptionIngrediantType? {
		didSet {
			ingrediants = MealDescriptionIngrediant(mealDescriptionIngrediantType: self.mealDescriptionIngrediantType!).choices
			ingrediantsIndexingGenerator = ingrediants.generate()
			updateIngrediants()
		}
	}

	// MARK: Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		prepareButton()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		prepareButton()
	}
	
	// Mark: prepare
	
	func prepareButton() {
		addTarget(self, action: "touchUpInside:", forControlEvents: .TouchUpInside)
		addTarget(self, action: "touchDown:", forControlEvents: .TouchDown)
		setTitleColor(normalTextColor, forState: .Normal)
		setTitleColor(highlightedTextColor, forState: .Highlighted)
	}
	
	
	// MARK: methods
	func nextIngrediant() -> String? {
		var choice: String?
		if let choice = ingrediantsIndexingGenerator?.next() {
			return choice
		} else {
			ingrediantsIndexingGenerator = ingrediants.generate()
			return ingrediantsIndexingGenerator?.next()
		}
	}
	
	func save(ingrediant: String) {
		if let mealDescriptionIngrediantType = mealDescriptionIngrediantType {
			MealPlanModel.saveIngrediants([mealDescriptionIngrediantType:ingrediant])
		}
	}
	
	 func updateIngrediants() {
		if let ingrediant = self.nextIngrediant() {
			setTitle(ingrediant, forState: .Normal)
			selectedArcIndex = find(ingrediants, ingrediant)
			save(ingrediant)
			setNeedsDisplay()
		}
	}
	

	// MARK: handlers
	func touchUpInside(sender: UIButton) {
		updateIngrediants()
	}
	
	func touchDown(sender: UIButton) {
		selectedArcIndex = -1 // select nothing
		setNeedsDisplay()
	}
	
	
	// MARK: Drawing
	override func drawRect(rect: CGRect) {
		
		var arcCircleRect = rect
		var arcCircleCenter = CGPoint(x:arcCircleRect.width / 2, y: arcCircleRect.height / 2)
		var arcThickness: CGFloat = 3.0
		var arcModel = ArcModel(circleCenter: arcCircleCenter, circleDiameter: arcCircleRect.width, arcThickness: arcThickness, numberOfArcs: ingrediants.count)
		var arcPaths = arcModel.arcPaths()
		for arcPath in arcPaths {
			arcStrokeColor.setStroke()
			arcPath.stroke()
		}
		
		if	let selectedArcIndex = selectedArcIndex,
			let arcPath = arcModel.arcPath(selectedArcIndex) {
			selectedArcStrokeColor.setStroke()
			arcPath.stroke()
		}
		
		var innerCircleInset: CGFloat = arcThickness + 2.0
		var innerCircleRect = CGRectInset(arcCircleRect,innerCircleInset,innerCircleInset)
		var path = UIBezierPath(ovalInRect: innerCircleRect)
		fillColor.setFill()
		path.fill()
		
	}
	
	// MARK: Timer for shuffling
	var countdownTimer: NSTimer?
	var countDownTimeMax: CUnsignedInt = 4
	var countDownTimeMin: CUnsignedInt = 1
	var updateTimer: NSTimer?
	let updateTimerInterval = 0.5

}

extension IngrediantButton {
	// Shuffling 
	
	func shuffleChoices() {
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
			updateIngrediants()
	}
	
	@objc func countdownTimerFired() {
		updateTimer?.invalidate()
		countdownTimer?.invalidate()
	}
	
}
