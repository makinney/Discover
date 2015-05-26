//
//  ArcModel.Swift

//  Discover
//
//  Created by Michael Kinney on 5/23/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

typealias IngredientArcAngle = (startRadians: CGFloat, endRadians: CGFloat, lengthRadians: CGFloat)

struct ArcModel {
	let gapBetweenArcs: CGFloat = CGFloat(M_PI) / 16.0
	let π: CGFloat = CGFloat(M_PI)
	var arcCenter = CGPoint(x: 0, y: 0)
	var arcDiameter: CGFloat = 50.0
	var arcRadius: CGFloat = 0.0
	var arcThickness: CGFloat = 2.0
	var arcCount: Int = 1
	
	init(circleCenter arcCenter: CGPoint, circleDiameter arcDiameter: CGFloat, arcThickness: CGFloat, numberOfArcs arcCount: Int) {
		self.arcCenter = arcCenter
		self.arcDiameter = arcDiameter
		self.arcThickness = arcThickness
		self.arcRadius = (self.arcDiameter - self.arcThickness) / 2
		self.arcCount = arcCount
	}
	
	func arcPaths() -> [UIBezierPath] {
		var paths = [UIBezierPath]()
		var arcPath: UIBezierPath!
		
		if let firstAngle = firstArcAngle(arcCount) {
			var arcAngle = firstAngle
			for _ in 1...arcCount {
				arcPath = createArcPath(arcCenter: arcCenter, arcRadius: arcRadius, arcAngle: arcAngle)
				arcPath.lineWidth = arcThickness
				paths.append(arcPath)
				arcAngle.startRadians = arcAngle.endRadians + gapBetweenArcs
				arcAngle.endRadians = arcAngle.startRadians + arcAngle.lengthRadians
			}
		}
		return paths
	}
	
	func arcPath(arcIndex: Int) -> UIBezierPath? {
		var path: UIBezierPath?
		if let highliteArcAngle = arcAngleFor(arcIndex: arcIndex, numberOfArcs: arcCount) {
			path = createArcPath(arcCenter: arcCenter, arcRadius: arcRadius, arcAngle: highliteArcAngle)
			path!.lineWidth = arcThickness
		}
		return path
	}
	
	private func createArcPath(#arcCenter: CGPoint, arcRadius: CGFloat, arcAngle: IngredientArcAngle) -> UIBezierPath {
		var path = UIBezierPath(arcCenter: arcCenter,
			radius: arcRadius,
			startAngle: arcAngle.startRadians,
			endAngle: arcAngle.endRadians,
			clockwise: true)
		return path
	}
	
	private func firstArcAngle(numberOfArcs: Int) -> IngredientArcAngle? {
		var arcAngle: IngredientArcAngle = (0.0, 0.0, 0.0)
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
	
	private func arcAngleFor(#arcIndex: Int, numberOfArcs: Int) -> IngredientArcAngle? {
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