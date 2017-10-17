//
//  SettingsViewController.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/13/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import ChameleonFramework
import UIKit
import SnapKit
import SwiftyUserDefaults

class SettingsViewController: UIViewController {
  
  var activeTextField: UITextField?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cycleTextField.delegate = self
    hotDurationTextField.delegate = self
    coldDurationTextField.delegate = self
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  // MARK: - Methods
  
  func doesInputStartWithZero(str: String) -> Bool {
    let characters = Array(str.characters)
    guard String(characters[0]) != "0" else {
      return false
    }
    return true
  }
  
  // MARK: - Actions
  
  func backButtonTapped(_ sender: UIButton) {
    let homeVC = HomeViewController()
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCAGravityCenter
    transition.subtype = kCATransitionFromRight
    self.navigationController?.view.window?.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(homeVC, animated: false)
  }
  
  // MARK: - Setup
  
  func setupViewHierarchy() {
    view.addSubview(radialBackgroundView)
    view.addSubview(backLabel)
    view.addSubview(backButton)
    view.addSubview(settingsLabel)
    view.addSubview(cycleSettingsView)
    view.addSubview(durationSettingsView)
    view.addSubview(cycleTextField)
    view.addSubview(hotDurationTextField)
    view.addSubview(coldDurationTextField)
    view.addSubview(hotLabel)
    view.addSubview(coldLabel)
  }
  
  func configureConstraints() {
    
    settingsLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(64 + Int(Layout.statusBarHeight))
    }
    
    cycleSettingsView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().offset(Layout.largeOffset)
      make.top.equalTo(settingsLabel.snp.bottom).offset(64)
      make.leading.equalToSuperview().offset(Layout.largeOffset)
      make.trailing.equalToSuperview().offset(-Layout.largeOffset)
    }
    
    cycleTextField.snp.makeConstraints { (make) in
      make.trailing.equalTo(cycleSettingsView)
      make.centerY.equalTo(cycleSettingsView.mainLabel.snp.centerY)
      make.height.equalTo(30)
      make.width.equalTo(40)
    }
    
    durationSettingsView.snp.makeConstraints { (make) in
      make.leading.trailing.equalTo(cycleSettingsView)
      make.top.equalTo(cycleSettingsView.infoLabel.snp.bottom).offset(Layout.mediumOffset)
    }
    
    coldDurationTextField.snp.makeConstraints { (make) in
      make.trailing.equalTo(durationSettingsView)
      make.centerY.equalTo(durationSettingsView.mainLabel.snp.centerY)
      make.height.equalTo(30)
      make.width.equalTo(40)
    }
    
    coldLabel.snp.makeConstraints { (make) in
      make.trailing.equalTo(coldDurationTextField.snp.leading).offset(-Layout.standardOffset)
      make.centerY.equalTo(coldDurationTextField.snp.centerY)
    }
    
    hotDurationTextField.snp.makeConstraints { (make) in
      make.trailing.equalTo(coldLabel.snp.leading).offset(-Layout.standardOffset)
      make.centerY.equalTo(coldDurationTextField.snp.centerY)
      make.height.equalTo(30)
      make.width.equalTo(40)
    }
    
    hotLabel.snp.makeConstraints { (make) in
      make.trailing.equalTo(hotDurationTextField.snp.leading).offset(-Layout.standardOffset)
      make.centerY.equalTo(coldDurationTextField.snp.centerY)
    }
    
    backLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(settingsLabel.snp.centerY)
      make.centerX.equalTo(cycleTextField.snp.centerX)
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
  
  // MARK: - Lazy Vars
  
  lazy var settingsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.standardWeight, size: Font.largeSize)
    label.textColor = ColorPalette.secondary
    label.text = "SETTINGS"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var cycleSettingsView: SettingsView = {
    let settingsView = SettingsView()
    settingsView.mainLabel.text = "Cycles"
    settingsView.infoLabel.text = "Each time you successfully shower through a round of hot water & a round of cold water, you complete a cycle"
    settingsView.translatesAutoresizingMaskIntoConstraints = false
    return settingsView
  }()
  
  lazy var durationSettingsView: SettingsView = {
    let settingsView = SettingsView()
    settingsView.mainLabel.text = "Duration"
    settingsView.infoLabel.text = "The time, in seconds, of the initial hot timer and succeeding cold timer. Recommended Hot:Cold ratio is 3:1"
    settingsView.translatesAutoresizingMaskIntoConstraints = false
    return settingsView
  }()
  
  lazy var backLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.lightWeight, size: Font.largeSize)
    label.textColor = ColorPalette.secondary
    label.text = "x"
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
  
  lazy var cycleTextField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    field.autocorrectionType = .yes
    field.backgroundColor = ColorPalette.secondary
    field.borderStyle = UITextBorderStyle.none
    field.font = UIFont(name: Font.standardWeight, size: Font.mediumSize)
    field.keyboardType = .numberPad
    field.layer.cornerRadius = 13
    field.returnKeyType = .done
    field.textColor = ColorPalette.primaryLight
    field.textAlignment = .center
    field.tag = 1
    field.text = "\(Int(Defaults[.numberOfCycles]))"
    return field
  }()
  
  lazy var hotLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.lightWeight, size: Font.standardSize)
    label.textColor = ColorPalette.secondaryDark
    label.text = "Hot"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var hotDurationTextField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    field.autocorrectionType = .yes
    field.backgroundColor = ColorPalette.secondary
    field.borderStyle = UITextBorderStyle.none
    field.font = UIFont(name: Font.standardWeight, size: Font.mediumSize)
    field.keyboardType = .numberPad
    field.layer.cornerRadius = 13
    field.returnKeyType = .done
    field.textColor = ColorPalette.primaryLight
    field.textAlignment = .center
    field.tag = 2
    field.text = "\(Int(Defaults[.hotDuration]))"
    return field
  }()
  
  lazy var coldLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.lightWeight, size: Font.standardSize)
    label.textColor = ColorPalette.secondaryDark
    label.text = "Cold"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var coldDurationTextField: UITextField = {
    let field = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    field.autocorrectionType = .yes
    field.backgroundColor = ColorPalette.secondary
    field.borderStyle = UITextBorderStyle.none
    field.font = UIFont(name: Font.standardWeight, size: Font.mediumSize)
    field.keyboardType = .numberPad
    field.layer.cornerRadius = 13
    field.returnKeyType = .done
    field.textColor = ColorPalette.primaryLight
    field.textAlignment = .center
    field.tag = 3
    field.text = "\(Int(Defaults[.coldDuration]))"
    return field
  }()
  
}

