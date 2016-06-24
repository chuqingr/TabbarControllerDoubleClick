//
//  RectangleLayer.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
    let paddingSpace: CGFloat = 25
    
    override init() {
        super.init()
        fillColor = UIColor.blueColor().CGColor
        strokeColor = UIColor.blueColor().CGColor
        lineWidth = 7.0
        /**  圆角 */
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
        path = smallRectanglePath.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var smallRectanglePath: UIBezierPath {
        let smallPath = UIBezierPath()
        smallPath.moveToPoint(CGPointMake(0 + paddingSpace, 0 + paddingSpace))
        smallPath.addLineToPoint(CGPointMake(100.0 - paddingSpace, 0 + paddingSpace))
        smallPath.addLineToPoint(CGPointMake(100.0 - paddingSpace, 100.0 - paddingSpace))
        smallPath.addLineToPoint(CGPoint(x: 0 + paddingSpace, y: 100.0 - paddingSpace))
        smallPath.closePath()
        return smallPath
    }
    
    var leftRectanglePath: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPoint(x: 0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0 - paddingSpace, y: 0 + paddingSpace))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0 - paddingSpace, y: 100.0 - paddingSpace))
        rectanglePath.addLineToPoint(CGPoint(x: 0 + paddingSpace, y: 100.0 - paddingSpace))
        rectanglePath.closePath()
        return rectanglePath
    }
    
    var rightRectanglePath: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPoint(x: 0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0 - paddingSpace, y: 0 + paddingSpace))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        rectanglePath.addLineToPoint(CGPoint(x: 0 + paddingSpace, y: 100.0 - paddingSpace))
        rectanglePath.closePath()
        return rectanglePath
    }
    
    var topRectanglePath: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPoint(x: 0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        rectanglePath.addLineToPoint(CGPoint(x: 0 + paddingSpace, y: 100.0 - paddingSpace))
        rectanglePath.closePath()
        return rectanglePath
    }
    
    var bottomRectanglePath: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPoint(x: 0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 0))
        rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        rectanglePath.addLineToPoint(CGPoint(x: 0, y: 100.0))
        rectanglePath.closePath()
        return rectanglePath
    }
    
    /** triangle animate function  */
    func rectangleAnimate() {
        // left
        let rectangleAnimateLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
        rectangleAnimateLeft.fromValue = smallRectanglePath.CGPath
        rectangleAnimateLeft.toValue = leftRectanglePath.CGPath
        rectangleAnimateLeft.beginTime = 0.0
        rectangleAnimateLeft.duration = 1.5
        // right
        let rectangleAnimateRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
        rectangleAnimateRight.fromValue = leftRectanglePath.CGPath
        rectangleAnimateRight.toValue = rightRectanglePath.CGPath
        rectangleAnimateRight.beginTime = rectangleAnimateLeft.beginTime + rectangleAnimateLeft.duration
        rectangleAnimateRight.duration = 1.5
        // top
        let rectangleAnimateTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
        rectangleAnimateTop.fromValue = rightRectanglePath.CGPath
        rectangleAnimateTop.toValue = topRectanglePath.CGPath
        rectangleAnimateTop.beginTime = rectangleAnimateRight.beginTime + rectangleAnimateRight.duration
        rectangleAnimateTop.duration = 1.5
        //bottom
        let rectangleAnimateBottom: CABasicAnimation = CABasicAnimation(keyPath: "path")
        rectangleAnimateBottom.fromValue = topRectanglePath.CGPath
        rectangleAnimateBottom.toValue = bottomRectanglePath.CGPath
        rectangleAnimateBottom.beginTime = rectangleAnimateTop.beginTime + rectangleAnimateTop.duration
        rectangleAnimateBottom.duration = 1.5
        // group
        let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        triangleAnimationGroup.animations = [rectangleAnimateLeft, rectangleAnimateRight, rectangleAnimateTop,rectangleAnimateBottom]
        triangleAnimationGroup.duration = rectangleAnimateBottom.beginTime + rectangleAnimateBottom.duration
        triangleAnimationGroup.fillMode = kCAFillModeForwards
        triangleAnimationGroup.removedOnCompletion = false
        addAnimation(triangleAnimationGroup, forKey: nil)
    }


}
