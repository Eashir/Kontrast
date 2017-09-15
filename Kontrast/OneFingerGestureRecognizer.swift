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
  
  func angleBetweenLinesInDegrees(beginLineA: CGPoint, endLineA: CGPoint, beginLineB: CGPoint, endLineB: CGPoint) -> CGFloat {
    let a: CGFloat = endLineA.x - beginLineA.x
    let b: CGFloat = endLineA.y - beginLineA.y
    let c: CGFloat = endLineB.x - beginLineB.x
    let d: CGFloat = endLineB.y - beginLineB.y
    let atanA: CGFloat = atan2(a, b)
    let atanB: CGFloat = atan2(c, d)
    // convert radians to degrees
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

extension HomeViewController: UIGestureRecognizerDelegate {
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if rotationGestureRecognizer.state == .failed {
      return
    }
    
    let midPoint = CGPoint(x: circularProgress.frame.origin.x + circularProgress.frame.size.width / 2, y: circularProgress.frame.origin.y + circularProgress.frame.size.height / 2)
    let outRadius = circularProgress.frame.size.width / 2
    let nowPoint: CGPoint? = touches.first?.location(in: view)
    let prevPoint: CGPoint? = touches.first?.previousLocation(in: view)
    //Make sure the new point is within the area
    let distance: CGFloat = rotationGestureRecognizer.distanceBetweenPoints(point1: midPoint, point2: nowPoint!)
    
    //Make sure that the rotation gesture is on the circular progress
    guard rotationGestureRecognizer.innerRadius <= distance && distance <= outRadius else {
      rotationGestureRecognizer.state = .failed
      return
    }
    
    //Calculate angle between two touch points
    var angle: CGFloat = rotationGestureRecognizer.angleBetweenLinesInDegrees(beginLineA: midPoint, endLineA: prevPoint!, beginLineB: midPoint, endLineB: nowPoint!)
    if angle > 180 {
      angle -= 360
    }
    else if angle < -180 {
      angle += 360
    }
    
    let duration = Double((rotationGestureRecognizer.cumulatedAngle + angle)/6)
    
    guard duration > 0 && duration <= Defaults[.hotWaterDuration] else {
      return
    }
    
    rotationGestureRecognizer.cumulatedAngle += angle
    
    let totalTime = Double((rotationGestureRecognizer.cumulatedAngle)/6)
    
    Defaults[.hotWaterDuration] = totalTime
    Defaults[.coldWaterDuration] = totalTime / Double(Defaults[.hotToColdRatio])
    
    timeLabel.text = "\(Defaults[.hotWaterDuration])"
    print("CUMULATED ANGLE \(rotationGestureRecognizer.cumulatedAngle)")
    
    if Int(rotationGestureRecognizer.cumulatedAngle) != (Int(rotationGestureRecognizer.cumulatedAngle) + Int(angle)) {
      linesImageView.transform = linesImageView.transform.rotated(by: CGFloat(rotationGestureRecognizer.cumulatedAngle))
    }
  }
  
}
