//
//  WalkthroughViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/19/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import Lottie

class WalkthroughViewController: UIViewController, UIScrollViewDelegate {
  
  var animationView = LOTAnimationView(name: "PartOne")
  var animationViewTwo = LOTAnimationView(name: "PartTwo")
  
  var isAnimating = false
  var animationStringArray = ["PartOne", "PartTwo", "PartThree", "PartOne"]
  var walkthroughStringArray = ["A contrast shower is an awesome way to start your day","How does it work? You begin with hot water and then switch to cold. Set the timer to 90 seconds, and when you’re ready to step into the shower, hit that START button!", "Make sure the waters really hot (but not burning). As soon as the timer runs out, you'll hear a sound. Thats your queue to switch to icy cold water!", "Congrats trooper, you’ve just completed a cycle. Repeat this at least three more times :)(:"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let _ = UIApplication.shared.setStatusBarHidden(false, with: .slide)
    
    setupViewHierarchy()
    configureConstraints()
    
    scrollView.delegate = self
    setupScrollView()
    setupPageController()
    animationView.play()
//    partOneAnimationView.play()
  }
  
  // MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(walkthroughLabel)
    view.addSubview(scrollView)
    view.addSubview(partOneAnimationView)
    view.addSubview(partTwoAnimationView)
    view.addSubview(diveInButton)
  }
  
  func configureConstraints() {
    walkthroughLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(70)
      make.trailing.equalTo(-70)
      make.top.equalToSuperview().offset(100)
    }
    
    radialBackgroundView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(2)
    }
    
    partOneAnimationView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.equalTo(300)
      make.height.equalTo(400)
    }
    
    partTwoAnimationView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.equalTo(300)
      make.height.equalTo(400)
    }
    
    diveInButton.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview().offset(-8)
      make.centerX.equalToSuperview()
      make.width.equalTo(80)
    }
    
    scrollView.snp.makeConstraints { (make) in
      make.bottom.leading.trailing.top.equalToSuperview()
    }
  }

  ///MARK: - ScrollView
  
  func setupScrollView() {
    scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: view.frame.size.height)
    
    for i in 0...3  {
      let label = UILabel(frame: CGRect(x: scrollView.center.x + CGFloat(i) * self.view.frame.size.width, y: ((self.view.frame.size.height) * (0.77)), width: self.view.frame.size.width  , height: 150))
      animationView.frame = CGRect(x: scrollView.center.x + CGFloat(i) * self.view.frame.size.width, y: ((self.view.frame.size.height) * (0.77)), width: self.view.frame.size.width  , height: self.view.frame.size.width)
      label.font = UIFont(name: "Code-Pro-Demo", size: 20)
      label.textAlignment = .center
      label.text = walkthroughStringArray[i]
      label.backgroundColor = .black
      label.textColor = .white
//      scrollView.addSubview(label)
      scrollView.addSubview(animationView)
      animationView.snp.makeConstraints({ (make) in
        make.centerY.centerX.equalToSuperview()
      })
    }
   }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let progress = scrollView.contentOffset.x / scrollView.contentSize.width
//    kagamiAnimationView.animationProgress = progress
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
    guard isAnimating == false else {
      return
    }
    pageController.currentPage = currentPage
    
    switch currentPage {
    case 0:
      self.isAnimating = true
      partOneAnimationView.play(completion: { (completed) in
        if completed {
          self.isAnimating = false
          
          UIView.animate(withDuration: 5.0, animations: { 
              self.partOneAnimationView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
          })
        }
      })
    case 1:
      self.isAnimating = true
      partTwoAnimationView.play(completion: { (completed) in
        if completed {
          self.isAnimating = false
          
          UIView.animate(withDuration: 5.0, animations: {
            self.partTwoAnimationView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
          })
          
          
          
        }
      })
    case 2:
      break
    case 3:
      diveInButton.alpha = 0
      diveInButton.isHidden = false
      UIView.animate(withDuration: 1.0) {
        self.diveInButton.alpha = 1
      }
    default:
      break
    }
    
  }
  
  // MARK: - PageController
  
  func setupPageController() {
    scrollView.addSubview(pageController)
    let _ = [
      pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
      pageController.leftAnchor.constraint(equalTo: view.leftAnchor),
      pageController.rightAnchor.constraint(equalTo: view.rightAnchor),
      ].map{$0.isActive = true
    }
  }

  // MARK: - Actions
  
  func diveIn() {
    let navigationController = KontrastNavigationController()
    self.present(navigationController, animated: true, completion: nil)
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
  
  // MARK: - Lazy Vars
  
  lazy var pageController: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .white
    pageControl.numberOfPages = 4
    return pageControl
  }()
  
  lazy var scrollView: UIScrollView = {
    var view: UIScrollView = UIScrollView()
    view.isPagingEnabled = true
    view.backgroundColor = .clear
    view.alpha = 0.9
    return view
  }()

  lazy var partOneAnimationView: LOTAnimationView = {
    var view: LOTAnimationView = LOTAnimationView(name: "PartOne")
    view.contentMode = .scaleAspectFill
    //    view.loopAnimation = true
    
    return view
  }()
  
  lazy var partTwoAnimationView: LOTAnimationView = {
    var view: LOTAnimationView = LOTAnimationView(name: "PartTwo")
    view.contentMode = .scaleAspectFill
    //    view.loopAnimation = true
    
    return view
  }()
  
  lazy var radialBackgroundView: UIView = {
    let view = RadialGradientView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var walkthroughLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Light", size: FontSize.mediumSize)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = ColorPalette.secondary
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var diveInButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.addTarget(self, action: #selector(diveIn), for: .touchUpInside)
    button.backgroundColor = ColorPalette.primaryLight
    button.contentMode = .center
    button.layer.borderWidth = 2
    button.layer.borderColor = ColorPalette.secondary.cgColor
    button.setTitleColor(ColorPalette.secondary, for: .normal)
    button.setTitle("ENTER", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
    button.titleLabel?.minimumScaleFactor = 0.1
    button.titleLabel?.textColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

}
