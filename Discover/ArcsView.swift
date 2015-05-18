//
//  ArcsView.swift
//  Discover
//
//  Created by Michael Kinney on 5/17/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

@IBDesignable

class ArcsView: UIView {

	typealias ArcAngle = (startRadians: CGFloat, endRadians: CGFloat, lengthRadians: CGFloat)
	var arcCount = 0 {
		didSet {
			setNeedsDisplay()
		}
	}
	let arcThickness: CGFloat = 1.0
	let gapBetweenArcs: CGFloat = CGFloat(M_PI) / 16.0
	let π: CGFloat = CGFloat(M_PI)
	let strokeColor = UIColor.purpleColor()

	func createArcPath(#arcCenter: CGPoint, arcRadius: CGFloat, arcAngle: ArcAngle) -> UIBezierPath {
		var path = UIBezierPath(arcCenter: arcCenter,
								radius: arcRadius,
								startAngle: arcAngle.startRadians,
								endAngle: arcAngle.endRadians,
								clockwise: true)
		return path
	}
 
    override func drawRect(rect: CGRect) {
		var arcRadius = (rect.width - arcThickness) / 2.0
		var arcCenter = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
		strokeColor.setStroke()
		if  arcCount > 0 {
			var arcAngle = firstArcAngleFor(arcCount)
			for _ in 1...arcCount {
				var archPath = createArcPath(arcCenter: arcCenter, arcRadius: arcRadius, arcAngle: arcAngle)
				archPath.lineWidth = arcThickness
				archPath.stroke()
				arcAngle.startRadians = arcAngle.endRadians + gapBetweenArcs
				arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
			}
		}
    }

	
	func firstArcAngleFor(arcCount: Int) -> ArcAngle {
		var arcAngle: ArcAngle = (0.0, 0.0, 0.0)
		let bottomOfCircle = π / 2.0
		var startOffset = (2.0 * π) / CGFloat(arcCount)
		arcAngle.startRadians = bottomOfCircle + startOffset + (gapBetweenArcs / 2)
		
		var totalRadiansUsedByGaps = gapBetweenArcs * CGFloat(arcCount)
		var totalRadiansAvailableForArcs = 2.0 * π - totalRadiansUsedByGaps
		arcAngle.lengthRadians = totalRadiansAvailableForArcs / CGFloat(arcCount)
		arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
		return arcAngle
	}

}
