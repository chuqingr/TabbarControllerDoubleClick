//
//  AnimationView.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    
    let circleLayer = CircleLayer()
    let rectangleLayer = RectangleLayer()
    var triangleLayer = TriangleLayer()
    let waveLayer = WaveLayer()
     var parentFrame: CGRect = CGRectZero


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
//        addCircleLayer()
//        showRectangleAnimation()
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self, selector: #selector(drawRedRectangleAnimation), userInfo: nil, repeats: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /** add circle layer*/
    func addCircleLayer() {
        self.layer.addSublayer(circleLayer)
        circleLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(wobbleCircleLayer), userInfo: nil, repeats: false)
    }
    /**
     circle layer wobble animation
     */
    func wobbleCircleLayer() {
        circleLayer.rockAnimate()
    }
    
    /**
     show triangle animation
     */
    func showRectangleAnimation() {
        self.layer.addSublayer(rectangleLayer)
        rectangleLayer.rectangleAnimate()
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(transformAnima), userInfo: nil, repeats: false)
    }
    
    /**
     self transform and add rectangle
     */
    func transformAnima() {
        transformRotationZ()
//        circleLayer.contract()
//        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self, selector: #selector(drawRedRectangleAnimation), userInfo: nil, repeats: false)
//        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self, selector: #selector(drawBlueRectangleAnimation), userInfo: nil, repeats: false)
    }
    
    /** self transform z */
    func transformRotationZ() {
        self.layer.anchorPoint = CGPointMake(0.5, 0.65)
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
    }
    
    
    /** draw red stroke  */
    func drawRedRectangleAnimation() {
        layer.addSublayer(triangleLayer)
        triangleLayer.strokeChangeWithColor(UIColor.greenColor())
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(drawWaveAnimation), userInfo: nil, repeats: false)
    }
    
    func drawWaveAnimation() {
        layer.addSublayer(waveLayer)
        waveLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(expandView), userInfo: nil, repeats: false)
    }
    
    
    func expandView() {
        backgroundColor = UIColor.redColor()
        frame = CGRectMake(frame.origin.x - triangleLayer.lineWidth,
                           frame.origin.y - triangleLayer.lineWidth,
                           frame.size.width + triangleLayer.lineWidth * 2,
                           frame.size.height + triangleLayer.lineWidth * 2)
        layer.sublayers = nil
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frame = SCREEN_BOUNDS
            }, completion: { finished in
//                self.delegate?.completeAnimation()
        })
        
    }

}
