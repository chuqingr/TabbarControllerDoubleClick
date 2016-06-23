//
//  ViewController.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit
import MJRefresh

let SCREEN_BOUNDS:CGRect = UIScreen.mainScreen().bounds
let SCREEN_SIZE:CGSize = UIScreen.mainScreen().bounds.size
let SCREEN_WIDTH:CGFloat = SCREEN_SIZE.width  //屏幕宽度
let SCREEN_HEIGHT:CGFloat = SCREEN_SIZE.height


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.redColor()
        view.addSubview(tableView!)
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView!.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            print("刷新")
            self.tableView?.mj_header.endRefreshing()
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

