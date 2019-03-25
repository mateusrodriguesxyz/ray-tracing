//
//  Light.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Cocoa
import simd

class Light {
    
    var origin: float3
    var color: NSColor
    
    var iRed: Float {
        return Float(color.redComponent)
    }
    var iGreen: Float {
        return Float(color.greenComponent)
    }
    var iBlue: Float {
        return Float(color.blueComponent)
    }
    
    init(origin: float3, color: NSColor) {
        self.origin = origin
        self.color = color
    }
    
    convenience init(origin: float3, r: CGFloat, g: CGFloat, b: CGFloat) {
        let color = NSColor(red: r, green: g, blue: b, alpha: 1.0)
        self.init(origin: origin, color: color)
    }
    
}
