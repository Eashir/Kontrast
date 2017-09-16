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
  subscript(key: DefaultsKey<Int>) -> Int {
    get { return unarchive(key) ?? 90}
    set { archive(key, newValue) }
  }
  
  subscript(key: DefaultsKey<Double>) -> Double {
    get { return unarchive(key) ?? 3.0}
    set { archive(key, newValue) }
  }
}

extension DefaultsKeys {
  static let hotDuration = DefaultsKey<Int>("hotDuration")
  static let coldDuration = DefaultsKey<Int>("coldDuration")
  static let numberOfCycles = DefaultsKey<Double>("numberofCycles")
  static let hotToColdRatio = DefaultsKey<Double>("hotToColdRatio")
}

