//
//  AViewController.swift
//  TabbarControllerDoubleClick
//
//  Created by 杨胜浩 on 16/6/23.
//  Copyright © 2016年 chuqingr. All rights reserved.
//

import UIKit
import MJRefresh

class AViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.redColor()
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT))
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ACell")
//        tableView!.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
//            print("刷新a")
//            self.tableView?.mj_header.endRefreshing()
//        })
        tableView?.mj_header = CHBossHeaderView(refreshingBlock: { 
            print("刷新a")
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                self.tableView!.mj_header.endRefreshing()
                
            })
        })
    }
    
    func beginRefresh() {
        tableView!.mj_header.beginRefreshing()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ACell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
