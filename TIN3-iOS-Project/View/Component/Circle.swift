//
//  Circle.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 28/12/16.
//  Copyright © 2016 Demian Dekoninck. All rights reserved.
//

import UIKit

@IBDesignable
class Circle: UIView {

    var color = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
       color.set()
        
        let circle = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: 4,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        
        circle.fill()
        circle.stroke()
    }
    
    /*
     TODO: if we don't set the background color to clear/white, we have a black background
     Don't know if this is the correct way to fix this.
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
    }
}
