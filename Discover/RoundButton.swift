//
//  RoundButton.swift
//  Discover
//
//  Created by Michael Kinney on 5/16/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

@IBDesignable

class RoundButton: UIButton {

	@IBInspectable var fillColor: UIColor = UIColor.blackColor()
	
    override func drawRect(rect: CGRect) {
		var path = UIBezierPath(ovalInRect: rect)
		fillColor.setFill()
		path.fill()
    }

}
