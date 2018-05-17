//
//  CircleButton.swift
//  Scribe
//
//  Created by Valentinas Mirosnicenko on 1/11/17.
//  Copyright © 2017 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit
@IBDesignable

class CircleButton: UIButton {

    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
