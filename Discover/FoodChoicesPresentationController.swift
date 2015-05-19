//
//  FoodChoicesPresentationController.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class FoodChoicesPresentationController: UIPresentationController {
	
	override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
		super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView().frame = frameOfPresentedViewInContainerView()
	}
		
	override func presentationTransitionWillBegin() {
		presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
			}, completion: nil)
	}
	
	override func dismissalTransitionWillBegin() {
		presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context) -> Void in
			}, completion: nil)
	}

}
