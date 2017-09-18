//
//  ViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 8/23/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import AVFoundation
import UIKit
import SnapKit
import Hero
import SwiftyUserDefaults
import KDCircularProgress
import QuartzCore

class HomeViewController: UIViewController {
  
  var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
  var player: AVAudioPlayer?
  var rotationGestureRecognizer: OneFingerRotationGestureRecognizer!
  
  var currentCycle = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
    } catch { }
    
    setupViewHierarchy()
    configureConstraints()
    configureGestureRecognizers()
    
    roundOutViews()
    addSettingsAction()
  
    NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Background Task Management
  
  func registerBackgroundTask() {
    backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
      self?.endBackgroundTask()
    }
    assert(backgroundTask != UIBackgroundTaskInvalid)
  }
  
  func endBackgroundTask() {
    print("Background task ended.")
    UIApplication.shared.endBackgroundTask(backgroundTask)
    backgroundTask = UIBackgroundTaskInvalid
  }
  
  func reinstateBackgroundTask() {
    if circularProgress.isAnimating() && (backgroundTask == UIBackgroundTaskInvalid) {
      registerBackgroundTask()
    }
  }
  
  // MARK: - Methods
  
  func animate() {
    guard currentCycle != Int(Defaults[.numberOfCycles]) else {
      self.startButton.setTitle("START", for: .normal)
      return
    }
    
    // Adding 2 to durations to allow time to switch water temp
    self.circularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  Double(Defaults[.hotDuration] + 2)) { completed in
      guard completed != false else {
        print("Hot Progess was interrupted")
        self.startButton.setTitle("START", for: .normal)
        return
      }
      self.playSound()
      print("Hot Progress completed")
      self.circularProgress.set(colors: UIColor.white, UIColor.cyan)
      self.circularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  Double(Defaults[.coldDuration] + 2)) { completed in
        guard completed != false else {
          print("Cold Progess was interrupted")
          self.startButton.setTitle("START", for: .normal)
          return
        }
        self.playSound()
        self.currentCycle += 1
        self.animate()
        print("Cold Progress completed")
        self.circularProgress.set(colors: UIColor.white, UIColor.orange)
      }
    }
  }
  
  func addSettingsAction() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(settingsTapped(tapGestureRecognizer:)))
    settingsActionView.isUserInteractionEnabled = true
    settingsActionView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func playSound() {
    guard let sound = NSDataAsset(name: "Ding") else {
      print("asset not found")
      return
    }
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeMPEGLayer3)
      player!.play()
    } catch let error as NSError {
      print("error: \(error.localizedDescription)")
    }
  }
  
  func roundOutViews() {
    startButton.layoutIfNeeded()
    startButton.roundButton()
  }
  
  
  // MARK: - Actions
  
  func startOrStopTapped(_ sender: UIButton) {
    print("ANIMATE BUTTON TAPPED, CUMULATED ANGLE: \(Double(rotationGestureRecognizer.cumulatedAngle))")
    self.circularProgress.set(colors: UIColor.white, UIColor.orange)
    currentCycle = 0
    linesImageView.isHidden = true
    
    if sender.titleLabel?.text == "START" {
      startButton.setTitle("STOP", for: .normal)
      registerBackgroundTask()
      animate()
      if backgroundTask != UIBackgroundTaskInvalid {
        endBackgroundTask()
      }
    } else {
      circularProgress.stopAnimation()
      startButton.setTitle("START", for: .normal)
    }
  }
  
  func settingsTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    let settingsVC = SettingsViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityCenter
    transition.subtype = kCATransitionFromRight
    self.navigationController?.view.window?.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(settingsVC, animated: false)
  }
  
  // MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(circularProgress)
    view.addSubview(linesImageView)
    view.addSubview(dialImageView)
    view.addSubview(timeLabel)
    view.addSubview(startButton)
    view.addSubview(settingsImageView)
    view.addSubview(settingsActionView)
  }
  
  func configureConstraints() {
    
    circularProgress.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(Layout.screenHeight * 0.15)
      make.height.equalToSuperview().multipliedBy(0.42)
      make.width.equalTo(circularProgress.snp.height)
    }
    
    dialImageView.snp.makeConstraints { (make) in
      make.height.equalTo(circularProgress.snp.height).multipliedBy(0.72)
      make.width.equalTo(circularProgress.snp.width).multipliedBy(0.72)
      make.centerX.equalTo(circularProgress.snp.centerX)
      make.centerY.equalTo(circularProgress.snp.centerY)
    }
    
    linesImageView.snp.makeConstraints { (make) in
      make.height.equalTo(circularProgress.snp.height).multipliedBy(0.8)
      make.width.equalTo(circularProgress.snp.width).multipliedBy(0.8)
      make.centerX.equalTo(circularProgress.snp.centerX)
      make.centerY.equalTo(circularProgress.snp.centerY)
    }
    
    radialBackgroundView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(2)
    }
    
    timeLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(dialImageView.snp.centerX)
      make.centerY.equalTo(dialImageView.snp.centerY)
    }
    
    settingsActionView.snp.makeConstraints { (make) in
      make.centerX.equalTo(settingsImageView.snp.centerX)
      make.centerY.equalTo(settingsImageView.snp.centerY)
      make.size.equalTo(100)
    }
    
    settingsImageView.snp.makeConstraints { (make) in
      make.size.equalTo(30)
      make.trailing.equalToSuperview().offset(-Layout.mediumOffset)
      make.bottom.equalToSuperview().offset(-Layout.mediumOffset)
    }
    
    startButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-Layout.screenHeight * 0.2)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
  }
  
  func configureGestureRecognizers() {
    // Calculate center and radius of the control
    let HMidPoint = CGPoint(x: circularProgress.frame.origin.x + circularProgress.frame.size.width / 2, y: circularProgress.frame.origin.y + circularProgress.frame.size.height / 2)
    let HOutRadius = circularProgress.frame.size.width / 2
    let cumulatedAngle = CGFloat(Defaults[.hotDuration] * 6)
    
    rotationGestureRecognizer = OneFingerRotationGestureRecognizer(midPoint: HMidPoint, innerRadius: HOutRadius / 3, outerRadius: HOutRadius, cumulatedAngle: cumulatedAngle)
    circularProgress.addGestureRecognizer(rotationGestureRecognizer)
  }
  
  // MARK: - Lazy Vars
  
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
  
  lazy var radialBackgroundView: UIView = {
    let view = RadialGradientView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var startButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(startOrStopTapped(_:)), for: .touchUpInside)
    button.backgroundColor = ColorPalette.primaryLight
    button.contentMode = .center
    button.layer.borderWidth = 2
    button.layer.borderColor = ColorPalette.secondary.cgColor
    button.setTitleColor(ColorPalette.secondary, for: .normal)
    button.setTitle("START", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var settingsActionView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var settingsImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "settings")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.secondary
    label.font = UIFont(name: "HelveticaNeue-Light", size: FontSize.largeSize)
    label.text = "\(Int(Defaults[.hotDuration]))"
    return label
  }()
  
}

