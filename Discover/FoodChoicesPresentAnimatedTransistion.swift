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
		return 0.50 // TODO:
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		var animatingViewController:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		var animatingView = animatingViewController.view
		animatingView.frame = transitionContext.finalFrameForViewController(animatingViewController)
		animatingView.clipsToBounds = true
		
		var containerView = transitionContext.containerView()
		containerView.addSubview(animatingView)
		
		var presentedTransform = CGAffineTransformIdentity
		
		var scale = CGAffineTransformMakeScale(0.05,0.05)
		var xlat = CGAffineTransformMakeTranslation(0, 200)
		var dismissedTransform =  CGAffineTransformConcat(scale, xlat)
		
		animatingView.transform = dismissedTransform
		
		UIView.animateWithDuration(transitionDuration(transitionContext),
			delay: 0,
			options: UIViewAnimationOptions.CurveEaseIn,
			animations: { () -> Void in
				animatingView.transform = presentedTransform
			}) { (finished) -> Void in
				transitionContext.completeTransition(finished)
		}
	}

   
}
