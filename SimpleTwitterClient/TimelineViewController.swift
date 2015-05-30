//
//  TimelineViewController.swift
//  SimpleTwitterClient
//
//  Created by laishin on 2015/05/30.
//  Copyright (c) 2015年 Re.Ra.Ku co., ltd. All rights reserved.
//

import UIKit
import Social

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onChangeRefreshControlValue:", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressTweetButton(sender: UIBarButtonItem) {
        let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        self.presentViewController(tweetVC, animated: true, completion: nil)
    }

    func onChangeRefreshControlValue(sender: UIRefreshControl) {
        NSLog("refresh!")
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
