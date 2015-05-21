//
//  FoodPreferencesViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/16/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class FoodPreferencesViewController: UIViewController {

	@IBOutlet weak var toolbar: UIToolbar!
	
	@IBOutlet weak var choiceViewA: ChoiceControlView!
	@IBOutlet weak var choiceViewB: ChoiceControlView!
	@IBOutlet weak var choiceViewC: ChoiceControlView!
	@IBOutlet weak var choiceViewD: ChoiceControlView!
	@IBOutlet weak var choiceViewE: ChoiceControlView!
	@IBOutlet weak var choiceViewF: ChoiceControlView!
	
	var choiceControllers = [ChoiceCategory: ChoiceController]()
	let yourChoicesAnimatedTransistioningDelegate = YourChoicesAnimatedTransistioningDelegate()

	// MARK: LifeCycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupToolbar()
		choiceControllers = createChoiceControllers()
		bindControllersToData(choiceControllers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: Methods
	
	func bindControllersToData(controllers: [ChoiceCategory: ChoiceController]) {
		for (category, controller) in controllers {
			MealPlanModel.bindToData(controller, choiceCategory: category)
		}
	}
	
	func createChoiceControllers() -> [ChoiceCategory: ChoiceController] {
		var controllers = [ChoiceCategory:ChoiceController]()
		controllers[.Batch] = ChoiceController(choiceControlView: choiceViewA)
		controllers[.Sweet] = ChoiceController(choiceControlView: choiceViewB)
		controllers[.Texture] = ChoiceController(choiceControlView: choiceViewC)
		controllers[.Spicy] = ChoiceController(choiceControlView: choiceViewD)
		controllers[.Quantity] = ChoiceController(choiceControlView: choiceViewE)
		controllers[.Meal] = ChoiceController(choiceControlView: choiceViewF)
		return controllers
	}
	
	// MARK: Button Actions
	
	@IBAction func goButtonTouched(sender: AnyObject) {
	}
	
	@IBAction func shuffleButtonTouched(sender: AnyObject) {
		for (_, controller) in choiceControllers {
			controller.shuffleChoices()
		}
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
