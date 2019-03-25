//
//  Camera.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation
import simd

class Camera {
    
    var origin: float3
    var focalDistance: Float
    var left: Float
    var right: Float
    var top: Float
    var bottom: Float
    
    init(origin: float3, focalDistance: Float, left: Float, right: Float, top: Float, bottom: Float) {
        self.origin = origin
        self.focalDistance = focalDistance
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }
    
    func getRay(u: Float, v: Float) -> Ray {
        let (ww, uu, vv) = origin.basis
        let direction = -focalDistance*ww + u*uu + v*vv
        return Ray(origin: self.origin, direction: direction)
    }
    
}
