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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        setupConstraints()

        let sphere = Sphere(center: float3.zero, radius: 3, color: #colorLiteral(red: 0, green: 0.7941015959, blue: 0.3129233718, alpha: 1))
        let camera = Camera(origin: float3(5, 5, 0), focalDistance: 15, left: -5, right: 5, top: 5, bottom: -5)
        camera.projection = .orthographic
        let light = Light(origin: float3(4, 4, 4), color: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
        light.shading = .blinnPhong
        
        rayTrace(sphere: sphere, camera: camera, light: light, at: &pixels)
        
        imageView.image = NSImage(from: pixels)
        
    }
    
    func rayTrace(sphere: Sphere, camera: Camera, light: Light, at pixels: inout PixelSet) {
        
        let width = pixels.width
        let height = pixels.height
        
        pixels.forEach { (i, j) -> Pixel in
            
            let (l, r, t, b) = camera.settings
            
            let u = l + ((r - l)*(Float(i) + 0.5))/Float(width)
            let v = b + ((t - b)*(Float(j) + 0.5))/Float(height)
            
            let ray = camera.getRay(u: u, v: v, projection: camera.projection)
            
            let color = getColor(sphere, ray, camera: camera, light: light, shading: light.shading)
            
            return Pixel(red: UInt8(color.x*255), green: UInt8(color.y*255), blue: UInt8(color.z*255))
        }
    }
    
    func getColor(_ sphere: Sphere, _ r: Ray, camera: Camera, light: Light, shading: Shading) -> float3 {
        
        guard let hit = sphere.hit(with: r) else {
            return float3.zero
        }
        
        func lambertComponent() -> (r: Float, g: Float, b: Float) {
            let normal = simd_normalize(r.pointAt(t: hit)/sphere.radius)
            let r = sphere.kRed * light.iRed * max(0, simd_dot(light.origin.normalize, normal))
            let g = sphere.kGreen * light.iGreen * max(0, simd_dot(light.origin.normalize, normal))
            let b = sphere.kBlue * light.iBlue * max(0, simd_dot(light.origin.normalize, normal))
            return (r, g, b)
        }
        
        func blinnPhongComponent() -> (r: Float, g: Float, b: Float) {
            let normal = simd_normalize(r.pointAt(t: hit)/sphere.radius)
            let h = (light.origin + camera.origin).normalize
            let specularAngle = max(0, simd_dot(normal, h))
            let specular = pow(specularAngle, 15)
            let r = sphere.sRed * light.iRed * specular
            let g = sphere.sGreen * light.iGreen * specular
            let b = sphere.sBlue * light.iBlue * specular
            return (r, g, b)
        }
        
        switch shading {
            case .lambert:
                let r = min(1, lambertComponent().r)
                let g = min(1, lambertComponent().g)
                let b = min(1, lambertComponent().b)
                return float3(r, g, b)
            case .blinnPhong:
                let r = min(1, lambertComponent().r + blinnPhongComponent().r)
                let g = min(1, lambertComponent().g + blinnPhongComponent().g)
                let b = min(1, lambertComponent().b + blinnPhongComponent().b)
                return float3(r, g, b)
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

