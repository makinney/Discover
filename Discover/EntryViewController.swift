//
//  EntryViewController.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	
	let discoverAnimatedTransistioningDelegate = DiscoverAnimatedTransistioningDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let tapRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped:")
		self.view.addGestureRecognizer(tapRecognizer)
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		performSegueWithIdentifier("idSegueToDiscover", sender: self)
	}
	
	func viewTapped(tapRecognizer: UITapGestureRecognizer) {
		performSegueWithIdentifier("idSegueToDiscover", sender: self)
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		var destinationViewController = segue.destinationViewController as! UIViewController
		destinationViewController.transitioningDelegate = discoverAnimatedTransistioningDelegate
		destinationViewController.modalPresentationStyle = .Custom
    }

}
