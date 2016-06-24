//
//  CHFreshLayer.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/24.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit

let viewHeighte:CGFloat = 21.0
let pointWidth:CGFloat = 10.0
let scaletimeVale = 0.35
//** 十六进制转换颜色,需要写0x前缀 */
func CHColor(hex:Int) -> UIColor {
    let color = UIColor(colorLiteralRed: (Float)((hex & 0xFF0000) >> 16)/255.0, green: (Float)((hex & 0x00FF00) >> 8)/255.0, blue: (Float)(hex & 0x0000FF)/255.0, alpha: 1)
    return color
    
}

class CHFreshLayer: CALayer {
    var complete:CGFloat!{
        didSet{
            self.setNeedsDisplay()
        }
    }
    /**  动画属性 */
    var animationScale:CGFloat = 1
    /**  记录是否在动画 */
    var isAnimationing:Bool = true
    override var frame: CGRect{
        didSet {
            let newFrame = CGRectMake(0, 10, CGRectGetWidth(frame), 2 * viewHeighte)
            super.frame = newFrame
        }
    }

    
    let kName = "ScaleAnimationName"
    
    override class func needsDisplayForKey(key:String) -> Bool{
        if key == "animationScale" {
            return true
        }else {
            return super.needsDisplayForKey(key)
        }
    }
    
    func beginAnimation() {
        isAnimationing = true
        self.addScaleSmallAnimation()
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = M_PI * 2
        rotate.duration = 4 * scaletimeVale
        rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotate.repeatCount = HUGE
        rotate.fillMode = kCAFillModeForwards
        rotate.removedOnCompletion = false
        addAnimation(rotate, forKey: rotate.keyPath)
    }
    
    func addScaleSmallAnimation() {
        animationScale = 0.6
        let animation = CABasicAnimation(keyPath: "animationScale")
        animation.duration = scaletimeVale
        animation.fromValue = 1.0
        animation.toValue = 0.6
        animation.delegate = self
        animation.setValue("ScaleSmall", forKey: kName)
        addAnimation(animation, forKey: "animationScale")
    }
    
    func addScaleBigAnimation() {
        animationScale = 1.0
        let animation = CABasicAnimation(keyPath: "animationScale")
        animation.duration = scaletimeVale
        animation.fromValue = 0.6
        animation.toValue = 1.0
        animation.delegate = self
        animation.setValue("ScaleBig", forKey: kName)
        addAnimation(animation, forKey: "animationScale")
    }
    
