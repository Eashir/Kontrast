//
//  OneFingerGestureRecognizer.swift
//  Kontrast
//
//  Created by Eashir Arafat on 9/4/17.
//  Copyright © 2017 Eashir Arafat. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

//protocol OneFingerRotationGestureRecognizerDelegate: NSObjectProtocol {
//   /** A rotation gesture is in progress, the frist argument is the rotation-angle in degrees. */
//  func rotation(_ angle: CGFloat)
//  
//  /** The gesture is finished, the first argument is the total rotation-angle. */
//  func finalAngle(_ angle: CGFloat)
//}

class OneFingerRotationGestureRecognizer: UIGestureRecognizer {
  var midPoint = CGPoint.zero
  var innerRadius: CGFloat = 0.0
  var outerRadius: CGFloat = 0.0
  var cumulatedAngle: CGFloat = 0.0
//  weak var target: OneFingerRotationGestureRecognizerDelegate?
  
  init(midPoint: CGPoint, innerRadius: CGFloat, outerRadius: CGFloat, target: Any) {
    super.init(target: target, action: nil)
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
    // convert radiants to degrees
    return (atanA - atanB) * 180 / .pi
  }
 }

// MARK: - UIGestureRecognizer implementation

extension OneFingerRotationGestureRecognizer {
  /** Calculates the distance between point1 and point 2. */
  
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
    if gestureRecognizer.state == .failed {
      return
    }
    let nowPoint: CGPoint? = touches.first?.location(in: view)
    let prevPoint: CGPoint? = touches.first?.previousLocation(in: view)
    // make sure the new point is within the area
    let distance: CGFloat = gestureRecognizer.distanceBetweenPoints(point1: gestureRecognizer.midPoint, point2: nowPoint!)
    
    //    if innerRadius <= distance && distance <= outerRadius {
    // calculate rotation angle between two points
    var angle: CGFloat = gestureRecognizer.angleBetweenLinesInDegrees(beginLineA: gestureRecognizer.midPoint, endLineA: prevPoint!, beginLineB: gestureRecognizer.midPoint, endLineB: nowPoint!)
    // fix value, if the 12 o'clock position is between prevPoint and nowPoint
    if angle > 180 {
      angle -= 360
    }
    else if angle < -180 {
      angle += 360
    }
    
    // sum up single steps
    gestureRecognizer.cumulatedAngle += angle
    HDTimeLabel.text = ("\(gestureRecognizer.cumulatedAngle)")
    print("CUMULATED ANGLE \(gestureRecognizer.cumulatedAngle)")
    // call delegate
    //      if (target?.responds(to: #selector(rotation)))! {
    
    //    target?.rotation(angle)
    //      }
    //    }
    //    else {
    //      // finger moved outside the area
    //      state = UIGestureRecognizerState.failed
    //    }
  }
}
