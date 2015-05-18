//
//  ChoiceControlView.swift
//  Discover
//
//  Created by Michael Kinney on 5/16/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import UIKit

@IBDesignable

class ChoiceControlView: UIView {
	
	@IBOutlet weak var arcView: ArcsView!
	@IBOutlet weak var circleView: CircleView!
	@IBOutlet weak var usersChoice: UILabel!
	
	var text: String {
		get {
			return usersChoice.text ?? String()
		}
		set {
			usersChoice.text = newValue
		}
	}
	
	var arcCount: Int {
		get {
			return arcView.arcCount
		}
		set {
			arcView.arcCount = newValue
		}
	}
	
	var controlTouched:(() -> ())?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init(coder: NSCoder) {
		super.init(coder: coder)
		var objs = NSBundle.mainBundle().loadNibNamed("ChoiceControlView", owner: self, options: nil)
		var view = objs.last as? UIView
		self.frame = view!.frame
		setTranslatesAutoresizingMaskIntoConstraints(false)
		self.addSubview(view!)
		let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
		self.addGestureRecognizer(tapRecognizer)
	}

	override func intrinsicContentSize() -> CGSize {
		return CGSizeMake(138, 138)
	}
	
	class func requiresContraintBasedLayout() -> Bool {
		return true
	}
	
	func tapped() {
		controlTouched?()
	}
}

