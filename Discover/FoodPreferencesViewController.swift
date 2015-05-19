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
			ChoicesModel.bindToData(controller, choiceCategory: category)
		}
	}
	
	func createChoiceControllers() -> [ChoiceCategory: ChoiceController] {
		var controllers = [ChoiceCategory:ChoiceController]()
		controllers[ChoiceCategory.Batch] = ChoiceController(choiceControlView: choiceViewA)
		controllers[ChoiceCategory.Sweet] = ChoiceController(choiceControlView: choiceViewB)
		controllers[ChoiceCategory.Texture] = ChoiceController(choiceControlView: choiceViewC)
		controllers[ChoiceCategory.Spicy] = ChoiceController(choiceControlView: choiceViewD)
		controllers[ChoiceCategory.Quantity] = ChoiceController(choiceControlView: choiceViewE)
		controllers[ChoiceCategory.Meal] = ChoiceController(choiceControlView: choiceViewF)
		return controllers
	}
	
	func saveUsersChoices(choiceControllers: [ChoiceCategory: ChoiceController]) {
		var choiceForCategory = [ChoiceCategory: String]()
		for (category, controller) in choiceControllers {
			choiceForCategory[category] = controller.usersChoice
		}
		ChoicesModel.saveUserChoices(choiceForCategory)
	}
	
	// MARK: Button Actions
	
	@IBAction func goButtonTouched(sender: AnyObject) {
		saveUsersChoices(choiceControllers)
	}
	
	@IBAction func shuffleButtonTouched(sender: AnyObject) {
		for (_, controller) in choiceControllers {
			controller.shuffleChoices()
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	
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
		return UIBarButtonItem(image: image, style: .Plain, target: nil, action: "")
	}
	
	var searchButtonItem: UIBarButtonItem {
		var image = UIImage(named: "MON_searchIcon") ?? UIImage()
		return UIBarButtonItem(image: image, style: .Plain, target: nil, action: "")
	}
	
}
