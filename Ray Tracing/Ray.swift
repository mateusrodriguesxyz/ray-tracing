//
//  Ray.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation
import simd

struct Ray {
    
    var origin: float3
    var direction: float3
    
    func pointAt(t: Float) -> float3 {
        let point: float3 = origin + t*direction
        return point
    }
    
}

