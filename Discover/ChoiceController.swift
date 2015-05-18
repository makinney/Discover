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
	
	var displayChoice: String {
		get {
			return choiceControlView.displayedText
		}
		set {
			choiceControlView.displayedText = newValue
		}
	}
	
	init(choiceControlView: ChoiceControlView) {
		self.choiceControlView = choiceControlView
	}
		
	private func load() {
		if let dataSourceDelegate = dataSourceDelegate {
			choices = dataSourceDelegate.choices
			choicesIndexingGenerator = choices.generate()
			choiceControlView.arcCount = choices.count
			if let choice = choices.first {
				displayChoice = choice
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
