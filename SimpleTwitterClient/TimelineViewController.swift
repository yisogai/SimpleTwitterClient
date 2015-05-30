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

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onChangeRefreshControlValue:", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    // MARK: - Delegate
    
    // MARK: - Handler
    
    @IBAction func onPressTweetButton(sender: UIBarButtonItem) {
        let tweetVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        self.presentViewController(tweetVC, animated: true, completion: nil)
    }

    func onChangeRefreshControlValue(sender: UIRefreshControl) {
        NSLog("refresh!")
    }
}
