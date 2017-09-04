////
////  HomeViewController+Setup.swift
////  Kontrast
////
////  Created by Eashir Arafat on 9/3/17.
////  Copyright © 2017 Eashir Arafat. All rights reserved.
////
//
//import UIKit
//import SnapKit
//import KDCircularProgress
//
//extension HomeViewController {
//  
//  var circularProgress: KDCircularProgress {
//    self.circularProgress.clockwise = true
//    self.circularProgress.glowMode = .forward
//    self.circularProgress.glowAmount = 0.9
//    self.circularProgress.gradientRotateSpeed = 25
//    self.circularProgress.progressThickness = 0.4
//    self.circularProgress.roundedCorners = true
//    self.circularProgress.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
//    self.circularProgress.startAngle = -90
//    self.circularProgress.trackThickness = 0.6
//    self.circularProgress.translatesAutoresizingMaskIntoConstraints = false
//    return self.circularProgress
//  }
//  
//  lazy var progressSlider: UISlider = {
//    let slider = UISlider()
//    slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .touchUpInside)
//    return slider
//  }()
//  
//  lazy var animateButton: UIButton = {
//    let button = UIButton()
//    button.addTarget(self, action: #selector(animateButtonTapped(_:)), for: .touchUpInside)
//    button.setTitle("START", for: .normal)
//    button.titleLabel?.textColor = .white
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
//    button.titleLabel?.minimumScaleFactor = 0.1
//    button.titleLabel?.adjustsFontSizeToFitWidth = true
//    button.setTitleColor(ColorPalette.white, for: .normal)
//    button.backgroundColor = ColorPalette.secondaryDark
//    button.layer.borderWidth = 2
//    button.layer.borderColor = ColorPalette.white.cgColor
//    button  .contentMode = .center
//    return button
//  }()
//  
//  lazy var redView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .red
//    return view
//  }()
//  
//  lazy var blueView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .blue
//    return view
//  }()
//  
//  lazy var yellowView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .yellow
//    return view
//  }()
//  
//  lazy var greenView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .green
//    return view
//  }()
//  
//  lazy var grayView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .gray
//    return view
//  }()
//}
//
