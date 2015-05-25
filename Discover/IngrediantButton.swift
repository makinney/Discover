//
//  IngrediantButton.swift
//  Discover
//
//  Created by Michael Kinney on 5/22/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

class IngrediantButton: UIButton {

	var defaultArcColor = UIColor.blackColor()
	var fillColor = UIColor.ingrediantTextBackground()
	var numberOfArcs = 1
	var selectedArcColor = UIColor.blackColor()
	var selectedArcIndex: Int?
	
	// MARK: methods
	
	func allArcsNormalColor() {
		selectedArcIndex = -1 // select nothing
		setNeedsDisplay()
	}

	// MARK: Drawing
	
	override func drawRect(rect: CGRect) {
		var arcCircleRect = rect
		var arcCircleCenter = CGPoint(x:arcCircleRect.width / 2, y: arcCircleRect.height / 2)
		var arcThickness: CGFloat = 3.0
		var arcModel = ArcModel(circleCenter: arcCircleCenter, circleDiameter: arcCircleRect.width, arcThickness: arcThickness, numberOfArcs: numberOfArcs)
		var arcPaths = arcModel.arcPaths()
		for arcPath in arcPaths {
			defaultArcColor.setStroke()
			arcPath.stroke()
		}
		
		if	let selectedArcIndex = selectedArcIndex,
			let arcPath = arcModel.arcPath(selectedArcIndex) {
			selectedArcColor.setStroke()
			arcPath.stroke()
		}
		
		var innerCircleInset: CGFloat = arcThickness + 2.0
		var innerCircleRect = arcCircleRect.rectByInsetting(dx: innerCircleInset, dy: innerCircleInset)
		var path = UIBezierPath(ovalInRect: innerCircleRect)
		fillColor.setFill()
		path.fill()
	}
}

