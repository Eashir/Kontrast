//
//  KontrastTests.swift
//  KontrastTests
//
//  Created by Eashir Arafat on 8/23/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import XCTest
import Foundation
@testable import Kontrast

class KontrastTests: XCTestCase {
	
	var settingsVC = SettingsViewController()
	var cycleTextField = UITextField()
	
	override func setUp() {
		super.setUp()
		cycleTextField = settingsVC.cycleTextField
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testScoreIsComputedWhenGuessLTTarget() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		//given
		let guess = settingsVC.cycleDuration
		//when
		_ = settingsVC.isCycleLessThanTwenty(activeTextField: guess!)
		//then
		XCTAssertLessThan(settingsVC.cycleDuration, 20, "Cycle duration is 20 or greater")
	}
}
