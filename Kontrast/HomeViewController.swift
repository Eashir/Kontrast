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

class HomeViewController: UIViewController {
 
  var HDAngle: CGFloat = 0.0
  var player: AVAudioPlayer?
  
  var HGestureRecognizer: OneFingerRotationGestureRecognizer!
  var CGestureRecognizer: OneFingerRotationGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColorPalette.primary
    setupViewHierarchy()
    configureConstraints()
    configureGestureRecognizers()
  }
  
  //MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(HCircularProgress)
    view.addSubview(HImageView)
    view.addSubview(HTimeLabel)
    view.addSubview(CCircularProgress)
    view.addSubview(CImageView)
    view.addSubview(CTimeLabel)
    view.addSubview(animateButton)
  }
  
  func configureConstraints() {
    HCircularProgress.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(24)
      make.height.width.equalTo(200)
    }
    
    HImageView.snp.makeConstraints { (make) in
      make.top.equalTo(HCircularProgress.snp.top)
      make.bottom.equalTo(HCircularProgress.snp.bottom)
      make.leading.equalTo(HCircularProgress.snp.leading)
      make.trailing.equalTo(HCircularProgress.snp.trailing)
    }
    
    HTimeLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(HCircularProgress.snp.top).offset(24)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    CCircularProgress.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(HCircularProgress.snp.bottom).offset(24)
      make.height.width.equalTo(200)
    }
    
    CImageView.snp.makeConstraints { (make) in
      make.top.equalTo(CCircularProgress.snp.top)
      make.bottom.equalTo(CCircularProgress.snp.bottom)
      make.leading.equalTo(CCircularProgress.snp.leading)
      make.trailing.equalTo(CCircularProgress.snp.trailing)
    }
    
    CTimeLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(CCircularProgress.snp.top).offset(24)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
    
    animateButton.snp.makeConstraints { (make) in
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
    
    let CMidPoint = CGPoint(x: HCircularProgress.frame.origin.x + HCircularProgress.frame.size.width / 2, y: HCircularProgress.frame.origin.y + HCircularProgress.frame.size.height / 2)
    let COutRadius = HCircularProgress.frame.size.width / 2
    CGestureRecognizer = OneFingerRotationGestureRecognizer(midPoint: CMidPoint, innerRadius: COutRadius / 3, outerRadius: COutRadius)
    CCircularProgress.addGestureRecognizer(CGestureRecognizer)
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
//    
    HImageView.removeFromSuperview()
    CImageView.removeFromSuperview()
    
    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 1
    animationGroup.repeatCount = .infinity
    
      HCircularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  Double(HGestureRecognizer.cumulatedAngle/6)) { completed in
        if completed {
          self.playSound()
          print("animation stopped, completed")
          self.CCircularProgress.animate(fromAngle: 360.0, toAngle: 0.0, duration:  Double(self.HGestureRecognizer.cumulatedAngle/18)) { completed in
            if completed {
              self.playSound()
              print("animation stopped, completed")
            } else {
              print("animation stopped, cold dial was interrupted")
            }
          }
        } else {
          print("animation stopped, hot dial was interrupted")
        }
      }
    
    animationGroup.animations = [HCircularProgress.progressLayer.animation(forKey: "angle")!, CCircularProgress.progressLayer.animation(forKey: "angle")!]
    
  }
  
  //MARK: - Lazy Vars
  
  //Hot Dial
  lazy var HTimeLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.white
    return label
  }()
  
  lazy var HCircularProgress: KDCircularProgress = {
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
  
  lazy var HImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "dial")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  //Cold Dial
  lazy var CTimeLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorPalette.white
    return label
  }()
  
  lazy var CCircularProgress: KDCircularProgress = {
    let progress = KDCircularProgress()
    progress.clockwise = true
    progress.glowMode = .forward
    progress.glowAmount = 0.9
    progress.gradientRotateSpeed = 25
    progress.progressThickness = 0.4
    progress.roundedCorners = true
    progress.set(colors: UIColor.white, UIColor.cyan)
    progress.startAngle = -90
    progress.trackThickness = 0.6
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
  
  lazy var animateButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(animateButtonTapped(_:)), for: .touchUpInside)
    button.backgroundColor = ColorPalette.secondaryDark
    button.contentMode = .center
    button.layer.borderWidth = 2
    button.layer.borderColor = ColorPalette.white.cgColor
    button.setTitleColor(ColorPalette.white, for: .normal)
    button.setTitle("START", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
}
