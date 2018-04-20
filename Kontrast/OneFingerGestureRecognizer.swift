//
//  OneFingerGestureRecognizer.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/4/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UIKit
import UIKit.UIGestureRecognizerSubclass

class OneFingerRotationGestureRecognizer: UIGestureRecognizer {
  var midPoint = CGPoint.zero
  var innerRadius: CGFloat = 0.0
  var outerRadius: CGFloat = 0.0
  var cumulatedAngle: CGFloat = 0.0
  
  init(midPoint: CGPoint, innerRadius: CGFloat, outerRadius: CGFloat, cumulatedAngle: CGFloat) {
    super.init(target: nil, action: nil)
  }
  
  func distanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let dx: CGFloat = point1.x - point2.x
    let dy: CGFloat = point1.y - point2.y
    return sqrt(dx * dx + dy * dy)
  }
  
  func calculateAngleBetweenPoints(beginLineA: CGPoint, endLineA: CGPoint, beginLineB: CGPoint, endLineB: CGPoint) -> CGFloat {
    let a: CGFloat = endLineA.x - beginLineA.x
    let b: CGFloat = endLineA.y - beginLineA.y
    let c: CGFloat = endLineB.x - beginLineB.x
    let d: CGFloat = endLineB.y - beginLineB.y
    let atanA: CGFloat = atan2(a, b)
    let atanB: CGFloat = atan2(c, d)
    
    // Convert radians to degrees
    return (atanA - atanB) * 180 / .pi
  }
 }

// MARK: - UIGestureRecognizer implementation

extension OneFingerRotationGestureRecognizer {
  override func reset() {
    cumulatedAngle = 0
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    if touches.count != 1 {
      self.state = UIGestureRecognizerState.failed
      return
    }
  }
}
