//
//  float3+Extension.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation
import simd

extension float3 {
    
    static var zero: float3 {
        return float3(0, 0, 0)
    }
    
    var basis: (float3, float3, float3) {
        let ww = simd_normalize(self)
        let uu = simd_normalize(float3(x: -ww.y, y: ww.x, z: ww.z))
        let vv = simd_cross(ww, uu)
        return (ww, uu, vv)
    }
    
    var lenght: Float {
        return simd_length(self)
    }
    
    var normalize: float3 {
        return simd_normalize(self)
    }
    
}

func * (left: simd_float3, right: simd_float3) -> simd_float3 {
    return simd_cross(left, right)
}
