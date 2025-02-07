//
//  Array+Additions.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 7/2/25.
//

import SwiftUI

extension Array where Element == CGPoint {
  /// Returns a new array of points using Catmull–Rom spline interpolation.
  /// The `segments` parameter determines how many interpolated points are inserted between each segment.
  func catmullRomInterpolated(segments: Int) -> [CGPoint] {
    // If there aren’t enough points, just return the original array.
    guard self.count >= 4 else { return self }
    
    var interpolatedPoints: [CGPoint] = []
    
    // Loop over the points (using groups of 4).
    for i in 1 ..< self.count - 2 {
      let p0 = self[i - 1]
      let p1 = self[i]
      let p2 = self[i + 1]
      let p3 = self[i + 2]
      
      // Insert interpolated points between p1 and p2.
      for j in 0 ... segments {
        let t = CGFloat(j) / CGFloat(segments)
        let t2 = t * t
        let t3 = t2 * t
        
        // Catmull-Rom formula for x and y.
        let x = 0.5 * ((2 * p1.x) +
                       (-p0.x + p2.x) * t +
                       (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t2 +
                       (-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * t3)
        let y = 0.5 * ((2 * p1.y) +
                       (-p0.y + p2.y) * t +
                       (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t2 +
                       (-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * t3)
        
        interpolatedPoints.append(CGPoint(x: x, y: y))
      }
    }
    
    return interpolatedPoints
  }
}

