//
//  MealIngredientsViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/16/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class MealIngredientsViewController: UIViewController {

	@IBOutlet weak var ingredientButtonA: IngredientButton!
	@IBOutlet weak var ingredientButtonB: IngredientButton!
	@IBOutlet weak var ingredientButtonC: IngredientButton!
	@IBOutlet weak var ingredientButtonD: IngredientButton!
	@IBOutlet weak var ingredientButtonE: IngredientButton!
	@IBOutlet weak var ingredientButtonF: IngredientButton!
	
	@IBOutlet weak var toolbar: UIToolbar!
	
	var ingredientSelectionMediators = [IngredientSelectionMediator]()
	let yourChoicesAnimatedTransistioningDelegate = YourChoicesAnimatedTransistioningDelegate()
	
	struct ButtonAttributes {
		let defaultArcColor = UIColor.blackColor()
		let selectedArcColor = UIColor.discoverOrange()
		let normalTextColor = UIColor.discoverOrange()
		let highlightedTextColor = UIColor.blackColor()
	}
	
	// MARK: LifeCycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupToolbar()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		prepareButtons(ButtonAttributes())
		createIngredientSelectionMediators()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: setup
	
	func createIngredientSelectionMediators() {
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonA, mealDescriptionIngredientType: .Batch))
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonB, mealDescriptionIngredientType: .Sweet))
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonC, mealDescriptionIngredientType: .Texture))
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonD, mealDescriptionIngredientType: .Spicy))
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonE, mealDescriptionIngredientType: .Quantity))
		ingredientSelectionMediators.append(IngredientSelectionMediator(ingredientButton: ingredientButtonF, mealDescriptionIngredientType: .Meal))
	}
	
	func prepareButtons(buttonAttributes: ButtonAttributes) {
		prepareButton(ingredientButtonA, buttonAttributes: buttonAttributes)
		prepareButton(ingredientButtonB, buttonAttributes: buttonAttributes)
		prepareButton(ingredientButtonC, buttonAttributes: buttonAttributes)
		prepareButton(ingredientButtonD, buttonAttributes: buttonAttributes)
		prepareButton(ingredientButtonE, buttonAttributes: buttonAttributes)
		prepareButton(ingredientButtonF, buttonAttributes: buttonAttributes)
	}
	
	func prepareButton(ingredientbutton: IngredientButton, buttonAttributes: ButtonAttributes) {
		ingredientbutton.defaultArcColor = buttonAttributes.defaultArcColor
		ingredientbutton.selectedArcColor = buttonAttributes.selectedArcColor
		ingredientbutton.setTitleColor(buttonAttributes.normalTextColor, forState: .Normal)
		ingredientbutton.setTitleColor(buttonAttributes.highlightedTextColor, forState: .Highlighted)
	}

	
	// MARK: Methods
	
	func findIngredientSelectionMediator(ingredientSelectionMediators: [IngredientSelectionMediator], forIngredientButton: IngredientButton) -> IngredientSelectionMediator? {
		var mediators = ingredientSelectionMediators.filter() {
			$0.ingredientButton == forIngredientButton
		}
		return mediators.first
	}
	
	// MARK: Button actions
	
	@IBAction func ingredientButtonTouchUpInside(sender: IngredientButton) {
		if let mediator = findIngredientSelectionMediator(ingredientSelectionMediators, forIngredientButton: sender) {
			mediator.changeDisplayedIngredient()
		}
	}
	
	@IBAction func ingredientButtonTouchDown(sender: IngredientButton) {
		if let mediator = findIngredientSelectionMediator(ingredientSelectionMediators, forIngredientButton: sender) {
			mediator.allButtonArcsNormalColor()
		}
	}
	
	@IBAction func goButtonTouched(sender: AnyObject) {
		for ingredientSelectionMediator in ingredientSelectionMediators {
			ingredientSelectionMediator.save()
		}
	}
	
	@IBAction func shuffleButtonTouched(sender: AnyObject) {
		for ingredientSelectionMediator in ingredientSelectionMediators {
			ingredientSelectionMediator.shuffleIngredients()
		}
	}
	
	// MARK: Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		var destinationViewController = segue.destinationViewController as! UIViewController
		destinationViewController.transitioningDelegate = yourChoicesAnimatedTransistioningDelegate
		destinationViewController.modalPresentationStyle = .Custom
	}

	func dismiss() { // just for demo purposes
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: Toolbar
	
	func setupToolbar() {
		let items = [searchButtonItem, fixedSpaceBarButtonItem, calendarButtonItem, fixedSpaceBarButtonItem, compassButtonItem, flexibleSpaceBarButtonItem, menuButtonItem]
		toolbar.items = items
	}

	var calendarButtonItem: UIBarButtonItem {
		var image = UIImage(named: "MON_calendarIcon") ?? UIImage()
		return UIBarButtonItem(image: image, style: .Plain, target:nil, action: "")
	}
	
	var compassButtonItem: UIBarButtonItem {
		var image = UIImage(named: "MON_compassIcon") ?? UIImage()
		return UIBarButtonItem(image: image, style: .Plain, target: nil, action: "")
	}
	
	var fixedSpaceBarButtonItem: UIBarButtonItem {
		var item = UIBarButtonItem(barButtonSystemItem: .FixedSpace , target: nil, action: nil)
		item.width = 10
		return item
	}
	
	var flexibleSpaceBarButtonItem: UIBarButtonItem {
		return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
	}
	
	var menuButtonItem: UIBarButtonItem {
		var image = UIImage(named: "MON_menuIcon") ?? UIImage()
		return UIBarButtonItem(image: image, style: .Plain, target: self, action: "dismiss")
	}
	
	var searchButtonItem: UIBarButtonItem {
		var image = UIImage(named: "MON_searchIcon") ?? UIImage()
		return UIBarButtonItem(image: image, style: .Plain, target: nil, action: "")
	}
	
}
