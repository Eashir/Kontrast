//
//  WalkthroughViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/19/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import AVFoundation
import ChameleonFramework
import Lottie
import SwiftyUserDefaults

class WalkthroughViewController: UIViewController {
  
  var partOneAnimationView = LOTAnimationView(name: "PartOne")
  var partTwoAnimationView = LOTAnimationView(name: "PartTwo")
  var partThreeAnimationView = LOTAnimationView(name: "PartThree")

  var walkthroughStringArray = ["WELCOME! \n\nA contrast shower is an awesome \nway to start your day","\n\nSet the timer by rotating it, and then hit start right before you're ready to step into the shower. \n\n\n\n\n\n\n\n Recommended duration is 90 seconds!", "Make sure the waters VERY hot (but not burning). As soon as the timer runs out, you'll hear a sound", "Thats your queue to switch to icy cold water!", "\n\n Continue to keep alternating at every ding as this will repeat 3 more times by default \n\n\n\n Benefits include:\n\n - Improved Breathing \n - Heightened Focus \n - Enhanced Blood Circulation"]
  
  var delegate: AudioPlayer?
  
  override var prefersStatusBarHidden : Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let homeVC = HomeViewController()
    self.delegate = homeVC
    
    setupViewHierarchy()
    configureConstraints()
    roundOutViews()
    
    scrollView.delegate = self
    setupScrollView()
    
    partOneAnimationView.play()
  }
  
  // MARK: - Setup
  
  func setupScrollView() {
    scrollView.contentSize = CGSize(width: self.view.frame.size.width * 5, height: view.frame.size.height)
    for i in 0...4  {
      let textView = UITextView(frame: CGRect(x: scrollView.center.x + CGFloat(i) * self.view.frame.size.width, y: ((self.view.frame.size.height) * (0.1)), width: self.view.frame.size.width, height: 400))
      textView.backgroundColor = .clear
      textView.contentInset = UIEdgeInsets(top: 0, left: CGFloat(Layout.mediumOffset), bottom: 0, right: CGFloat(Layout.mediumOffset))
      textView.font = UIFont(name: Font.lightWeight, size: Font.mediumSize)
      textView.isUserInteractionEnabled = false
      textView.text = walkthroughStringArray[i]
      textView.textAlignment = .center
      textView.textColor = ColorPalette.secondaryDark
      scrollView.addSubview(textView)
    }
  }
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(walkthroughLabel)
    view.addSubview(scrollView)
    view.addSubview(diveInButton)
    view.addSubview(pageController)
    
    scrollView.addSubview(partOneAnimationView)
    scrollView.addSubview(partTwoAnimationView)
    scrollView.addSubview(partThreeAnimationView)
    
    partTwoAnimationView.addSubview(hotImageView)
    partThreeAnimationView.addSubview(coldImageView)
  }
  
  func configureConstraints() {
    
    coldImageView.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(partThreeAnimationView.snp.top).offset(60)
      make.size.equalTo(Layout.screenWidth / 7.5)
    }
    
    diveInButton.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().offset(-Layout.largeOffset)
      make.centerX.equalToSuperview()
      make.width.equalTo(90)
      make.height.equalTo(50)
    }
    
    hotImageView.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(partTwoAnimationView.snp.top).offset(60)
      make.size.equalTo(Layout.screenWidth / 7.5)
    }
    
    pageController.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().offset(-100)
      make.centerX.equalToSuperview()
      make.width.equalTo(Layout.screenWidth / 3.75)
      make.height.equalTo(pageController.snp.width).multipliedBy(0.5)
    }
    
    partOneAnimationView.snp.makeConstraints({ (make) in
      make.centerX.equalTo(self.scrollView.snp.centerX)
      make.centerY.equalTo(self.scrollView)
      make.height.equalTo(Layout.screenHeight / 1.66)
      make.width.equalTo(Layout.screenWidth / 1.25)
    })
    
    partTwoAnimationView.snp.makeConstraints({ (make) in
      make.centerX.equalTo(self.scrollView.snp.centerX).offset(self.view.frame.size.width * 2)
      make.centerY.equalTo(self.scrollView)
      make.height.equalTo(Layout.screenHeight / 1.66)
      make.width.equalTo(Layout.screenWidth / 1.25)
    })
    
    partThreeAnimationView.snp.makeConstraints({ (make) in
      make.centerX.equalTo(self.scrollView.snp.centerX).offset(self.view.frame.size.width * 3)
      make.centerY.equalTo(self.scrollView)
      make.height.equalTo(Layout.screenHeight / 1.66)
      make.width.equalTo(Layout.screenWidth / 1.25)
    })
    
    radialBackgroundView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(2)
    }
    
    scrollView.snp.makeConstraints { (make) in
      make.bottom.leading.trailing.top.equalToSuperview()
    }
    
    walkthroughLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(70)
      make.trailing.equalTo(-70)
      make.top.equalToSuperview().offset(70)
    }
    
  }
  
  // MARK: - Actions
  
  func diveIn() {
    Defaults[.didSeeWalkthrough] = true
    
    let homeVC = HomeViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityCenter
    transition.subtype = kCATransitionFromRight
    self.navigationController?.view.window?.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(homeVC, animated: false)
  }
  
  func backButtonTapped(_ sender: UIButton) {
    let homeVC = HomeViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityCenter
    transition.subtype = kCATransitionFromRight
    self.navigationController?.view.window?.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(homeVC, animated: false)
  }
  
  // MARK: - Methods
  
  func roundOutViews() {
    diveInButton.layoutIfNeeded()
    diveInButton.roundButton()
  }
  
  // MARK: - Lazy Vars
  
  lazy var coldImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "Cold")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var diveInButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.addTarget(self, action: #selector(diveIn), for: .touchUpInside)
    button.backgroundColor = ColorPalette.primaryLight
    button.contentMode = .center
    button.isHidden = true
    button.setTitleColor(ColorPalette.secondary, for: .normal)
    button.setTitle("ENTER", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: Font.lightWeight, size: Font.standardSize)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var hotImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "Hot")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var pageController: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .white
    pageControl.numberOfPages = 5
    return pageControl
  }()
  
  lazy var radialBackgroundView: UIView = {
    let view = RadialGradientView()
    var primary = HexColor("FFFFFF")!
    var primaryDark = HexColor("E1DDD8")!
    view.colors = [primary, primaryDark]
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var scrollView: UIScrollView = {
    var view: UIScrollView = UIScrollView()
    view.alpha = 0.9
    view.backgroundColor = .clear
    view.isPagingEnabled = true
    view.showsHorizontalScrollIndicator = false
    return view
  }()
  
  lazy var walkthroughLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.standardWeight, size: Font.mediumSize)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = ColorPalette.secondary
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
}

// MARK: - Scroll View Delegate

extension WalkthroughViewController: UIScrollViewDelegate {
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    pageController.currentPage = currentPage
    
    switch currentPage {
    case 0:
      partOneAnimationView.play()
    case 1:
      break
    case 2:
      partTwoAnimationView.play()
    case 3:
      self.delegate?.playSound()
      partThreeAnimationView.play()
    case 4:
      diveInButton.alpha = 0
      diveInButton.isHidden = false
      UIView.animate(withDuration: 1.0) {
        self.diveInButton.alpha = 1
      }
    default:
      break
    }
  }
  
}
