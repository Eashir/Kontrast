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
    self.layer.cornerRadius = 25
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
