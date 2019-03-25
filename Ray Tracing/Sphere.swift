//
//  Sphere.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Cocoa
import simd

class Sphere {
    
    let center: float3
    let radius: Float
    let color: NSColor
    
    var kRed: Float {
        return Float(color.redComponent)
    }
    var kGreen: Float {
        return Float(color.greenComponent)
    }
    var kBlue: Float {
        return Float(color.blueComponent)
    }
    
    var sRed: Float = 0.5
    var sGreen: Float = 0.5
    var sBlue: Float = 0.5
    
    init(center: float3, radius: Float, color: NSColor) {
        self.center = center
        self.radius = radius
        self.color = color
    }
    
    func hit(with ray: Ray) -> Float? {
        let oc = ray.origin - center
        let a = simd_dot(ray.direction, ray.direction)
        let b = simd_dot(oc, 2.0*ray.direction)
        let c = simd_dot(oc, oc) - radius * radius
        let discriminant = b * b - 4 * a * c
        if discriminant < 0 {
            return nil
        } else {
            return (-b - sqrt(discriminant)) / (2.0 * a)
        }
    }
    
}
