//
//  CountdownTimer.swift
//  Kontrast
//
//  Created by Eashir Arafat on 7/11/18.
//  Copyright © 2018 Eashir Arafat. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class CountdownTimer {
	
	var totalTime = Int(Defaults[.timerDuration])
	var countDownTimer: Timer!
	
	func startTimer( completion: ((Bool) -> Void)?) { 
		countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
	}
	
	@objc func updateTime() {
//		timerLabel.text = "\(timeFormatted(totalTime))"
		
		if totalTime != 0 {
			totalTime -= 1
		} else {
			endTimer()
		}
	}
	
	func endTimer() {
		countDownTimer.invalidate()
	}
	
	func timeFormatted(_ totalSeconds: Int) -> String {
		let seconds: Int = totalSeconds % 60
		let minutes: Int = (totalSeconds / 60) % 60
		//     let hours: Int = totalSeconds / 3600
		return String(format: "%02d:%02d", minutes, seconds)
	}
	
}
