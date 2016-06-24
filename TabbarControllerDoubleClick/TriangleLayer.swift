//
//  TriangleLayer.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
    
    override init() {
        super.init()
        fillColor = UIColor.clearColor().CGColor
        lineWidth = 4.0
        path = rectangleFullPath.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rectangleFullPath: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPoint(x: 50.0, y: 100.0))
        rectanglePath.addLineToPoint(CGPoint(x: -50, y: -lineWidth))
        rectanglePath.addLineToPoint(CGPoint(x: 150.0, y: -lineWidth))
        rectanglePath.addLineToPoint(CGPoint(x: 50.0, y: 100.0))
        rectanglePath.closePath()
        return rectanglePath
    }
    
    /** line stroke color change with custom color */
    func strokeChangeWithColor(color: UIColor) {
        strokeColor = color.CGColor
        let strokeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.beginTime = 0
        strokeAnimation.duration = 4
        addAnimation(strokeAnimation, forKey: nil)
    }
    

}
