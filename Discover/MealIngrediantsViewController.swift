//
//  MealIngrediantsViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/16/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class MealIngrediantsViewController: UIViewController {

	@IBOutlet weak var ingrediantButtonA: IngrediantButton!
	@IBOutlet weak var ingrediantButtonB: IngrediantButton!
	@IBOutlet weak var ingrediantButtonC: IngrediantButton!
	@IBOutlet weak var ingrediantButtonD: IngrediantButton!
	@IBOutlet weak var ingrediantButtonE: IngrediantButton!
	@IBOutlet weak var ingrediantButtonF: IngrediantButton!
	
	@IBOutlet weak var toolbar: UIToolbar!
	
	var ingrediantSelectionMediators = [IngrediantSelectionMediator]()
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
		prepareIngrediantSelectionMediators()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: Preparation

	func prepareButtons(buttonAttributes: ButtonAttributes) {
		prepareButton(ingrediantButtonA, buttonAttributes: buttonAttributes)
		prepareButton(ingrediantButtonB, buttonAttributes: buttonAttributes)
		prepareButton(ingrediantButtonC, buttonAttributes: buttonAttributes)
		prepareButton(ingrediantButtonD, buttonAttributes: buttonAttributes)
		prepareButton(ingrediantButtonE, buttonAttributes: buttonAttributes)
		prepareButton(ingrediantButtonF, buttonAttributes: buttonAttributes)
	}
	
	func prepareButton(ingrediantbutton: IngrediantButton, buttonAttributes: ButtonAttributes) {
		ingrediantbutton.defaultArcColor = buttonAttributes.defaultArcColor
		ingrediantbutton.selectedArcColor = buttonAttributes.selectedArcColor
		ingrediantbutton.setTitleColor(buttonAttributes.normalTextColor, forState: .Normal)
		ingrediantbutton.setTitleColor(buttonAttributes.highlightedTextColor, forState: .Highlighted)
	}
	
	func prepareIngrediantSelectionMediators() {
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonA, mealDescriptionIngrediantType: .Batch))
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonB, mealDescriptionIngrediantType: .Sweet))
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonC, mealDescriptionIngrediantType: .Texture))
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonD, mealDescriptionIngrediantType: .Spicy))
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonE, mealDescriptionIngrediantType: .Quantity))
		ingrediantSelectionMediators.append(IngrediantSelectionMediator(ingrediantButton: ingrediantButtonF, mealDescriptionIngrediantType: .Meal))
	}
	
	// MARK: General Methods
	
	func findIngrediantSelectionMediator(ingrediantSelectionMediators: [IngrediantSelectionMediator], forIngrediantButton: IngrediantButton) -> IngrediantSelectionMediator? {
		var mediators = ingrediantSelectionMediators.filter() {
			$0.ingrediantButton == forIngrediantButton
		}
		return mediators.first
	}
	
	// MARK: Button actions
	
	@IBAction func ingrediantButtonTouchUpInside(sender: IngrediantButton) {
		if let mediator = findIngrediantSelectionMediator(ingrediantSelectionMediators, forIngrediantButton: sender) {
			mediator.changeDisplayedIngrediant()
		}
	}
	
	@IBAction func ingrediantButtonTouchDown(sender: IngrediantButton) {
		if let mediator = findIngrediantSelectionMediator(ingrediantSelectionMediators, forIngrediantButton: sender) {
			mediator.allButtonArcsNormalColor()
		}
	}
	
	@IBAction func goButtonTouched(sender: AnyObject) {
		for ingrediantSelectionMediator in ingrediantSelectionMediators {
			ingrediantSelectionMediator.save()
		}
	}
	
	@IBAction func shuffleButtonTouched(sender: AnyObject) {
		for ingrediantSelectionMediator in ingrediantSelectionMediators {
			ingrediantSelectionMediator.shuffleIngrediants()
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