    func stopAnimation() {
        if !isAnimationing {
            return
        }
        /**  待定~~ */
        self.isAnimationing = false
        self.removeAllAnimations()
        self.complete = 0.0
        self.setNeedsDisplay()
        
        
        
    }
    
    
    /**  计算方法 */
    func drawPointAtRect(center:CGPoint,ctx:CGContextRef,color:CGColorRef){
        CGContextSetFillColorWithColor(ctx, color)
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, center.x, center.y)
        CGPathAddArc(path, nil, center.x, center.y, pointWidth / 2, CGFloat(2 * M_PI), 0.0, true)
        CGPathCloseSubpath(path)
        CGContextAddPath(ctx, path)
        CGContextFillPath(ctx)
//        CGPathRelease(path)
    }
    
    func currentProportionPoint(starPoint:CGPoint,endPoint:CGPoint,scale:CGFloat) -> CGPoint {
        let lengthOfX = endPoint.x - starPoint.x
        let pointX = starPoint.x + lengthOfX * scale
        let lengthOfY = endPoint.y - starPoint.y
        let pointY = starPoint.y + lengthOfY * scale
        return CGPoint(x:pointX,y:pointY)
    }
    func drawLineInContextFromStartPointAndEndPointWithScale (ctx:CGContextRef,starPoint:CGPoint,endPoint:CGPoint,scale:CGFloat,storkeColor:UIColor){
        CGContextSetStrokeColorWithColor(ctx, storkeColor.CGColor)
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, starPoint.x, starPoint.y)
        let currentPoint = currentProportionPoint(starPoint, endPoint: endPoint, scale: scale)
        CGPathAddLineToPoint(path, nil, currentPoint.x, currentPoint.y)
        CGPathCloseSubpath(path)
        CGContextAddPath(ctx, path)
        CGContextSetLineWidth(ctx, pointWidth)
        CGContextSetLineJoin(ctx, .Round)
        CGContextStrokePath(ctx)
    }
    
       
    override func drawInContext(ctx:CGContextRef) {
        let center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2)
        let firstPoint = CGPointMake(center.x,center.y-viewHeighte+pointWidth/2)
        let secondPoint = CGPointMake(center.x-viewHeighte+pointWidth/2, center.y)
        let thirdPoint = CGPointMake(center.x, center.y+viewHeighte-pointWidth/2)
        let fourthPoint = CGPointMake(center.x+viewHeighte-pointWidth/2, center.y)
        if isAnimationing {
            let scale = self.animationScale
            let ScaleFirstPoint = currentProportionPoint(center, endPoint: firstPoint, scale: scale)
            let ScaleSecondPoint = currentProportionPoint(center, endPoint: secondPoint, scale: scale)
            let ScaleThiredPoint = currentProportionPoint(center, endPoint: thirdPoint, scale: scale)
            let ScaleFourthPoint = currentProportionPoint(center, endPoint: fourthPoint, scale: scale)
            drawPointAtRect(ScaleFirstPoint, ctx: ctx, color: CHColor(0xF5C604).CGColor)
            drawPointAtRect(ScaleSecondPoint, ctx: ctx, color: CHColor(0x888889).CGColor)
            drawPointAtRect(ScaleThiredPoint, ctx: ctx, color: CHColor(0x339999).CGColor)
            drawPointAtRect(ScaleFourthPoint, ctx: ctx, color: CHColor(0xED7700).CGColor)
            
        }else {
            //第一个点
            drawPointAtRect(firstPoint, ctx: ctx, color: CHColor(0xF5C604).CGColor)
            if self.complete > 0.225 && self.complete < 0.375 {
                //绘制第一条线
                if self.complete < 0.3 {
                    let scale = (self.complete - 0.225) / 0.075
                    drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: firstPoint, endPoint: secondPoint, scale: scale, storkeColor: CHColor(0xF5C604))
                }else {
                    let scale = (0.375 - self.complete) / 0.075
                    drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: secondPoint, endPoint: firstPoint, scale: scale, storkeColor: CHColor(0xF5C604))
                }
            }else if self.complete >= 0.375 {
                //绘制第二个圆
                drawPointAtRect(secondPoint, ctx: ctx, color: CHColor(0x888889).CGColor)
                if self.complete > 0.425 && self.complete < 0.575 {
                    //绘制第二条线
                    if self.complete < 0.5 {
                        let scale = (self.complete - 0.425) / 0.075
                        drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: secondPoint, endPoint: thirdPoint, scale: scale, storkeColor: CHColor(0x888889))
                    }else {
                        let scale = (0.575 - self.complete) / 0.075
                        drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: thirdPoint, endPoint: secondPoint, scale: scale, storkeColor: CHColor(0x888889))
                    }
                }else if self.complete >= 0.575 {
                    //绘制第三个圆
                    drawPointAtRect(thirdPoint, ctx: ctx, color: CHColor(0x339999).CGColor)
                    if self.complete > 0.625 && self.complete < 0.775 {
                        //绘制第三条线
                        if self.complete < 0.7 {
                            let scale = (self.complete - 0.625) / 0.075
                            drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: thirdPoint, endPoint: fourthPoint, scale: scale, storkeColor: CHColor(0x339999))
                        }else {
                            let scale = (0.775 - self.complete) / 0.075
                            drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: fourthPoint, endPoint: thirdPoint, scale: scale, storkeColor: CHColor(0x339999))
                        }
                    }else if self.complete >= 0.775 {
                        //绘制第四个圆
                        drawPointAtRect(fourthPoint, ctx: ctx, color: CHColor(0xED7700).CGColor)
                        if self.complete > 0.825 && self.complete < 0.975 {
                            //绘制第四条线
                            if self.complete < 0.9 {
                                let scale = (self.complete - 0.825) / 0.075
                                drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: fourthPoint, endPoint: firstPoint, scale: scale, storkeColor: CHColor(0xED7700))
                            }else {
                                let scale = (0.975 - self.complete) / 0.075
                                drawLineInContextFromStartPointAndEndPointWithScale(ctx, starPoint: firstPoint, endPoint: fourthPoint, scale: scale, storkeColor: CHColor(0xED7700))
                            }
                        }
                    }
                }
            }
        }
    }

    /**  anmationDelegate */
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if (anim.valueForKey(kName) as! String) == "ScaleSmall"{
            if isAnimationing {
                self.addScaleBigAnimation()
            }
        }else if (anim.valueForKey(kName) as! String) == "ScaleBig"{
            if isAnimationing {
                self.addScaleSmallAnimation()
            }
        }
    }
    
}
