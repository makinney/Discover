//
//  YourChoicesAnimatedTransistioningDelegate.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class YourChoicesAnimatedTransistioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
	func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
		return BlurredBackgroundPresentationController(presentedViewController: presented, presentingViewController: presenting)
	}
	
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let yourChoicesPresentAnimatedTransistioning = YourChoicesPresentAnimatedTransistioning()
		return yourChoicesPresentAnimatedTransistioning
	}
	
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let yourChoicesDismissAnimatedTransistioning = YourChoicesDismissAnimatedTransistioning()
		return yourChoicesDismissAnimatedTransistioning
	}

}
