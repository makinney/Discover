//
//  FoodChoicesAnimatedTransistion.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class FoodChoicesPresentAnimatedTransistion: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 1.0 // TODO:
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		var animatingViewController:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		var animatingView = animatingViewController.view
		animatingView.frame = transitionContext.finalFrameForViewController(animatingViewController)
		animatingView.clipsToBounds = true
		
		var containerView = transitionContext.containerView()
		containerView.addSubview(animatingView)
		
		var presentedTransform = CGAffineTransformIdentity
		var scale = CGAffineTransformMakeScale(0.001,0.001)
		var dismissedTransform = scale
		
		animatingView.transform = dismissedTransform
		
		UIView.animateWithDuration(transitionDuration(transitionContext),
			delay: 0,
			options: UIViewAnimationOptions.CurveEaseInOut,
			animations: { () -> Void in
				animatingView.transform = presentedTransform
			}) { (finished) -> Void in
				transitionContext.completeTransition(finished)
		}
	}

   
}
