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
  
  static var primary = HexColor("212121")!
  static var primaryLight = HexColor("484848")!
  static var primaryDark = HexColor("000000")!
  
  static var secondary = HexColor("37474f")!
  static var secondaryLight = HexColor("62727b")!
  static var secondaryDark = HexColor("102027")!
  
  static var white = UIColor.white
}

struct Layout {
  
  // Dynamic Screen Size
  static var screenWidth = UIScreen.main.bounds.width
  static var screenHeight = UIScreen.main.bounds.height
  
  static var standardOffset = 8
  static var mediumOffset = 24
  static var largeOffset = 48
  
}
