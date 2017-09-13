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
import AVFoundation
import QuartzCore
import RealmSwift

class HomeViewController: UIViewController {
  
  var maxHTime = CGFloat()
  var player: AVAudioPlayer?
  var realm = try! Realm()
  
  var currentCycle = 0
  var numberOfCycles = 3
  
  var HGestureRecognizer: OneFingerRotationGestureRecognizer!
  var CGestureRecognizer: OneFingerRotationGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
    } catch { }
    
    setupViewHierarchy()
    configureConstraints()
    configureGestureRecognizers()
    
    roundOutViews()
  }
  
  //MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(HCircularProgress)
    view.addSubview(HLinesImageView)
    view.addSubview(HImageView)
    view.addSubview(timeLabel)
    view.addSubview(CCircle)
    view.addSubview(CCircularProgress)
    view.addSubview(CImageView)
    view.addSubview(startButton)
  }
  
  func configureConstraints() {
    
    radialBackgroundView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(2)
    }
    
    HCircularProgress.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.height.width.equalTo(200)
    }
    
    HLinesImageView.snp.makeConstraints { (make) in
      make.height.equalTo(HCircularProgress.snp.height).multipliedBy(0.8)
      make.width.equalTo(HCircularProgress.snp.width).multipliedBy(0.8)
      make.centerX.equalTo(HCircularProgress.snp.centerX)
      make.centerY.equalTo(HCircularProgress.snp.centerY)
    }
    
    HImageView.snp.makeConstraints { (make) in
      make.height.equalTo(HCircularProgress.snp.height).multipliedBy(0.7)
      make.width.equalTo(HCircularProgress.snp.width).multipliedBy(0.7)
      make.centerX.equalTo(HCircularProgress.snp.centerX)
      make.centerY.equalTo(HCircularProgress.snp.centerY)
    }
    
    timeLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(HImageView.snp.centerX)
      make.centerY.equalTo(HImageView.snp.centerY)
    }
    
    CCircularProgress.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(HCircularProgress.snp.bottom).offset(24)
      make.height.width.equalTo(200)
    }
    
    
    CCircle.snp.makeConstraints { (make) in
      make.height.equalTo(CCircularProgress.snp.height).multipliedBy(0.8)
      make.width.equalTo(CCircularProgress.snp.width).multipliedBy(0.8)
      make.centerX.equalTo(CCircularProgress.snp.centerX)
      make.centerY.equalTo(CCircularProgress.snp.centerY)
    }
    
    CImageView.snp.makeConstraints { (make) in
      make.height.equalTo(CCircularProgress.snp.height).multipliedBy(0.7)
      make.width.equalTo(CCircularProgress.snp.width).multipliedBy(0.7)
      make.centerX.equalTo(CCircularProgress.snp.centerX)
      make.centerY.equalTo(CCircularProgress.snp.centerY)
    }
    
    startButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-24)
      make.width.equalTo(100)
      make.height.equalTo(50)
    }
  }
  
  func configureGestureRecognizers() {
    // calculate center and radius of the control
    let HMidPoint = CGPoint(x: HCircularProgress.frame.origin.x + HCircularProgress.frame.size.width / 2, y: HCircularProgress.frame.origin.y + HCircularProgress.frame.size.height / 2)
    let HOutRadius = HCircularProgress.frame.size.width / 2
    HGestureRecognizer = OneFingerRotationGestureRecognizer(midPoint: HMidPoint, innerRadius: HOutRadius / 3, outerRadius: HOutRadius)
    HCircularProgress.addGestureRecognizer(HGestureRecognizer)
  }
  
  func roundOutViews() {
    CCircle.layoutIfNeeded()
    startButton.layoutIfNeeded()
    
      CCircle.makeViewCircular()
    startButton.roundButton()
  }
  
  func playSound() {
    guard let sound = NSDataAsset(name: "Metronome") else {
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

  //MARK: - Actions
  
  func animateButtonTapped(_ sender: UIButton) {
    print("\(Double(HGestureRecognizer.cumulatedAngle))")
    currentCycle = 0
    animate()
  }
  
  func animate() {
    guard currentCycle != numberOfCycles else {
      return
    }
    let HDuration = Double(HGestureRecognizer.cumulatedAngle/6)
    let CDuration = Double(HGestureRecognizer.cumulatedAngle/18)
    
    self.HCircularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  HDuration) { completed in
      guard completed != false else {
        print("HCProgess was interrupted")
        return
      }
      self.playSound()
      print("HCProgress completed")
      self.CCircularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  CDuration) { completed in
        guard completed != false else {
          print("CCProgess was interrupted")
          return
        }
        self.playSound()
        self.currentCycle += 1
        self.animate()
        print("CCProgress completed")
      }
    }
  }
  
  
  //MARK: - Lazy Vars
  
  lazy var radialBackgroundView: UIView = {
    let view = RadialGradientView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.secondary
    return label
  }()
  
  //Hot Dial
  
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
  
  lazy var HLinesImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "lines")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  //Cold Dial
  lazy var CCircle: UIView = {
    let view = UIView()
    view.backgroundColor = ColorPalette.secondary
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var CCircularProgress: KDCircularProgress = {
    let progress = KDCircularProgress()
    progress.clockwise = true
    progress.glowMode = .forward
    progress.glowAmount = 0.9
    progress.gradientRotateSpeed = 25
    progress.progressThickness = 0.15
    progress.roundedCorners = true
    progress.set(colors: UIColor.white, UIColor.cyan)
    progress.startAngle = -90
    progress.trackColor = ColorPalette.secondary
    progress.trackThickness = 0.15
    progress.translatesAutoresizingMaskIntoConstraints = false
    return progress
  }()
  
  lazy var CImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "dial")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var startButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(animateButtonTapped(_:)), for: .touchUpInside)
    button.backgroundColor = ColorPalette.primary
    button.contentMode = .center
    button.layer.borderWidth = 2
    button.layer.borderColor = ColorPalette.secondary.cgColor
    button.setTitleColor(ColorPalette.secondary, for: .normal)
    button.setTitle("START", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var settingsImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "settings")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

}
