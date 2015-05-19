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
	let arcThickness: CGFloat = 2.0
	let gapBetweenArcs: CGFloat = CGFloat(M_PI) / 16.0
	let π: CGFloat = CGFloat(M_PI)
	let normalStrokeColor = UIColor.purpleColor()
	let selectedStrokeColor = UIColor.orangeColor()

	var arcCount = 0 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var arcSelectedIndex = 0 {
		didSet {
			setNeedsDisplay()
		}
	}

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
		var arcPath = UIBezierPath()
		normalStrokeColor.setStroke()
		
		if let firstAngle = firstArcAngle(arcCount) {
			var arcAngle = firstAngle
			for _ in 1...arcCount {
				arcPath = createArcPath(arcCenter: arcCenter, arcRadius: arcRadius, arcAngle: arcAngle)
				arcPath.lineWidth = arcThickness
				arcPath.stroke()
				arcAngle.startRadians = arcAngle.endRadians + gapBetweenArcs
				arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
			}
		}
		
		if let highliteArcAngle = arcAngleFor(arcIndex: arcSelectedIndex, numberOfArcs: arcCount) {
			arcPath = createArcPath(arcCenter: arcCenter, arcRadius: arcRadius, arcAngle: highliteArcAngle)
			selectedStrokeColor.setStroke()
			arcPath.lineWidth = arcThickness
			arcPath.stroke()
		}
    }
	
	func firstArcAngle(numberOfArcs: Int) -> ArcAngle? {
		var arcAngle: ArcAngle = (0.0, 0.0, 0.0)
		let topOfCircle = 1.5 * π
		if numberOfArcs > 0 {
			arcAngle.startRadians = topOfCircle + (gapBetweenArcs / 2)
			var totalGapRadians = gapBetweenArcs * CGFloat(numberOfArcs)
			var totalRadiansAvailableForArcs = 2.0 * π - totalGapRadians
			arcAngle.lengthRadians = totalRadiansAvailableForArcs / CGFloat(numberOfArcs)
			arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
			
			return arcAngle
		} else {
			return nil
		}
	}
	
	func arcAngleFor(#arcIndex: Int, numberOfArcs: Int) -> ArcAngle? {
		if arcIndex < 0 || arcIndex >= numberOfArcs {
			return nil
		}
		if let firstAngle = firstArcAngle(numberOfArcs) {
			var arcAngle = firstAngle
			for _ in 0..<arcIndex {
				arcAngle.startRadians = arcAngle.endRadians + gapBetweenArcs
				arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
			}
			return arcAngle
		} else {
			return nil
		}
	}

}
