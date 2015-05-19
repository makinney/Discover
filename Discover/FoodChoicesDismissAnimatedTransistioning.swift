//
//  FoodChoicesDismissAnimatedTransistioning.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class FoodChoicesDismissAnimatedTransistioning: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 0.25 // TODO:
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		var fromVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		var toVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		
		var containerView = transitionContext.containerView()
		var animatingVC = fromVC
		var animatingView = animatingVC.view
		animatingView.frame = transitionContext.finalFrameForViewController(animatingVC)
		
		var presentedTransform = CGAffineTransformIdentity
		var scale = CGAffineTransformMakeScale(0.01,0.01) // TODO: shrink to this size value
		var dismissedTransform = scale
		
		animatingView.transform = presentedTransform
		
		UIView.animateWithDuration(transitionDuration(transitionContext),
			delay: 0,
			options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState,
			animations: { () -> Void in
				animatingView.transform = dismissedTransform
			}) { (finished) -> Void in
				transitionContext.completeTransition(finished)
		}
	}

}
