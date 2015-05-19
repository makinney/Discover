//
//  CircleView.swift
//  Discover
//
//  Created by Michael Kinney on 5/17/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

@IBDesignable

class CircleView: UIView {

	@IBInspectable var fillColor: UIColor = UIColor.grayColor().colorWithAlphaComponent(0.6)
	
	override func drawRect(rect: CGRect) {
		var path = UIBezierPath(ovalInRect: rect)
		fillColor.setFill()
		path.fill()
	}
}
