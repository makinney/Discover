//
//  EntryViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

	let foodChoicesAnimatedTransistioningDelegate = FoodChoicesAnimatedTransistioningDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		   performSegueWithIdentifier("idSegueToDiscover", sender: self)
	}
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		var destinationViewController = segue.destinationViewController as! UIViewController
		destinationViewController.transitioningDelegate = foodChoicesAnimatedTransistioningDelegate
		destinationViewController.modalPresentationStyle = .Custom
    }

}
