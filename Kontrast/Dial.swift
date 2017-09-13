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
    circularProgress.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.height.width.equalTo(200)
    }
    
    dialImageView.snp.makeConstraints { (make) in
      make.height.equalTo(circularProgress.snp.height).multipliedBy(0.7)
      make.width.equalTo(circularProgress.snp.width).multipliedBy(0.7)
      make.centerX.equalTo(circularProgress.snp.centerX)
      make.centerY.equalTo(circularProgress.snp.centerY)
    }
    
    linesImageView.snp.makeConstraints { (make) in
      make.height.equalTo(circularProgress.snp.height).multipliedBy(0.8)
      make.width.equalTo(circularProgress.snp.width).multipliedBy(0.8)
      make.centerX.equalTo(circularProgress.snp.centerX)
      make.centerY.equalTo(circularProgress.snp.centerY)
    }
  }

  lazy var circularProgress: KDCircularProgress = {
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
  
  lazy var dialImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "dial")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var linesImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "lines")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

}
