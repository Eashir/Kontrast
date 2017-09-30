//
//  SettingsView.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/15/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class SettingsView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewHierarchy()
    configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  
  func setupViewHierarchy () {
    self.addSubview(mainLabel)
    self.addSubview(infoLabel)
  }
  
  func configureConstraints() {
    mainLabel.snp.makeConstraints { (make) in
      make.top.leading.equalToSuperview()
    }
    infoLabel.snp.makeConstraints { (make) in
      make.top.equalTo(mainLabel.snp.bottom).offset(Layout.standardOffset)
      make.leading.trailing.equalToSuperview()
    }
  }

  //MARK: - Lazy Vars
  
  lazy var mainLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.lightWeight, size: Font.mediumSize)
    label.textColor = ColorPalette.secondary
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var infoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Font.lightWeight, size: Font.standardSize)
    label.numberOfLines = 0
    label.textColor = ColorPalette.secondaryLight
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
}
