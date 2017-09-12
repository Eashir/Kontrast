//
//  Extensions.swift
//
//
//  Created by Eashir Arafat on 8/9/17.
//
//
import UIKit

public extension UIButton {
  func roundButton() {
    self.layer.cornerRadius = 4
  }
  
  func makeButtonCircular() {
    self.layer.cornerRadius = self.frame.width/2
  }
}

extension UIImageView {
  func roundImageView () {
    self.layer.cornerRadius = self.frame.width/2
    self.clipsToBounds = true
  }
  
  func borderImageView() {
    self.layer.borderWidth = 1.5
//    self.layer.borderColor = AppColors.primary.cgColor
  }
}

extension UIView {
  func roundView() {
    self.layer.cornerRadius = 4
  }
  
  func makeViewCircular() {
    self.layer.cornerRadius = self.frame.width/2
    self.clipsToBounds = true
  }
}
