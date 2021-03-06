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
  
  static var primary = HexColor("F3F3F3")!
  static var primaryLight = HexColor("FFFFFF")!
  static var primaryDark = HexColor("C7C7C7")!
  
  static var secondary = HexColor("3A3938")!
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
  static var lightWeight: String = "Gotham-ExtraLight"
  static var standardWeight: String = "Gotham-Light"
  
  static var standardSize: CGFloat = 16
  static var mediumSize: CGFloat = 20
  static var largeSize: CGFloat = 24
}
