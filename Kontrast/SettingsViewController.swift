//
//  SettingsViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/13/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import Hero
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewHierarchy()
    configureConstraints()
  }
  
  //MARK: - Actions
  
  func backButtonTapped(_ sender: UIButton) {
    let homeVC = HomeViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityCenter
    transition.subtype = kCATransitionFromRight
    view.window!.layer.add(transition, forKey: kCATransition)
    present(homeVC, animated: false, completion: nil)
  }
  
  //MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(backLabel)
    view.addSubview(backButton)
    view.addSubview(settingsLabel)
  }
  
  func configureConstraints() {
    settingsLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(Layout.mediumOffset + Int(Layout.statusBarHeight))
    }
    
    backLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(settingsLabel.snp.centerY)
      make.trailing.equalToSuperview().offset(-Layout.mediumOffset)
    }
    
    backButton.snp.makeConstraints { (make) in
      make.size.equalTo(100)
      make.centerX.equalTo(backLabel.snp.centerX)
      make.centerY.equalTo(backLabel.snp.centerY)
    }
    
    radialBackgroundView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(2)
    }
  }
  
  //MARK: - Lazy Vars
  
  lazy var settingsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Light", size: 28)
    label.textColor = ColorPalette.secondary
    label.text = "SETTINGS"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var backLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
    label.textColor = ColorPalette.secondary
    label.text = "X"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var backButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var radialBackgroundView: UIView = {
    let view = RadialGradientView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
}
