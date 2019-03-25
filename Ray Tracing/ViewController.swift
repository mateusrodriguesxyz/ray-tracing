//
//  ViewController.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Cocoa
import simd

class ViewController: NSViewController {
    
    let imageView = NSImageView()
    
    var pixels = PixelSet(width: 300, height: 300, initialValue: Pixel.black)
    
    var image: NSImage? {
        let pixels = PixelSet(width: 200, height: 200, initialValue: Pixel.red)
        return NSImage(from: pixels)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        setupConstraints()
        
        let e = float3(10, 10, 0)
        
        let l: Float = -5.0
        let r: Float = 5.0
        let t: Float = 5.0
        let b: Float = -5.0
        
        let width = pixels.width
        let height = pixels.height
        
        let sphere = Sphere(center: float3.zero, radius: 3)
        
        let camera = Camera(origin: e, focalDistance: 15, left: l, right: r, top: t, bottom: b)
        
        pixels.forEach { (i, j) -> Pixel in
            
            let u = l + ((r - l)*(Float(i) + 0.5))/Float(width)
            let v = b + ((t - b)*(Float(j) + 0.5))/Float(height)
            
            let ray = camera.getRay(u: u, v: v, projection: .oblique)
            
            let color = getColor(sphere, ray)
            
            return Pixel(red: UInt8(color.x*255), green: UInt8(color.y*255), blue: UInt8(color.z*255))
        }
        
        imageView.image = NSImage(from: pixels)
        
    }
    
    func getColor(_ sphere: Sphere, _ r: Ray) -> float3 {
        if let hit = sphere.hit(with: r) {
            let hitVector = simd_normalize(r.pointAt(t: hit)/sphere.radius)
            let r = max(0, hitVector.lenght)
            let g = max(0, hitVector.lenght)
            let b = max(0, hitVector.lenght)
            return float3(r, g, b)
        } else {
            return float3.zero
        }
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

