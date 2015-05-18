//
//  ChoiceController.swift
//  Discover
//
//  Created by Michael Kinney on 5/18/15.
//  Copyright (c) 2015 mkinney. All rights reserved.
//

import Foundation

class ChoiceController {
	
	let choiceControlView: ChoiceControlView
	var choices = [String]()
	var choicesIndexingGenerator: IndexingGenerator<[String]>?
	var dataSourceDelegate: ChoiceControlProtocol? {
		didSet {
			load()
		}
	}
	
	var usersChoice: String {
		get {
			return choiceControlView.text
		}
		set {
			choiceControlView.text = newValue
		}
	}
	
	func choiceControlTouched() -> () {
		if let nextChoice = self.nextChoice() {
			self.usersChoice = nextChoice
		}
	}
	
	init(choiceControlView: ChoiceControlView) {
		self.choiceControlView = choiceControlView
		self.choiceControlView.controlTouched = choiceControlTouched
	}
		
	private func load() {
		if let dataSourceDelegate = dataSourceDelegate {
			choices = dataSourceDelegate.choices
			choiceControlView.arcCount = choices.count
			choicesIndexingGenerator = choices.generate()
			if let choice = choicesIndexingGenerator?.next() {
				usersChoice = choice // get the first one
			}
		}
	}
	
	func nextChoice() -> String? {
		var choice: String?
		if let choice = choicesIndexingGenerator?.next() {
			return choice
		} else {
			choicesIndexingGenerator = choices.generate()
			return choicesIndexingGenerator?.next()
		}
	}

	func reload() {
		load()
	}
	
	func shuffleChoices() {
		
	}
	
}
