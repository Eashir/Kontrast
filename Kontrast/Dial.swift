//
//  Dial.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/3/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import KDCircularProgress
import Foundation

open class Dial: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViewHierarchy() {
    
  }
  
  func configureConstraints() {
    
  }
  
  lazy var HCircle: UIView = {
    let view = UIView()
    view.backgroundColor = ColorPalette.secondary
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var HCircularProgress: KDCircularProgress = {
    let progress = KDCircularProgress()
    progress.clockwise = true
    progress.glowMode = .forward
    progress.glowAmount = 0.9
    progress.gradientRotateSpeed = 25
    progress.progressThickness = 0.15
    progress.roundedCorners = true
    progress.set(colors: UIColor.white, UIColor.orange)
    progress.startAngle = -90
    progress.trackColor = ColorPalette.secondary
    progress.trackThickness = 0.15
    progress.translatesAutoresizingMaskIntoConstraints = false
    return progress
  }()
  
  lazy var HImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "dial")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

}
