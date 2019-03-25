//
//  Pixel.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation

public struct Pixel {
    
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.r = red
        self.g = green
        self.b = blue
        self.a = 255
    }
    
    static var red: Pixel {
        return Pixel(red: 255, green: 0, blue: 0)
    }
    
    static var green: Pixel {
        return Pixel(red: 0, green: 255, blue: 0)
    }
    
    static var blue: Pixel {
        return Pixel(red: 0, green: 0, blue: 255)
    }
    
    static var black: Pixel {
        return Pixel(red: 0, green: 0, blue: 0)
    }
    
    static var size: Int {
        return MemoryLayout<Pixel>.size
    }
    
}
