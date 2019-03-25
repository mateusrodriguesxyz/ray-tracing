//
//  NSImage+Extension.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Foundation

import Cocoa

extension NSImage {
    
    convenience init?(from pixels: PixelSet) {
        
        let bitsPerComponent: Int = 8
        let bitsPerPixel: Int = 32
        
        var data = pixels.array
        let providerRef = CGDataProvider(
            data: NSData(bytes: &data, length: data.count * Pixel.size)
        )
        
        let cgimage = CGImage(
            width: pixels.width,
            height: pixels.height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: Int(bitsPerPixel),
            bytesPerRow: pixels.width * Pixel.size,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: CGColorRenderingIntent.defaultIntent)
        
        if cgimage != nil {
            self.init(cgImage: cgimage!, size: NSZeroSize)
        } else {
            return nil
        }
    }
    
}