// MARK: - TextField Delegate

extension SettingsViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    activeTextField = textField
    print("did begin editing")
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard activeTextField == textField && activeTextField?.text != "" else {
      textField.resignFirstResponder()
      return
    }
    
    var activeTextFieldInput = Double((activeTextField?.text)!)!
    
    if doesInputStartWithZero(str: (activeTextField?.text!)!) {
      if let validTag = activeTextField?.tag {
        switch validTag {
          
        case 1:
          guard activeTextFieldInput < 20 else {
            return
          }
          Defaults[.numberOfCycles] = activeTextFieldInput
          
        case 2:
          guard activeTextFieldInput >=  (Double(Defaults[.coldDuration])) && activeTextFieldInput < 1200.0 else {
            return
          }
          Defaults[.hotDuration] = Int((activeTextField?.text)!)!
          Defaults[.hotToColdRatio] = (CGFloat(Double((activeTextField?.text)!)! / Double(Defaults[.coldDuration])))
          //Fix cold duration bug
        case 3:
          guard activeTextFieldInput <= (Double(Defaults[.hotDuration])) && activeTextFieldInput < 1200.0 else {
            return
          }
          Defaults[.hotToColdRatio] = (CGFloat(Double(Defaults[.hotDuration]) / activeTextFieldInput))
        default:
          break
        }
      }
    } else {
      activeTextFieldInput = 1.0
      return
    }
    
    activeTextField = nil
    print("did end editing")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print("should return")
    self.view.endEditing(true)
    return true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
}
