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
  static var primaryLight = HexColor("F3F1EE")!
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
  
  static var statusBarHeight = UIApplication.shared.statusBarFrame.height
  
  static var standardOffset = 8
  static var mediumOffset = 24
  static var largeOffset = 24
  
}

struct Font {
  static var lightWeight: String = "HelveticaNeue-Light"
  
  static var standardSize: CGFloat = 16
  static var mediumSize: CGFloat = 20
  static var largeSize: CGFloat = 24
}
