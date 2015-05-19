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
	}
		
	init(choiceControlView: ChoiceControlView) {
		self.choiceControlView = choiceControlView
		self.choiceControlView.controlTouched = choiceControlTouched
	}
	
	func choiceControlTouched() -> () {
		if let nextChoice = self.nextChoice() {
			updateDisplayedChoice(nextChoice)
		}
	}
	
	private func load() {
		if let dataSourceDelegate = dataSourceDelegate {
			choices = dataSourceDelegate.choices
			choiceControlView.arcCount = choices.count
			choicesIndexingGenerator = choices.generate()
			if let choice = choicesIndexingGenerator?.next() { // get the first one
				updateDisplayedChoice(choice)
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
	
	private func updateDisplayedChoice(choice: String) {
		choiceControlView.text = choice
		if let index = find(choices, choice) {
			choiceControlView.arcSelectedIndex = index
		}
	}
	
	// MARK: Shuffling
	
	var countdownTimer: NSTimer?
	var countDownTimeMax: CUnsignedInt = 4
	var countDownTimeMin: CUnsignedInt = 1
	var updateTimer: NSTimer?
	let updateTimerInterval = 0.5
	
	func shuffleChoices() {
		var randomCountdown = arc4random_uniform(countDownTimeMax - countDownTimeMin) + countDownTimeMin
		var countdownTime: NSTimeInterval = NSTimeInterval(randomCountdown)
		startUpdateTimer()
		startCountdownTimer(countdownTime)
	}
	
	func startCountdownTimer(timeout: NSTimeInterval) {
		countdownTimer?.invalidate()
		countdownTimer = NSTimer.scheduledTimerWithTimeInterval(timeout, target: self, selector: Selector("countdownTimerFired"), userInfo: nil, repeats: false)
	}
	
	func startUpdateTimer() {
		updateTimer?.invalidate()
		updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateTimerInterval, target: self, selector: Selector("updateTimerFired"), userInfo: nil, repeats: true)
	}
	
	@objc func updateTimerFired() {
		if let choice = nextChoice() {
			updateDisplayedChoice(choice)
		}
	}
	
	@objc func countdownTimerFired() {
		updateTimer?.invalidate()
		countdownTimer?.invalidate()
	}
	
	
}