// MARK: - GestureRecognizer Delegate

extension HomeViewController: UIGestureRecognizerDelegate {
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if rotationGestureRecognizer.state == .failed {
      return
    }
    
    let midPoint = CGPoint(x: circularProgress.frame.origin.x + circularProgress.frame.size.width / 2, y: circularProgress.frame.origin.y + circularProgress.frame.size.height / 2)
    let outRadius = circularProgress.frame.size.width / 2
    let nowPoint: CGPoint? = touches.first?.location(in: view)
    let prevPoint: CGPoint? = touches.first?.previousLocation(in: view)
    // Make sure the new point is within the area
    let distance: CGFloat = rotationGestureRecognizer.distanceBetweenPoints(point1: midPoint, point2: nowPoint!)
    
    // Make sure that the rotation gesture is on the circular progress
    guard rotationGestureRecognizer.innerRadius <= distance && distance <= outRadius else {
      rotationGestureRecognizer.state = .failed
      return
    }
    
    //Calculate angle between two touch points
    var angle: CGFloat = rotationGestureRecognizer.angleBetweenLinesInDegrees(beginLineA: midPoint, endLineA: prevPoint!, beginLineB: midPoint, endLineB: nowPoint!)
    if angle > 180 {
      angle -= 360
    }
    else if angle < -180 {
      angle += 360
    }
    
    let duration = Int((rotationGestureRecognizer.cumulatedAngle + angle)/6)
    
    guard duration >= 0 else {
      return
    }
    
    // Rotation animation
    let rotationAngle = Int(rotationGestureRecognizer.cumulatedAngle)
    let totalRotationAngle = Int(rotationGestureRecognizer.cumulatedAngle) + Int(angle)
    
    if totalRotationAngle > rotationAngle {
      print("CUMULATED ANGLE: \(rotationAngle), TOTAL:  \(totalRotationAngle) ")
      linesImageView.transform = linesImageView.transform.rotated(by: -1200.0)
    } else if totalRotationAngle < rotationAngle {
      linesImageView.transform = linesImageView.transform.rotated(by: 1200.0)
    }
    
    rotationGestureRecognizer.cumulatedAngle += angle
    
    let totalDuration = Double((rotationGestureRecognizer.cumulatedAngle)/6)
    
    Defaults[.hotDuration] = Int(totalDuration)
    Defaults[.coldDuration] = Int(totalDuration) / Int(Defaults[.hotToColdRatio])
    
    timeLabel.text = "\(Defaults[.hotDuration])"
    print("CUMULATED ANGLE \(rotationGestureRecognizer.cumulatedAngle)")
  }
  
}
