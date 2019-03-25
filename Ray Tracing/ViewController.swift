//
//  ViewController.swift
//  Ray Tracing
//
//  Created by Mateus Rodrigues on 25/03/19.
//  Copyright © 2019 Mateus Rodrigues. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let imageView = NSImageView()
    
    var image: NSImage? {
        let pixels = PixelSet(width: 200, height: 200, initialValue: Pixel.red)
        return NSImage(from: pixels)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        self.imageView.image = self.image
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

