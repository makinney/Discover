//
//  YourChoicesViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class YourChoicesViewController: UIViewController {

	@IBOutlet weak var viewA: UILabel!
	@IBOutlet weak var viewB: UILabel!
	@IBOutlet weak var viewC: UILabel!
	@IBOutlet weak var viewD: UILabel!
	@IBOutlet weak var viewE: UILabel!
	@IBOutlet weak var viewF: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		prepViews()
		let tapRecognizer = UITapGestureRecognizer(target: self, action: "dismiss")
		self.view.addGestureRecognizer(tapRecognizer)

    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		var customersMealDescriptions = MealPlanModel.ingrediantDescription()
		viewA.text = customersMealDescriptions[.Batch]
		viewB.text = customersMealDescriptions[.Sweet]
		viewC.text = customersMealDescriptions[.Texture]
		viewD.text = customersMealDescriptions[.Spicy]
		viewE.text = customersMealDescriptions[.Quantity]
		viewF.text = customersMealDescriptions[.Meal]
	}
	
	func prepViews() {
		prepLabel(viewA)
		prepLabel(viewB)
		prepLabel(viewC)
		prepLabel(viewD)
		prepLabel(viewE)
		prepLabel(viewF)
	}
	
	func prepLabel(label: UILabel) {
		label.textColor = UIColor.discoverOrange()
		label.backgroundColor = UIColor.ingrediantTextBackground()
		label.layer.borderColor = UIColor.grayColor().CGColor
		label.layer.borderWidth = CGFloat(1.0)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	func dismiss() {
		dismissViewControllerAnimated(true, completion: nil)
	}


	
}
