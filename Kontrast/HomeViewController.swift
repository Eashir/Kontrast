//
//  ViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 8/23/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import SnapKit
import KDCircularProgress

class HomeViewController: UIViewController {
  
  var imageAngle: CGFloat = 0.0
  var gestureRecognizer: UIGestureRecognizer!
  
  var midPoint = CGPoint.zero
  var innerRadius: CGFloat = 0.0
  var outerRadius: CGFloat = 0.0
  var cumulatedAngle: CGFloat = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColorPalette.primary
    setupViewHierarchy()
    configureConstraints()
    configureGestureRecognizer()
  }
  
  //MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(circularProgress)
    view.addSubview(animateButton)
    view.addSubview(progressSlider)
    view.addSubview(redView)
    view.addSubview(HDTimeLabel)
  }
  
  func configureConstraints() {
    circularProgress.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(24)
      make.height.width.equalTo(300)
    }
    
    animateButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-24)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
    
    progressSlider.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(animateButton.snp.top).inset(-24)
      make.height.equalTo(30)
      make.width.equalTo(circularProgress.snp.width)
    }
    
    redView.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(progressSlider.snp.bottom).offset(-24)
      make.width.equalTo(150)
      make.height.equalTo(150)
    }
    
    HDTimeLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(circularProgress.snp.top).offset(24)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
  }
  
  func configureGestureRecognizer() {
    // calculate center and radius of the control
    let midPoint = CGPoint(x: circularProgress.frame.origin.x + circularProgress.frame.size.width / 2, y: circularProgress.frame.origin.y + circularProgress.frame.size.height / 2)
    let outRadius = circularProgress.frame.size.width / 2
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    
    //    gestureRecognizer = OneFingerRotationGestureRecognizer(midPoint: midPoint, innerRadius: outRadius / 3, outerRadius: outRadius, target: self)
    redView.addGestureRecognizer(gestureRecognizer)
  }
  
  //MARK: - Actions
  
  func sliderDidChangeValue(_ sender: UISlider) {
    circularProgress.angle = Double(sender.value) * 100
  }
  
  func animateButtonTapped(_ sender: UIButton) {
    //    print("\(Double(gestureRecognizer.cumulatedAngle))")
    //    circularProgress.animate(fromAngle: Double(gestureRecognizer.cumulatedAngle), toAngle: Double(imageAngle), duration: 60) { completed in
    //      if completed {
    //        print("animation stopped, completed")
    //      } else {
    //        print("animation stopped, was interrupted")
    //      }
    //    }
  }
  
  //MARK: - Lazy Vars
  
  lazy var HDTimeLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.white
    return label
  }()
  
  lazy var circularProgress: KDCircularProgress = {
    let progress = KDCircularProgress()
    progress.clockwise = true
    progress.glowMode = .forward
    progress.glowAmount = 0.9
    progress.gradientRotateSpeed = 25
    progress.progressThickness = 0.4
    progress.roundedCorners = true
    progress.set(colors: UIColor.white, UIColor.orange)
    progress.startAngle = -90
    progress.trackThickness = 0.6
    progress.translatesAutoresizingMaskIntoConstraints = false
    return progress
  }()
  
  lazy var progressSlider: UISlider = {
    let slider = UISlider()
    slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .touchUpInside)
    return slider
  }()
  
  lazy var animateButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(animateButtonTapped(_:)), for: .touchUpInside)
    button.backgroundColor = ColorPalette.secondaryDark
    button.contentMode = .center
    button.layer.borderWidth = 2
    button.layer.borderColor = ColorPalette.white.cgColor
    button.setTitle("START", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(ColorPalette.white, for: .normal)
    return button
  }()
  
  lazy var redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
}

// MARK: - UIGestureRecognizer implementation

extension HomeViewController: UIGestureRecognizerDelegate {
  
  func distanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let dx: CGFloat = point1.x - point2.x
    let dy: CGFloat = point1.y - point2.y
    return sqrt(dx * dx + dy * dy)
  }
  
  func angleBetweenLinesInDegrees(beginLineA: CGPoint, endLineA: CGPoint, beginLineB: CGPoint, endLineB: CGPoint) -> CGFloat {
    let a: CGFloat = endLineA.x - beginLineA.x
    let b: CGFloat = endLineA.y - beginLineA.y
    let c: CGFloat = endLineB.x - beginLineB.x
    let d: CGFloat = endLineB.y - beginLineB.y
    let atanA: CGFloat = atan2(a, b)
    let atanB: CGFloat = atan2(c, d)
    // convert radiants to degrees
    return (atanA - atanB) * 180 / .pi
  }
  
  
  func reset() {
    cumulatedAngle = 0
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if touches.count != 1 {
      gestureRecognizer.state = UIGestureRecognizerState.failed
      return
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if gestureRecognizer.state == .failed {
      return
    }
    let nowPoint: CGPoint? = touches.first?.location(in: view)
    let prevPoint: CGPoint? = touches.first?.previousLocation(in: view)
    // make sure the new point is within the area
    let distance: CGFloat = distanceBetweenPoints(point1: midPoint, point2: nowPoint!)
    
    //    if innerRadius <= distance && distance <= outerRadius {
    // calculate rotation angle between two points
    var angle: CGFloat = angleBetweenLinesInDegrees(beginLineA: midPoint, endLineA: prevPoint!, beginLineB: midPoint, endLineB: nowPoint!)
    // fix value, if the 12 o'clock position is between prevPoint and nowPoint
    if angle > 180 {
      angle -= 360
    }
    else if angle < -180 {
      angle += 360
    }
    
    // sum up single steps
    cumulatedAngle += angle
    print("CUMULATED ANGLE \(cumulatedAngle)")
    // call delegate
    //      if (target?.responds(to: #selector(rotation)))! {
    
    //    target?.rotation(angle)
    //      }
    //    }
    //    else {
    //      // finger moved outside the area
    //      state = UIGestureRecognizerState.failed
    //    }
  }
  
  
}
