//
//  KontrastNavigationViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/15/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import ChameleonFramework

class KontrastNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.styleProperties()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func styleProperties() {
    self.setStatusBarStyle(.default)
    
    self.navigationBar.isHidden = true
    
    // Default Background Color of Navigation
    self.navigationBar.barTintColor = ColorPalette.white
    
    // Font Colors
    self.navigationBar.tintColor = ColorPalette.primary
    
    // Title Font
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorPalette.primary, NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 18)!]
    
    // Transparent Off
    self.transparentOn()
  }
  
  func transparentOn() {
    self.navigationBar.isTranslucent = true
  }
  
  func transparentOff() {
    self.navigationBar.isTranslucent = false
  }
}
