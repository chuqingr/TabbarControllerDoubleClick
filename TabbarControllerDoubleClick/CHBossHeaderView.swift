//
//  CHBossHeaderView.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/24.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit
import MJRefresh

class CHBossHeaderView: MJRefreshHeader {
    let freshLayer = CHFreshLayer()
    
    var refreshing = false
    /**  MARK: -- 监听拖拽比例（空间被拖出来的比例） */
    override var pullingPercent: CGFloat{
        didSet {
            self.mj_y = -self.mj_h * min(1.0, max(0, pullingPercent))
            let complete = min(1.0, max(0.0, pullingPercent - 0.125))
            self.freshLayer.complete = complete
        }
    }
    
    /**  MARK: -- 监听控件刷新状态 */
    override var state: MJRefreshState {
        didSet{
            switch state {
            case .Idle:
                self.refreshing = false
                self.freshLayer.stopAnimation()
            case .Pulling:
                break
            case .Refreshing:
                self.refreshing = true
                self.freshLayer.beginAnimation()
            default:
                break
            }
        }
    }

      /**  MARK: -- 重写方法  父类  MJRefreshHeader*/
    override func prepare() {
        super.prepare()
        /**  设置空间的高度 */
        self.mj_h = 80
    }
    
    deinit {
        self.freshLayer.stopAnimation()
    }
    
     /**  MARK: -- 设置子空间的位置和尺寸 */
    override func placeSubviews() {
        super.placeSubviews()
//        guard let _ = freshLayer else {return}
        freshLayer.frame = self.bounds
        freshLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(freshLayer)

    }
    
     /**  MARK: -- 监听scrollView的contentoffset改变 */
    override func scrollViewContentOffsetDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
     /**  MARK: -- 监听scrollview的contentSize改变 */
    override func scrollViewContentSizeDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentSizeDidChange(change)
    }
     /**  MARK: -- 监听scrollview的拖拽状态改变 */
    override func scrollViewPanStateDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    

//    override func setPullingPercent(pullingPercent:CGFloat) {
//        
//    }
    
    
}
