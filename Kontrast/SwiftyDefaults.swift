//
//  SwiftyDefaults.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/14/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import SwiftyUserDefaults
import Foundation

extension UserDefaults {
  subscript(key: DefaultsKey<Double>) -> Double {
    get { return unarchive(key) ?? 0.0}
    set { archive(key, newValue) }
  }
  
  subscript(key: DefaultsKey<Int>) -> Int {
    get { return unarchive(key) ?? 3}
    set { archive(key, newValue) }
  }
}

extension DefaultsKeys {
  static let hotWaterDuration = DefaultsKey<Double>("hotWaterDuration")
  static let coldWaterDuration = DefaultsKey<Double>("coldWaterDuration")
  static let numberOfCycles = DefaultsKey<Int>("numberofCycles")
  static let hotToColdRatio = DefaultsKey<Int>("hotToColdRatio")
}

