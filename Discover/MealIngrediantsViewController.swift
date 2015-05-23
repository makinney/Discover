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
	
	let yourChoicesAnimatedTransistioningDelegate = YourChoicesAnimatedTransistioningDelegate()

	// MARK: LifeCycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupToolbar()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		bindData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: Setup
	
	func bindData() {
		ingrediantButtonA.mealDescriptionIngrediantType = .Batch
		ingrediantButtonB.mealDescriptionIngrediantType = .Sweet
		ingrediantButtonC.mealDescriptionIngrediantType = .Texture
		ingrediantButtonD.mealDescriptionIngrediantType = .Spicy
		ingrediantButtonE.mealDescriptionIngrediantType = .Quantity
		ingrediantButtonF.mealDescriptionIngrediantType = .Meal
	}
	
	// MARK: Button actions
	
	@IBAction func goButtonTouched(sender: AnyObject) {
	
	}
	
	@IBAction func shuffleButtonTouched(sender: AnyObject) {
		ingrediantButtonA.shuffleChoices()
		ingrediantButtonB.shuffleChoices()
		ingrediantButtonC.shuffleChoices()
		ingrediantButtonD.shuffleChoices()
		ingrediantButtonE.shuffleChoices()
		ingrediantButtonF.shuffleChoices()
	}
	
	// MARK: - Navigation
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		var destinationViewController = segue.destinationViewController as! UIViewController
		destinationViewController.transitioningDelegate = yourChoicesAnimatedTransistioningDelegate
		destinationViewController.modalPresentationStyle = .Custom
	}

	func dismiss() {
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
