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
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		var userChoices = ChoicesModel.userChoices()
		viewA.text = userChoices[.Batch]
		viewB.text = userChoices[.Sweet]
		viewC.text = userChoices[.Texture]
		viewD.text = userChoices[.Spicy]
		viewE.text = userChoices[.Quantity]
		viewF.text = userChoices[.Meal]
	}
	
	func prepViews() {
	    let borderColor = UIColor.grayColor().CGColor
		let borderWidth: CGFloat = 1.0
		viewA.layer.borderColor = borderColor
		viewA.layer.borderWidth = borderWidth
		viewB.layer.borderColor = borderColor
		viewB.layer.borderWidth = borderWidth
		viewC.layer.borderColor = borderColor
		viewC.layer.borderWidth = borderWidth
		viewD.layer.borderColor = borderColor
		viewD.layer.borderWidth = borderWidth
		viewE.layer.borderColor = borderColor
		viewE.layer.borderWidth = borderWidth
		viewF.layer.borderColor = borderColor
		viewF.layer.borderWidth = borderWidth
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
	

	
}
