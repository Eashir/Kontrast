//
//  Constants.swift
//  Kontrast
//
//  Created by Eashir Arafat on 8/23/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import Foundation
import ChameleonFramework

struct ColorPalette {
  
  static var primary = HexColor("FFFFFF")!
  static var primaryDark = HexColor("E1DDD8")!
  
  static var secondary = HexColor("5f5a53")!
  static var secondaryLight = HexColor("8c877f")!
  static var secondaryDark = HexColor("35312a")!
  
  static var white = UIColor.white
}

struct Layout {
  
  // Dynamic Screen Size
  static var screenWidth = UIScreen.main.bounds.width
  static var screenHeight = UIScreen.main.bounds.height
  
  static var standardOffset = 8
  static var mediumOffset = 24
}
